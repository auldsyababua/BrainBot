#!/usr/bin/env python3
"""
Multi-Repository DEVLOG.md generator from git history.
Run this script to update the development log with latest commits from all related projects.

Usage:
    python scripts/update-devlog.py [--repo REPO_NAME] [--debug]

This script:
1. Reads git log from multiple related repositories
2. Merges commits by date from all repos
3. Generates formatted DEVLOG.md with repo filtering
4. Includes branch status and statistics per repo
5. Provides interactive filtering by repository

Configuration:
Update the REPOS dictionary below with your project's repositories.
"""

import subprocess
from datetime import datetime
from typing import List, Dict, Tuple, Optional
import sys
import os
import argparse
import json

# Repository configuration
REPOS = {
    "markdown-brain-bot": {
        "path": "/Users/colinaulds/Desktop/projects/markdown-brain-bot",
        "description": "Main backend system with Smart Rails routing",
        "github_url": "https://github.com/auldsyababua/markdown-brain-bot",
    },
    "gpt-parser": {
        "path": "/Users/colinaulds/Desktop/projects/gpt-parser",
        "description": "Early backend attempt with GPT parsing",
        "github_url": "https://github.com/auldsyababua/gpt-parser",
    },
    "bbui": {
        "path": "/Users/colinaulds/Desktop/projects/bbui",
        "description": "Frontend interface for FLRTS system",
        "github_url": "https://github.com/auldsyababua/bbui",
    },
}

# Try to load configuration from .devlog/config.json if it exists
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(script_dir)
config_file = os.path.join(project_root, ".devlog", "config.json")

if os.path.exists(config_file):
    try:
        with open(config_file, "r") as f:
            config = json.load(f)
            if "repositories" in config:
                REPOS = config["repositories"]
    except Exception as e:
        print(f"Warning: Could not load config from {config_file}: {e}")

# Change to project root directory
os.chdir(project_root)


def run_git_command(cmd: str, repo_path: str = None) -> str:
    """Run a git command and return output."""
    try:
        cwd = repo_path if repo_path else os.getcwd()
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True, check=True, cwd=cwd
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        if "--debug" in sys.argv:
            print(f"Git command failed: {cmd} (in {cwd})")
            print(f"Error: {e.stderr}")
        return ""


def get_commit_stats(commit_hash: str, repo_path: str) -> Dict:
    """Get file and line change statistics for a commit."""
    try:
        # Get the number of files changed and insertions/deletions
        # stat_output = run_git_command(
        #     f'git show --stat --format="" {commit_hash}', repo_path
        # )

        # Get the list of changed files with their change counts
        numstat_output = run_git_command(
            f'git show --numstat --format="" {commit_hash}', repo_path
        )

        files_changed = []
        total_insertions = 0
        total_deletions = 0

        # Parse numstat output (format: insertions\tdeletions\tfilename)
        for line in numstat_output.split("\n"):
            if line.strip():
                parts = line.split("\t")
                if len(parts) >= 3:
                    insertions = parts[0] if parts[0] != "-" else "0"
                    deletions = parts[1] if parts[1] != "-" else "0"
                    filename = "\t".join(parts[2:])  # Handle filenames with tabs

                    try:
                        ins_count = int(insertions) if insertions.isdigit() else 0
                        del_count = int(deletions) if deletions.isdigit() else 0

                        files_changed.append(
                            {
                                "filename": filename,
                                "insertions": ins_count,
                                "deletions": del_count,
                                "total_changes": ins_count + del_count,
                            }
                        )

                        total_insertions += ins_count
                        total_deletions += del_count
                    except ValueError:
                        # Handle binary files or other special cases
                        files_changed.append(
                            {
                                "filename": filename,
                                "insertions": 0,
                                "deletions": 0,
                                "total_changes": 0,
                                "binary": True,
                            }
                        )

        return {
            "files_changed": len(files_changed),
            "files_list": files_changed,
            "total_insertions": total_insertions,
            "total_deletions": total_deletions,
            "total_changes": total_insertions + total_deletions,
        }

    except Exception as e:
        if "--debug" in sys.argv:
            print(f"Error getting stats for commit {commit_hash}: {e}")
        return {
            "files_changed": 0,
            "files_list": [],
            "total_insertions": 0,
            "total_deletions": 0,
            "total_changes": 0,
        }


