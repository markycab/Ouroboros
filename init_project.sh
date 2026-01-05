#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Arrays to store selected packages
SELECTED_PACKAGES=()
DEV_PACKAGES=()

# Clear screen and show banner
clear
echo -e "${CYAN}${BOLD}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║           Python Project Setup Assistant                  ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Function to prompt yes/no questions
prompt_yes_no() {
    local prompt="$1"
    local default="$2"
    
    if [ "$default" = "y" ]; then
        echo -ne "${YELLOW}${prompt} (Y/n): ${NC}"
    else
        echo -ne "${YELLOW}${prompt} (y/N): ${NC}"
    fi
    
    read -r response
    response=${response:-$default}
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to show a menu selection
prompt_select() {
    local prompt="$1"
    shift
    local options=("$@")
    
    echo -e "${YELLOW}${prompt}${NC}"
    PS3="Select option (enter number): "
    select opt in "${options[@]}"; do
        if [ -n "$opt" ]; then
            echo "$opt"
            return 0
        fi
    done
}

echo -e "${GREEN}Let's configure your Python project!${NC}"
echo ""

# ===========================
# Project Type
# ===========================
echo -e "${CYAN}${BOLD}━━━ Project Type ━━━${NC}"
echo ""

PROJECT_TYPE=$(prompt_select "What type of application are you building?" "Console App (CLI)" "Desktop GUI App" "Web App (Backend/API)" "Mobile App" "Library/Package")

echo -e "${GREEN}✓ Project type: ${PROJECT_TYPE}${NC}"
echo ""

# ===========================
# Framework Selection
# ===========================
echo -e "${CYAN}${BOLD}━━━ Framework & Tools ━━━${NC}"
echo ""

case "$PROJECT_TYPE" in
    "Console App (CLI)")
        echo -e "${BLUE}Configuring for Console Application...${NC}"
        
        if prompt_yes_no "Install CLI framework?" "y"; then
            cli_choice=$(prompt_select "Choose your CLI framework:" "click (recommended)" "typer" "argparse (built-in)" "fire" "Skip")
            
            case $cli_choice in
                "click (recommended)")
                    SELECTED_PACKAGES+=("click")
                    echo -e "${GREEN}  → click will be installed${NC}"
                    ;;
                "typer")
                    SELECTED_PACKAGES+=("typer")
                    echo -e "${GREEN}  → typer will be installed${NC}"
                    ;;
                "fire")
                    SELECTED_PACKAGES+=("fire")
                    echo -e "${GREEN}  → fire will be installed${NC}"
                    ;;
                "argparse (built-in)")
                    echo -e "${GREEN}  → Using argparse (no installation needed)${NC}"
                    ;;
            esac
        fi
        
        if prompt_yes_no "Install rich (beautiful terminal output)?" "y"; then
            SELECTED_PACKAGES+=("rich")
            echo -e "${GREEN}  → rich will be installed${NC}"
        fi
        ;;
    
    "Desktop GUI App")
        echo -e "${BLUE}Configuring for Desktop GUI Application...${NC}"
        
        gui_choice=$(prompt_select "Choose your GUI framework:" "tkinter (built-in)" "PyQt5" "PyQt6" "PySide6" "Kivy" "Skip")
        
        case $gui_choice in
            "PyQt5")
                SELECTED_PACKAGES+=("PyQt5")
                echo -e "${GREEN}  → PyQt5 will be installed${NC}"
                ;;
            "PyQt6")
                SELECTED_PACKAGES+=("PyQt6")
                echo -e "${GREEN}  → PyQt6 will be installed${NC}"
                ;;
            "PySide6")
                SELECTED_PACKAGES+=("PySide6")
                echo -e "${GREEN}  → PySide6 will be installed${NC}"
                ;;
            "Kivy")
                SELECTED_PACKAGES+=("kivy")
                echo -e "${GREEN}  → Kivy will be installed${NC}"
                ;;
            "tkinter (built-in)")
                echo -e "${GREEN}  → Using tkinter (no installation needed)${NC}"
                ;;
        esac
        
        if prompt_yes_no "Do you need to create standalone executables?" "y"; then
            echo -e "${BLUE}  ✓ Executable builder selected${NC}"
            
            builder_choice=$(prompt_select "Choose your executable builder:" "PyInstaller" "cx_Freeze" "py2exe (Windows only)" "Skip")
            
            case $builder_choice in
                "PyInstaller")
                    SELECTED_PACKAGES+=("pyinstaller")
                    echo -e "${GREEN}  → PyInstaller will be installed${NC}"
                    ;;
                "cx_Freeze")
                    SELECTED_PACKAGES+=("cx-Freeze")
                    echo -e "${GREEN}  → cx_Freeze will be installed${NC}"
                    ;;
                "py2exe (Windows only)")
                    SELECTED_PACKAGES+=("py2exe")
                    echo -e "${GREEN}  → py2exe will be installed${NC}"
                    ;;
            esac
        fi
        ;;
    
    "Web App (Backend/API)")
        echo -e "${BLUE}Configuring for Web Application...${NC}"
        
        web_choice=$(prompt_select "Choose your web framework:" "FastAPI (modern, async)" "Flask (lightweight)" "Django (full-featured)" "Sanic (async)" "Skip")
        
        case $web_choice in
            "FastAPI (modern, async)")
                SELECTED_PACKAGES+=("fastapi" "uvicorn[standard]" "pydantic")
                echo -e "${GREEN}  → FastAPI, Uvicorn, and Pydantic will be installed${NC}"
                
                if prompt_yes_no "  Install SQLAlchemy (ORM)?" "y"; then
                    SELECTED_PACKAGES+=("sqlalchemy")
                    echo -e "${GREEN}  → SQLAlchemy will be installed${NC}"
                fi
                ;;
            "Flask (lightweight)")
                SELECTED_PACKAGES+=("flask")
                echo -e "${GREEN}  → Flask will be installed${NC}"
                
                if prompt_yes_no "  Install Flask-SQLAlchemy?" "n"; then
                    SELECTED_PACKAGES+=("flask-sqlalchemy")
                    echo -e "${GREEN}  → Flask-SQLAlchemy will be installed${NC}"
                fi
                
                if prompt_yes_no "  Install Flask-CORS?" "n"; then
                    SELECTED_PACKAGES+=("flask-cors")
                    echo -e "${GREEN}  → Flask-CORS will be installed${NC}"
                fi
                ;;
            "Django (full-featured)")
                SELECTED_PACKAGES+=("django")
                echo -e "${GREEN}  → Django will be installed${NC}"
                
                if prompt_yes_no "  Install Django REST framework?" "y"; then
                    SELECTED_PACKAGES+=("djangorestframework")
                    echo -e "${GREEN}  → Django REST framework will be installed${NC}"
                fi
                ;;
            "Sanic (async)")
                SELECTED_PACKAGES+=("sanic")
                echo -e "${GREEN}  → Sanic will be installed${NC}"
                ;;
        esac
        ;;
    
    "Mobile App")
        echo -e "${BLUE}Configuring for Mobile Application...${NC}"
        
        mobile_choice=$(prompt_select "Choose your mobile framework:" "Kivy (cross-platform)" "BeeWare (native UI)" "PyQt for Android" "Skip")
        
        case $mobile_choice in
            "Kivy (cross-platform)")
                SELECTED_PACKAGES+=("kivy" "buildozer")
                echo -e "${GREEN}  → Kivy and Buildozer will be installed${NC}"
                echo -e "${YELLOW}  ⚠ Note: Buildozer requires Linux/macOS for Android builds${NC}"
                ;;
            "BeeWare (native UI)")
                SELECTED_PACKAGES+=("briefcase")
                echo -e "${GREEN}  → BeeWare Briefcase will be installed${NC}"
                ;;
            "PyQt for Android")
                SELECTED_PACKAGES+=("PyQt5" "python-for-android")
                echo -e "${GREEN}  → PyQt5 and python-for-android will be installed${NC}"
                ;;
        esac
        ;;
    
    "Library/Package")
        echo -e "${BLUE}Configuring for Python Library/Package...${NC}"
        
        if prompt_yes_no "Setup package build tools?" "y"; then
            SELECTED_PACKAGES+=("build" "twine")
            echo -e "${GREEN}  → build and twine will be installed${NC}"
        fi
        
        if prompt_yes_no "Install setuptools-scm (version from git)?" "n"; then
            SELECTED_PACKAGES+=("setuptools-scm")
            echo -e "${GREEN}  → setuptools-scm will be installed${NC}"
        fi
        ;;
