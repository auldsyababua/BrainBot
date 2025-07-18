import os
import re
from datetime import datetime
from pathlib import Path
from typing import Optional, Dict, Any, List
import yaml

from config import NOTES_FOLDER, INDEX_FILE, README_FILE


def sanitize_filename(filename: str) -> str:
    """Convert a string into a valid filename."""
    # Remove or replace invalid characters
    filename = re.sub(r'[<>:"/\\|?*]', '', filename)
    filename = filename.strip('. ')
    # Replace spaces with hyphens
    filename = filename.replace(' ', '-').lower()
    # Ensure it ends with .md
    if not filename.endswith('.md'):
        filename += '.md'
    return filename


def parse_frontmatter(content: str) -> tuple[Dict[str, Any], str]:
    """Parse YAML frontmatter from markdown content."""
    if content.startswith('---\n'):
        try:
            # Find the closing ---
            end = content.find('\n---\n', 4)
            if end != -1:
                frontmatter_str = content[4:end]
                body = content[end + 5:]
                frontmatter = yaml.safe_load(frontmatter_str) or {}
                return frontmatter, body
        except yaml.YAMLError:
            pass
    return {}, content


def create_frontmatter(title: str, doc_type: str = "note", tags: List[str] = None) -> str:
    """Create YAML frontmatter for a markdown file."""
    frontmatter = {
        'title': title,
        'type': doc_type,
        'created': datetime.now().strftime('%Y-%m-%d'),
        'updated': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    }
    if tags:
        frontmatter['tags'] = tags
    
    yaml_str = yaml.dump(frontmatter, default_flow_style=False, allow_unicode=True)
    return f"---\n{yaml_str}---\n\n"


def ensure_index_exists():
    """Ensure the global index.md exists."""
    index_path = Path(NOTES_FOLDER) / INDEX_FILE
    if not index_path.exists():
        content = "# 📚 Markdown Brain Index\n\n"
        content += "This is the global index of all notes and folders in the system.\n\n"
        content += "## 📁 Folders\n\n"
        content += "_No folders yet_\n\n"
        content += "## 📄 Notes\n\n"
        content += "_No notes yet_\n\n"
        index_path.write_text(content, encoding='utf-8')


def update_index(file_path: str, title: str, summary: str = ""):
    """Update the global index with a new or updated file."""
    ensure_index_exists()
    index_path = Path(NOTES_FOLDER) / INDEX_FILE
    content = index_path.read_text(encoding='utf-8')
    
    # Determine relative path from notes folder
    rel_path = Path(file_path).relative_to(Path(NOTES_FOLDER))
    link = f"[{title}]({rel_path})"
    
    # Check if it's a folder or file
    if rel_path.parent != Path('.'):
        # It's in a subfolder
        folder_name = rel_path.parts[0]
        
        # Update folders section if needed
        if f"[{folder_name}]" not in content:
            content = content.replace(
                "_No folders yet_",
                f"- [{folder_name}]({folder_name}/) - Contains various notes\n_No folders yet_"
            )
            content = content.replace("\n_No folders yet_", "")
    
    # Update notes section
    if link not in content:
        entry = f"- {link}"
        if summary:
            entry += f" - {summary}"
        entry += "\n"
        
        content = content.replace("_No notes yet_", entry + "_No notes yet_")
        content = content.replace("\n_No notes yet_", "")
        
        index_path.write_text(content, encoding='utf-8')


def update_folder_readme(folder_path: str):
    """Create or update README.md in a folder."""
    readme_path = Path(NOTES_FOLDER) / folder_path / README_FILE
    folder_name = Path(folder_path).name
    
    # Get all markdown files in the folder
    folder_full_path = Path(NOTES_FOLDER) / folder_path
    md_files = list(folder_full_path.glob('*.md'))
    md_files = [f for f in md_files if f.name != README_FILE]
    
    content = f"# 📁 {folder_name.title()}\n\n"
    content += f"This folder contains notes related to {folder_name}.\n\n"
    content += "## 📄 Contents\n\n"
    
    if md_files:
        for file in sorted(md_files):
            # Try to get title from frontmatter
            try:
                file_content = file.read_text(encoding='utf-8')
                frontmatter, _ = parse_frontmatter(file_content)
                title = frontmatter.get('title', file.stem)
            except:
                title = file.stem
            
            content += f"- [{title}]({file.name})\n"
    else:
        content += "_No files yet_\n"
    
    content += f"\n_Last updated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}_\n"
    readme_path.write_text(content, encoding='utf-8')


def create_file(title: str, content: str, folder: Optional[str] = None, 
                doc_type: str = "note", tags: List[str] = None) -> str:
    """Create a new markdown file."""
    filename = sanitize_filename(title)
    
    # Determine file path
    if folder:
        folder_path = Path(NOTES_FOLDER) / folder
        folder_path.mkdir(parents=True, exist_ok=True)
        file_path = folder_path / filename
    else:
        file_path = Path(NOTES_FOLDER) / filename
    
    # Add frontmatter
    full_content = create_frontmatter(title, doc_type, tags) + content
    
    # Write file
    file_path.write_text(full_content, encoding='utf-8')
    
    # Update indices
    update_index(str(file_path), title, content.split('\n')[0][:100])
    if folder:
        update_folder_readme(folder)
    
    return str(file_path)


def append_to_file(file_path: str, new_content: str) -> str:
    """Append content to an existing markdown file."""
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"File {file_path} not found")
    
    # Read existing content
    content = path.read_text(encoding='utf-8')
    frontmatter, body = parse_frontmatter(content)
    
    # Update frontmatter
    frontmatter['updated'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    # Reconstruct file
    yaml_str = yaml.dump(frontmatter, default_flow_style=False, allow_unicode=True)
    full_content = f"---\n{yaml_str}---\n\n{body}\n{new_content}"
    
    # Write back
    path.write_text(full_content, encoding='utf-8')
    
    return str(path)


def read_file(file_path: str) -> str:
    """Read content from a markdown file."""
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"File {file_path} not found")
    
    content = path.read_text(encoding='utf-8')
    _, body = parse_frontmatter(content)
    return body


def search_files(query: str) -> List[Dict[str, str]]:
    """Search for files containing the query string."""
    results = []
    notes_path = Path(NOTES_FOLDER)
    
    for file_path in notes_path.rglob('*.md'):
        if file_path.name in [INDEX_FILE, README_FILE]:
            continue
            
        try:
            content = file_path.read_text(encoding='utf-8')
            frontmatter, body = parse_frontmatter(content)
            
            # Search in title, content, and tags
            searchable = f"{frontmatter.get('title', '')} {body} {' '.join(frontmatter.get('tags', []))}"
            
            if query.lower() in searchable.lower():
                results.append({
                    'path': str(file_path),
                    'title': frontmatter.get('title', file_path.stem),
                    'snippet': body[:200] + '...' if len(body) > 200 else body
                })
        except Exception:
            continue
    
    return results


def list_all_files() -> List[Dict[str, str]]:
    """List all markdown files in the system."""
    files = []
    notes_path = Path(NOTES_FOLDER)
    
    for file_path in notes_path.rglob('*.md'):
        if file_path.name in [INDEX_FILE, README_FILE]:
            continue
            
        try:
            content = file_path.read_text(encoding='utf-8')
            frontmatter, _ = parse_frontmatter(content)
            
            files.append({
                'path': str(file_path),
                'title': frontmatter.get('title', file_path.stem),
                'type': frontmatter.get('type', 'note'),
                'created': frontmatter.get('created', 'unknown')
            })
        except Exception:
            continue
    
    return sorted(files, key=lambda x: x['created'], reverse=True)