def get_commit_info(filter_repo: Optional[str] = None) -> List[Dict]:
    """Get detailed commit information from git log across all repositories."""
    all_commits = []

    for repo_name, repo_config in REPOS.items():
        # Skip repo if filtering is enabled and this isn't the target repo
        if filter_repo and repo_name != filter_repo:
            continue

        if not os.path.exists(repo_config["path"]):
            if "--debug" in sys.argv:
                print(f"Warning: Repository path not found: {repo_config['path']}")
            continue

        try:
            # Get commit info with hash|date|subject|author format
            log_output = run_git_command(
                'git log --pretty=format:"%H|%ad|%s|%an" --date=iso --reverse',
                repo_config["path"],
            )

            if not log_output:
                if "--debug" in sys.argv:
                    print(f"No commits found in {repo_name}")
                continue

            for line in log_output.split("\n"):
                if "|" in line:
                    parts = line.split("|", 3)
                    if len(parts) == 4:
                        hash_full, date_str, subject, author = parts

                        # Parse date
                        try:
                            commit_date = datetime.fromisoformat(
                                date_str.replace(" -0700", "").replace(" -0800", "")
                            )
                        except ValueError:
                            commit_date = datetime.now()

                        # Get file and line change statistics
                        stats = get_commit_stats(hash_full, repo_config["path"])

                        commit_info = {
                            "hash": hash_full,
                            "hash_short": hash_full[:7],
                            "date": commit_date,
                            "subject": subject,
                            "author": author,
                            "repo": repo_name,
                            "repo_description": repo_config["description"],
                            "github_url": repo_config["github_url"],
                            "stats": stats,
                        }

                        all_commits.append(commit_info)
        except Exception as e:
            if "--debug" in sys.argv:
                print(f"Error processing {repo_name}: {e}")
            continue

    # Sort all commits by date
    all_commits.sort(key=lambda x: x["date"])
    return all_commits


def determine_branch_for_commit(commit_hash: str, repo_path: str = None) -> str:
    """Determine which branch a commit was made on."""
    try:
        # Try to find branch that contains this commit
        branches_with_commit = run_git_command(
            f"git branch --contains {commit_hash}", repo_path
        )

        # Parse branches
        branch_lines = [
            line.strip().replace("* ", "")
            for line in branches_with_commit.split("\n")
            if line.strip()
        ]

        # Prefer feature branches over main
        for branch in branch_lines:
            if branch != "main" and not branch.startswith("(HEAD"):
                return branch

        # Default to main if only main contains it
        return "main"
    except Exception:
        return "main"  # fallback


def categorize_commit(subject: str) -> Tuple[str, str]:
    """Categorize commit by type and return status emoji + description."""
    subject_lower = subject.lower()

    # Merge commits
    if subject_lower.startswith("merge"):
        return "🟢", "PR merge"

    # Feature additions
    if any(
        word in subject_lower for word in ["feat:", "feature:", "add ", "implement"]
    ):
        return "🟢", "Feature implementation"

    # Bug fixes
    if any(word in subject_lower for word in ["fix:", "bug:", "patch:"]):
        return "🟢", "Bug fix"

    # Documentation
    if any(word in subject_lower for word in ["docs:", "doc:", "documentation"]):
        return "🟢", "Documentation"

    # Testing
    if any(word in subject_lower for word in ["test:", "testing"]):
        return "🟢", "Testing framework"

    # Refactoring
    if any(word in subject_lower for word in ["refactor:", "cleanup", "reorganize"]):
        return "🟢", "Architecture refactor"

    # Work in progress
    if any(word in subject_lower for word in ["wip:", "work in progress"]):
        return "🟡", "Work in progress"

    # Default
    return "🟢", "Complete"