esac

# ===========================
# Additional Production Packages
# ===========================
echo ""
echo -e "${CYAN}${BOLD}━━━ Additional Production Packages ━━━${NC}"
echo ""

# Data Visualization & Plotting (smart defaults based on project type)
DATA_VIZ_DEFAULT="n"
if [[ "$PROJECT_TYPE" == "Console App (CLI)" || "$PROJECT_TYPE" == "Desktop GUI App" ]]; then
    DATA_VIZ_DEFAULT="y"
fi

if prompt_yes_no "Do you need data visualization/plotting capabilities?" "$DATA_VIZ_DEFAULT"; then
    echo -e "${BLUE}  ✓ Plotting libraries selected${NC}"
    
    if prompt_yes_no "  Install matplotlib?" "y"; then
        SELECTED_PACKAGES+=("matplotlib")
        echo -e "${GREEN}  → matplotlib will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install seaborn (statistical visualization)?" "n"; then
        SELECTED_PACKAGES+=("seaborn")
        echo -e "${GREEN}  → seaborn will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install plotly (interactive plots)?" "n"; then
        SELECTED_PACKAGES+=("plotly")
        echo -e "${GREEN}  → plotly will be installed${NC}"
    fi
fi

echo ""

# Data Processing Libraries
DATA_PROC_DEFAULT="n"
if [[ "$PROJECT_TYPE" == "Console App (CLI)" || "$PROJECT_TYPE" == "Desktop GUI App" || "$PROJECT_TYPE" == "Web App (Backend/API)" ]]; then
    DATA_PROC_DEFAULT="y"
