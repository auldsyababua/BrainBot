# Installation Guide for Open Source Document Processing

## System Dependencies

### macOS
```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required system packages
brew install tesseract
brew install poppler
brew install libmagic
brew install pandoc
```

### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install -y \
    tesseract-ocr \
    poppler-utils \
    libmagic1 \
    pandoc \
    python3-dev \
    libxml2-dev \
    libxslt1-dev
```

### Windows
```powershell
# Install Chocolatey first, then:
choco install tesseract
choco install poppler
choco install pandoc

# Or download installers:
# Tesseract: https://github.com/UB-Mannheim/tesseract/wiki
# Poppler: https://blog.alivate.com.au/poppler-windows/
```

## Python Setup

### 1. Create Virtual Environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 2. Install Basic Requirements
```bash
# Minimal installation
pip install unstructured pypdf sentence-transformers upstash-vector python-dotenv

# Full installation with all document types
pip install "unstructured[all-docs]"
```

### 3. Set Up Environment Variables
```bash
# Create .env file
cat > .env << EOF
UPSTASH_VECTOR_REST_URL=your_upstash_url_here
UPSTASH_VECTOR_REST_TOKEN=your_upstash_token_here
EOF
```

## Quick Test

```python
# test_setup.py
from unstructured.partition.auto import partition

# Test basic functionality
elements = partition(filename="test.pdf")
print(f"Extracted {len(elements)} elements")

# Test with a specific strategy
elements = partition(
    filename="test.pdf",
    strategy="hi_res",  # Better quality
    infer_table_structure=True
)

for element in elements[:5]:
    print(f"{element.category}: {element.text[:50]}...")
```

## Troubleshooting

### "Tesseract not found"
```bash
# Add to your script or shell profile:
export TESSDATA_PREFIX=/usr/local/share/tessdata  # Mac
# or
export TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata  # Linux
```

### "Magic not found" (Windows)
```python
# Add to your script:
import platform
if platform.system() == "Windows":
    import magic
    magic.Magic(magic_file="C:/path/to/magic.mgc")
```

### Slow processing
```python
# Use "fast" strategy for quicker results:
elements = partition(filename="doc.pdf", strategy="fast")

# Or process in parallel:
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

def process_file(file_path):
    return partition(filename=str(file_path), strategy="fast")

files = list(Path("documents").glob("*.pdf"))
with ProcessPoolExecutor() as executor:
    results = list(executor.map(process_file, files))
```

## Memory Issues with Large PDFs

```python
# Process in chunks
from unstructured.partition.pdf import partition_pdf

# Process specific page ranges
for start_page in range(0, total_pages, 10):
    elements = partition_pdf(
        filename="large_document.pdf",
        starting_page_number=start_page,
        page_number_limit=10
    )
    # Process these elements before moving to next chunk
```