def generate_devlog(filter_repo: Optional[str] = None) -> str:
    """Generate the complete DEVLOG.md content."""
    commits = get_commit_info(filter_repo)

    # Group commits by date
    commits_by_date = {}
    for commit in commits:
        date_key = commit["date"].strftime("%Y-%m-%d")
        if date_key not in commits_by_date:
            commits_by_date[date_key] = []
        commits_by_date[date_key].append(commit)

    # Generate header
    now = datetime.now()
    project_title = (
        "Development Ecosystem"
        if not filter_repo
        else f"{filter_repo.title()} Repository"
    )

    devlog_content = f"""# Development Log - {project_title}

> **Auto-Generated**: This file is programmatically updated from git history across all related repositories.
> Last updated: {now.strftime('%Y-%m-%d at %H:%M:%S PST')}

## Project Overview

This development log tracks all commits, features, and milestones across the project ecosystem. Each entry includes:
- **Repository**: Which part of the system (backend/frontend/services)
- **Commit Hash & Date**: Full SHA and timestamp  
- **Branch**: Where the work was done
- **Status**: Merged status and implementation type
- **Description**: What was implemented
- **Author**: Who made the changes

### Repository Structure
"""

    # Add repository links
    for repo_name, repo_config in REPOS.items():
        devlog_content += f"- **[{repo_name}]({repo_config['github_url']})**: {repo_config['description']}\n"

    devlog_content += "\n---\n\n"

    # Generate commits by date (newest first)
    for date_key in sorted(commits_by_date.keys(), reverse=True):
        date_commits = commits_by_date[date_key]

        # Format date header
        date_obj = datetime.strptime(date_key, "%Y-%m-%d")
        devlog_content += f"## {date_obj.strftime('%Y-%m-%d')}\n\n"

        # Add commits for this date (newest first)
        for commit in reversed(date_commits):
            # Get repository-specific information
            repo_name = commit["repo"]
            repo_config = REPOS[repo_name]

            branch = determine_branch_for_commit(commit["hash"], repo_config["path"])
            status_emoji, status_desc = categorize_commit(commit["subject"])

            # Repository badge
            repo_badge = f"**[{repo_name}]({repo_config['github_url']})**"

            # Determine merge status
            if branch == "main":
                branch_status = "✅ *Main branch*"
            else:
                branch_status = f"⚠️ *Branch: {branch}*"

            # Format file changes information
            stats = commit.get("stats", {})
            files_changed = stats.get("files_changed", 0)
            total_insertions = stats.get("total_insertions", 0)
            total_deletions = stats.get("total_deletions", 0)

            # Create change summary
            change_parts = []
            if total_insertions > 0:
                change_parts.append(f"+{total_insertions}")
            if total_deletions > 0:
                change_parts.append(f"-{total_deletions}")

            change_summary = " ".join(change_parts) if change_parts else "No changes"

            # Format files list (show up to 5 files, then "and X more")
            files_list = stats.get("files_list", [])
            files_display = []

            for i, file_info in enumerate(files_list):
                if i >= 5:  # Show only first 5 files
                    remaining = len(files_list) - 5
                    files_display.append(f"*...and {remaining} more files*")
                    break

                filename = file_info["filename"]
                file_insertions = file_info.get("insertions", 0)
                file_deletions = file_info.get("deletions", 0)
                is_binary = file_info.get("binary", False)

                if is_binary:
                    files_display.append(f"  - `{filename}` *(binary)*")
                elif file_insertions == 0 and file_deletions == 0:
                    files_display.append(f"  - `{filename}` *(no changes)*")
                else:
                    file_change_parts = []
                    if file_insertions > 0:
                        file_change_parts.append(f"+{file_insertions}")
                    if file_deletions > 0:
                        file_change_parts.append(f"-{file_deletions}")
                    file_changes = " ".join(file_change_parts)
                    files_display.append(f"  - `{filename}` ({file_changes})")

            files_section = (
                "\\n".join(files_display)
                if files_display
                else "  - *No files modified*"
            )

            devlog_content += f"""### [{commit['hash_short']}] {commit['subject']}
- **Repository**: {repo_badge} - {commit['repo_description']}
- **Date**: {commit['date'].strftime('%Y-%m-%d %H:%M:%S PST')}  
- **Branch**: `{branch}` {branch_status}
- **Author**: {commit['author']}
- **Status**: {status_emoji} {status_desc}
- **Changes**: {files_changed} files changed ({change_summary})
- **Commit**: [`{commit['hash_short']}`]({repo_config['github_url']}/commit/{commit['hash']})

**Files Modified:**
{files_section}

"""

        devlog_content += "---\n\n"

    # Add statistics
    total_commits = len(commits)
    unique_authors = len(set(commit["author"] for commit in commits))

    if commits:
        date_range = f"{commits[0]['date'].strftime('%B %d')}-{commits[-1]['date'].strftime('%d, %Y')}"
    else:
        date_range = "No commits found"

    # Calculate overall file change statistics
    total_files_changed = 0
    total_insertions = 0
    total_deletions = 0
    total_line_changes = 0

    # Repository-specific statistics
    repo_stats = {}
    for commit in commits:
        repo_name = commit["repo"]
        if repo_name not in repo_stats:
            repo_stats[repo_name] = {
                "commits": 0,
                "files_changed": 0,
                "insertions": 0,
                "deletions": 0,
            }

        repo_stats[repo_name]["commits"] += 1

        # Add file change statistics
        stats = commit.get("stats", {})
        files_changed = stats.get("files_changed", 0)
        insertions = stats.get("total_insertions", 0)
        deletions = stats.get("total_deletions", 0)

        repo_stats[repo_name]["files_changed"] += files_changed
        repo_stats[repo_name]["insertions"] += insertions
        repo_stats[repo_name]["deletions"] += deletions

        total_files_changed += files_changed
        total_insertions += insertions
        total_deletions += deletions
        total_line_changes += insertions + deletions

    devlog_content += f"""\n---\n\n## Statistics\n\n- **Total Commits**: {total_commits}
- **Contributors**: {unique_authors}
- **Files Changed**: {total_files_changed}
- **Lines Added**: +{total_insertions:,}
- **Lines Removed**: -{total_deletions:,}
- **Total Line Changes**: {total_line_changes:,}
- **Development Period**: {date_range}
- **Repositories**: {len(repo_stats)}
- **Last Updated**: {now.strftime('%Y-%m-%d %H:%M:%S PST')}

### Repository Breakdown
"""

    for repo_name, stats in sorted(
        repo_stats.items(), key=lambda x: x[1]["commits"], reverse=True
    ):
        repo_config = REPOS[repo_name]
        commit_count = stats["commits"]
        files_changed = stats["files_changed"]
        insertions = stats["insertions"]
        deletions = stats["deletions"]

        change_summary = []
        if insertions > 0:
            change_summary.append(f"+{insertions:,}")
        if deletions > 0:
            change_summary.append(f"-{deletions:,}")
        change_text = " ".join(change_summary) if change_summary else "no line changes"

        devlog_content += f"- **[{repo_name}]({repo_config['github_url']})**: {commit_count} commits, {files_changed} files changed ({change_text}) - {repo_config['description']}\n"

    devlog_content += """
---

*This file is automatically generated from git history across all repositories.*  
*Run `python scripts/update-devlog.py` to refresh all commits.*  
*Run `python scripts/update-devlog.py --repo REPO_NAME` to filter by repository.*
"""

    return devlog_content