fi

if prompt_yes_no "Do you need data processing libraries?" "$DATA_PROC_DEFAULT"; then
    echo -e "${BLUE}  ✓ Data processing libraries selected${NC}"
    
    if prompt_yes_no "  Install pandas (data manipulation)?" "y"; then
        SELECTED_PACKAGES+=("pandas")
        echo -e "${GREEN}  → pandas will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install numpy (numerical computing)?" "y"; then
        SELECTED_PACKAGES+=("numpy")
        echo -e "${GREEN}  → numpy will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install openpyxl (Excel files)?" "n"; then
        SELECTED_PACKAGES+=("openpyxl")
        echo -e "${GREEN}  → openpyxl will be installed${NC}"
    fi
fi

echo ""

# Additional Utilities
if prompt_yes_no "Do you need additional utilities?" "n"; then
    
    if prompt_yes_no "  Install requests (HTTP library)?" "n"; then
        SELECTED_PACKAGES+=("requests")
        echo -e "${GREEN}  → requests will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install python-dotenv (environment variables)?" "n"; then
        SELECTED_PACKAGES+=("python-dotenv")
        echo -e "${GREEN}  → python-dotenv will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install loguru (enhanced logging)?" "n"; then
        SELECTED_PACKAGES+=("loguru")
        echo -e "${GREEN}  → loguru will be installed${NC}"
    fi
    
    # Show Pydantic only if not already selected with FastAPI
    if [[ ! " ${SELECTED_PACKAGES[@]} " =~ " pydantic " ]]; then
        if prompt_yes_no "  Install pydantic (data validation)?" "n"; then
            SELECTED_PACKAGES+=("pydantic")
            echo -e "${GREEN}  → pydantic will be installed${NC}"
        fi
    fi
fi

# ===========================
# Development Packages
# ===========================
echo ""
echo -e "${CYAN}${BOLD}━━━ Development Packages ━━━${NC}"
echo ""

if prompt_yes_no "Will you write tests for your project?" "y"; then
    echo -e "${BLUE}  ✓ Testing framework selected${NC}"
    
    test_choice=$(prompt_select "Choose your testing framework:" "pytest (recommended)" "unittest (built-in)" "nose2" "Skip")
    
    case $test_choice in
        "pytest (recommended)")
            DEV_PACKAGES+=("pytest" "pytest-cov")
            echo -e "${GREEN}  → pytest and pytest-cov will be installed${NC}"
            
            if prompt_yes_no "  Install pytest-mock?" "n"; then
                DEV_PACKAGES+=("pytest-mock")
                echo -e "${GREEN}  → pytest-mock will be installed${NC}"
            fi
            ;;
        "nose2")
            DEV_PACKAGES+=("nose2")
            echo -e "${GREEN}  → nose2 will be installed${NC}"
            ;;
        "unittest (built-in)")
            echo -e "${GREEN}  → Using unittest (no installation needed)${NC}"
            ;;
    esac
fi

# ===========================
# Type Checking
# ===========================
echo ""
echo -e "${CYAN}${BOLD}━━━ Type Checking ━━━${NC}"
echo ""

if prompt_yes_no "Do you want static type checking?" "y"; then
    echo -e "${BLUE}  ✓ Type checker selected${NC}"
    
    type_choice=$(prompt_select "Choose your type checker:" "mypy (recommended)" "pyright" "pyre-check" "Skip")
    
    case $type_choice in
        "mypy (recommended)")
            DEV_PACKAGES+=("mypy")
            echo -e "${GREEN}  → mypy will be installed${NC}"
            ;;
        "pyright")
            DEV_PACKAGES+=("pyright")
            echo -e "${GREEN}  → pyright will be installed${NC}"
            ;;
        "pyre-check")
            DEV_PACKAGES+=("pyre-check")
            echo -e "${GREEN}  → pyre-check will be installed${NC}"
            ;;
    esac
fi

# ===========================
# Code Linting & Formatting
# ===========================
echo ""
echo -e "${CYAN}${BOLD}━━━ Code Linting & Formatting ━━━${NC}"
echo ""

if prompt_yes_no "Do you want code linting and formatting tools?" "y"; then
    echo -e "${BLUE}  ✓ Linting tools selected${NC}"
    
    if prompt_yes_no "  Install black (code formatter)?" "y"; then
        DEV_PACKAGES+=("black")
        echo -e "${GREEN}  → black will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install flake8 (linter)?" "y"; then
        DEV_PACKAGES+=("flake8")
        echo -e "${GREEN}  → flake8 will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install pylint (linter)?" "n"; then
        DEV_PACKAGES+=("pylint")
        echo -e "${GREEN}  → pylint will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install isort (import sorter)?" "y"; then
        DEV_PACKAGES+=("isort")
        echo -e "${GREEN}  → isort will be installed${NC}"
    fi
    
    if prompt_yes_no "  Install autopep8 (PEP8 formatter)?" "n"; then
        DEV_PACKAGES+=("autopep8")
        echo -e "${GREEN}  → autopep8 will be installed${NC}"
    fi
fi

# ===========================
# Virtual Environment Setup
# ===========================
echo ""
echo -e "${CYAN}${BOLD}━━━ Virtual Environment ━━━${NC}"
echo ""

CREATE_VENV=false
VENV_NAME="venv"

if prompt_yes_no "Do you want to create a virtual environment?" "y"; then
    CREATE_VENV=true
    echo -ne "${YELLOW}Virtual environment name (default: venv): ${NC}"
    read -r venv_input
    if [ -n "$venv_input" ]; then
        VENV_NAME="$venv_input"
    fi
    echo -e "${GREEN}  → Virtual environment '$VENV_NAME' will be created${NC}"
fi

# ===========================
# Initialize Git
# ===========================
echo ""
echo -e "${CYAN}${BOLD}━━━ Version Control ━━━${NC}"
echo ""

INIT_GIT=false
if prompt_yes_no "Initialize git repository?" "y"; then
    INIT_GIT=true
    echo -e "${GREEN}  → Git repository will be initialized${NC}"
fi

# ===========================
# Summary
# ===========================
echo ""
echo -e "${MAGENTA}${BOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}${BOLD}║                    Installation Summary                   ║${NC}"
echo -e "${MAGENTA}${BOLD}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