def main():
    """Main function to generate and write DEVLOG.md."""
    parser = argparse.ArgumentParser(description="Generate multi-repository DEVLOG.md")
    parser.add_argument(
        "--repo",
        choices=list(REPOS.keys()),
        help="Filter commits to specific repository",
    )
    parser.add_argument("--debug", action="store_true", help="Enable debug output")
    args = parser.parse_args()

    if args.repo:
        print(f"Generating DEVLOG.md for {args.repo} repository...")
    else:
        print("Generating DEVLOG.md from all repositories...")

    try:
        devlog_content = generate_devlog(args.repo)

        # Write to DEVLOG.md
        with open("DEVLOG.md", "w", encoding="utf-8") as f:
            f.write(devlog_content)

        print("✅ DEVLOG.md updated successfully!")
        if args.repo:
            print(f"📊 Filtered to {args.repo} repository commits")
        else:
            print("📊 Includes commits from all repositories:")
            for repo_name, repo_config in REPOS.items():
                if os.path.exists(repo_config["path"]):
                    print(f"   - {repo_name}: {repo_config['description']}")

        print(
            "📝 Run 'git add DEVLOG.md && git commit -m \"docs: update DEVLOG.md\"' to commit changes"
        )

    except Exception as e:
        print(f"❌ Error generating DEVLOG.md: {e}")
        if args.debug:
            import traceback

            traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