if [ ${#SELECTED_PACKAGES[@]} -gt 0 ]; then
    echo -e "${CYAN}Production packages:${NC}"
    for pkg in "${SELECTED_PACKAGES[@]}"; do
        echo -e "  ${GREEN}•${NC} $pkg"
    done
    echo ""
fi

if [ ${#DEV_PACKAGES[@]} -gt 0 ]; then
    echo -e "${CYAN}Development packages:${NC}"
    for pkg in "${DEV_PACKAGES[@]}"; do
        echo -e "  ${YELLOW}•${NC} $pkg"
    done
    echo ""
fi

if [ ${#SELECTED_PACKAGES[@]} -eq 0 ] && [ ${#DEV_PACKAGES[@]} -eq 0 ]; then
    echo -e "${YELLOW}No packages selected for installation${NC}"
    echo ""
fi

# ===========================
# Confirmation
# ===========================
echo ""
if ! prompt_yes_no "Proceed with installation?" "y"; then
    echo -e "${RED}Installation cancelled.${NC}"
    exit 0
fi

# ===========================
# Installation Process
# ===========================
echo ""
echo -e "${GREEN}${BOLD}Starting installation...${NC}"
echo ""

# Create virtual environment
if [ "$CREATE_VENV" = true ]; then
    echo -e "${BLUE}Creating virtual environment '$VENV_NAME'...${NC}"
    python -m venv "$VENV_NAME"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Virtual environment created successfully${NC}"
        
        # Activate virtual environment
        if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
            source "$VENV_NAME/Scripts/activate"
        else
            source "$VENV_NAME/bin/activate"
        fi
        echo -e "${GREEN}✓ Virtual environment activated${NC}"
    else
        echo -e "${RED}✗ Failed to create virtual environment${NC}"
        exit 1
    fi
    echo ""
fi

# Upgrade pip
echo -e "${BLUE}Upgrading pip...${NC}"
python -m pip install --upgrade pip
echo ""

# Install production packages
if [ ${#SELECTED_PACKAGES[@]} -gt 0 ]; then
    echo -e "${BLUE}Installing production packages...${NC}"
    pip install "${SELECTED_PACKAGES[@]}"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Production packages installed successfully${NC}"
    else
        echo -e "${RED}✗ Failed to install some production packages${NC}"
    fi
    echo ""
fi

# Install development packages
if [ ${#DEV_PACKAGES[@]} -gt 0 ]; then
    echo -e "${BLUE}Installing development packages...${NC}"
    pip install "${DEV_PACKAGES[@]}"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Development packages installed successfully${NC}"
    else
        echo -e "${RED}✗ Failed to install some development packages${NC}"
    fi
    echo ""
fi

# Create requirements.txt
echo -e "${BLUE}Creating requirements.txt...${NC}"
pip freeze > requirements.txt
echo -e "${GREEN}✓ requirements.txt created${NC}"
echo ""

# Initialize git
if [ "$INIT_GIT" = true ]; then
    echo -e "${BLUE}Initializing git repository...${NC}"
    git init
    
    # Create .gitignore
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
venv/
env/
ENV/
.venv

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Testing
.pytest_cache/
.coverage
htmlcov/
.tox/

# MyPy
.mypy_cache/
.dmypy.json
dmypy.json

# Environment variables
.env
.env.local

# OS
.DS_Store
Thumbs.db
EOF
    
    echo -e "${GREEN}✓ Git repository initialized${NC}"
    echo -e "${GREEN}✓ .gitignore created${NC}"
    echo ""
fi

# ===========================
# Create Project Structure
# ===========================
echo -e "${BLUE}Creating project folder structure...${NC}"

# Create main directories
mkdir -p app/engine
mkdir -p app/services
mkdir -p app/config
mkdir -p app/utils
mkdir -p cli
mkdir -p tests
mkdir -p pyinstaller

# Create __init__.py files
touch app/__init__.py
touch app/engine/__init__.py
touch app/services/__init__.py
touch app/config/__init__.py
touch app/utils/__init__.py
touch cli/__init__.py
touch tests/__init__.py

# Create main.py in app
cat > app/main.py << 'EOF'
"""
Main entry point for the application.
CLI entry point - handles command-line interface.
"""

def main():
    """Main function to run the application."""
    print("Hello from your application!")
    # Add your main application logic here


if __name__ == "__main__":
    main()
EOF

# Create engine files
cat > app/engine/workflows.py << 'EOF'
"""
Core workflow logic.
UI-agnostic business logic and workflows.
"""

# Add your workflow logic here
EOF

cat > app/engine/calculations.py << 'EOF'
"""
Calculation and computational logic.
Pure functions for business calculations.
"""

# Add your calculation functions here
EOF

cat > app/engine/models.py << 'EOF'
"""
Data models and business entities.
Core domain models for the application.
"""

# Add your data models here
EOF

# Create services __init__.py with example
cat > app/services/__init__.py << 'EOF'
"""
Services for I/O, database, filesystem, and API operations.
This package handles all external interactions.
"""

# Example services:
# - database.py: Database operations
# - file_io.py: File system operations
# - api_client.py: External API calls
EOF

# Create config files
cat > app/config/__init__.py << 'EOF'
"""
Configuration management for the application.
"""

# Add your configuration classes here
EOF

cat > app/config/settings.py << 'EOF'
"""
Application settings and configuration.
"""

# Example configuration
APP_NAME = "Your Application"
VERSION = "0.1.0"
DEBUG = False

# Add more configuration variables as needed
EOF

# Create utils
cat > app/utils/__init__.py << 'EOF'
"""
Utility functions and helpers.
"""

# Add your utility functions here
EOF

# Create CLI files
cat > cli/commands.py << 'EOF'
"""
Command-line interface commands.
Use argparse, typer, or click for CLI handling.
"""

# Example using argparse:
# import argparse
# 
# def create_parser():
#     parser = argparse.ArgumentParser(description="Your application CLI")
#     parser.add_argument('--version', action='version', version='0.1.0')
#     return parser
EOF

cat > cli/formatters.py << 'EOF'
"""
Output formatters for CLI.
Handles formatting of CLI output.
"""

# Add your formatter functions here
EOF

# Create test example
cat > tests/test_example.py << 'EOF'
"""
Example test file.
"""

def test_example():
    """Example test case."""
    assert True, "This is an example test"

# Add your test cases here
EOF

# Create PyInstaller spec file
cat > pyinstaller/app.spec << 'EOF'
# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

a = Analysis(
    ['../app/main.py'],
    pathex=[],
    binaries=[],
    datas=[],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='app',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
EOF

# Create pyproject.toml
cat > pyproject.toml << 'EOF'
[build-system]
requires = ["setuptools>=45", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "your-app"
version = "0.1.0"
description = "Your application description"
readme = "README.md"
requires-python = ">=3.8"
authors = [
    {name = "Your Name", email = "your.email@example.com"}
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "black>=22.0",
    "flake8>=4.0",
    "mypy>=0.950",
]

[tool.black]
line-length = 88
target-version = ['py38', 'py39', 'py310', 'py311']

[tool.isort]
profile = "black"
line_length = 88

[tool.mypy]
python_version = "3.8"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_functions = "test_*"
EOF

# Create README.md
cat > README.md << 'EOF'
# Your Application

## Project Structure

```
your_app/
├── app/
│   ├── __init__.py
│   ├── main.py              # CLI entry point
│   ├── engine/              # CORE LOGIC (UI-agnostic)
│   │   ├── __init__.py
│   │   ├── workflows.py
│   │   ├── calculations.py
│   │   └── models.py
│   ├── services/            # I/O, DB, filesystem, APIs
│   ├── config/
│   └── utils/
├── cli/
│   ├── commands.py          # argparse / typer / click
│   └── formatters.py
├── tests/
├── pyinstaller/
│   └── app.spec
└── pyproject.toml
```

## Getting Started

1. Activate your virtual environment (if created)
2. Install dependencies: `pip install -r requirements.txt`
3. Run the application: `python app/main.py`

## Development

- Run tests: `pytest`
- Format code: `black app/ cli/ tests/`
- Lint code: `flake8 app/ cli/ tests/`
- Type check: `mypy app/ cli/`

## Building Executable

To build a standalone executable with PyInstaller:

```bash
pyinstaller pyinstaller/app.spec
```

The executable will be in the `dist/` directory.
EOF

echo -e "${GREEN}✓ Project structure created${NC}"
echo -e "${GREEN}✓ Starter files generated${NC}"
echo ""

# ===========================
# Completion
# ===========================
echo ""
echo -e "${GREEN}${BOLD}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}${BOLD}║                  Setup Complete! 🎉                       ║${NC}"
echo -e "${GREEN}${BOLD}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

if [ "$CREATE_VENV" = true ]; then
    echo -e "${CYAN}Next steps:${NC}"
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        echo -e "  1. Activate your virtual environment: ${YELLOW}source $VENV_NAME/Scripts/activate${NC}"
    else
        echo -e "  1. Activate your virtual environment: ${YELLOW}source $VENV_NAME/bin/activate${NC}"
    fi
    echo -e "  2. Start coding! 🚀"
else
    echo -e "${CYAN}Next steps:${NC}"
    echo -e "  1. Start coding! 🚀"
fi

echo ""
echo -e "${BLUE}Happy coding!${NC}"
echo ""
