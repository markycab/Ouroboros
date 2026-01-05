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

# Logs
logs/*.log
*.log
!logs/.gitkeep

# Build tracking (keep templates, ignore build outputs)
build_tracking/*.zip
build_tracking/*.exe
build_tracking/*.dmg
build_tracking/*.deb

# OS
.DS_Store
Thumbs.db

# PyInstaller
*.spec.bak
build/
dist/
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
mkdir -p docs
mkdir -p logs
mkdir -p build_tracking

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
from app.utils.logger import setup_logger

# Initialize logger
logger = setup_logger(__name__)


def main():
    """Main function to run the application."""
    logger.info("Application started")
    
    print("Hello from your application!")
    # Add your main application logic here
    
    logger.info("Application finished successfully")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        logger.error(f"Application error: {e}", exc_info=True)
        raise
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

# Create logging configuration
cat > app/utils/logger.py << 'EOF'
"""
Logging configuration for the application.
"""
import logging
import os
from pathlib import Path
from datetime import datetime

# Create logs directory if it doesn't exist
LOGS_DIR = Path(__file__).parent.parent.parent / "logs"
LOGS_DIR.mkdir(exist_ok=True)

# Configure logging format
LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
DATE_FORMAT = "%Y-%m-%d %H:%M:%S"

def setup_logger(name: str, level=logging.INFO):
    """
    Set up a logger with both file and console handlers.
    
    Args:
        name: Logger name (usually __name__)
        level: Logging level (default: INFO)
    
    Returns:
        logging.Logger: Configured logger instance
    """
    logger = logging.getLogger(name)
    logger.setLevel(level)
    
    # Prevent duplicate handlers
    if logger.handlers:
        return logger
    
    # Console handler
    console_handler = logging.StreamHandler()
    console_handler.setLevel(level)
    console_formatter = logging.Formatter(LOG_FORMAT, DATE_FORMAT)
    console_handler.setFormatter(console_formatter)
    
    # File handler - daily log files
    log_file = LOGS_DIR / f"app_{datetime.now().strftime('%Y%m%d')}.log"
    file_handler = logging.FileHandler(log_file)
    file_handler.setLevel(level)
    file_formatter = logging.Formatter(LOG_FORMAT, DATE_FORMAT)
    file_handler.setFormatter(file_formatter)
    
    # Add handlers
    logger.addHandler(console_handler)
    logger.addHandler(file_handler)
    
    return logger


# Example usage:
# from app.utils.logger import setup_logger
# logger = setup_logger(__name__)
# logger.info("Application started")
# logger.error("An error occurred")
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
│   ├── main.py                 # CLI entry point
│   ├── engine/                 # CORE LOGIC (UI-agnostic)
│   │   ├── __init__.py
│   │   ├── workflows.py
│   │   ├── calculations.py
│   │   └── models.py
│   ├── services/               # I/O, DB, filesystem, APIs
│   │   └── __init__.py
│   ├── config/                 # Configuration management
│   │   ├── __init__.py
│   │   └── settings.py
│   └── utils/                  # Utilities and helpers
│       ├── __init__.py
│       └── logger.py           # Logging configuration
├── cli/
│   ├── commands.py             # argparse / typer / click
│   └── formatters.py
├── tests/
│   └── test_example.py
├── docs/                       # Documentation
│   ├── README.md
│   └── ARCHITECTURE.md
├── logs/                       # Application logs (gitignored)
├── build_tracking/             # Build history and tracking
│   ├── BUILD_LOG.md
│   └── VERSION_HISTORY.md
├── pyinstaller/
│   └── app.spec
├── CHANGELOG.md
├── CONTRIBUTING.md
└── pyproject.toml
```

## Getting Started

### Installation

1. Activate your virtual environment (if created):
   ```bash
   source venv/bin/activate  # Linux/macOS
   venv\Scripts\activate     # Windows
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the application:
   ```bash
   python app/main.py
   ```

## Development

### Code Quality

- **Run tests**: `pytest`
- **Format code**: `black app/ cli/ tests/`
- **Lint code**: `flake8 app/ cli/ tests/`
- **Type check**: `mypy app/ cli/`
- **Sort imports**: `isort app/ cli/ tests/`

### Logging

The application uses a centralized logging system. Logs are written to:
- Console (stdout)
- Daily log files in `logs/` directory

Example usage:
```python
from app.utils.logger import setup_logger

logger = setup_logger(__name__)
logger.info("Application started")
logger.error("An error occurred")
```

## Building Executable

To build a standalone executable with PyInstaller:

```bash
pyinstaller pyinstaller/app.spec
```

The executable will be in the `dist/` directory.

### Build Tracking

- Document builds in `build_tracking/BUILD_LOG.md`
- Track versions in `build_tracking/VERSION_HISTORY.md`
- Follow the build checklist before releases

## Documentation

Comprehensive documentation is available in the `docs/` directory:
- **ARCHITECTURE.md** - System design and architecture
- **CHANGELOG.md** - Version history (root directory)
- **CONTRIBUTING.md** - Contribution guidelines (root directory)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

[Specify your license here]

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes.
EOF

# Create documentation files
mkdir -p docs

# Create docs/README.md
cat > docs/README.md << 'EOF'
# Documentation

This directory contains project documentation.

## Contents

- **ARCHITECTURE.md** - System architecture and design decisions
- **API.md** - API documentation (if applicable)
- **CHANGELOG.md** - Version history and changes
- **CONTRIBUTING.md** - Contribution guidelines
- **DEPLOYMENT.md** - Deployment instructions

## Building Documentation

If using Sphinx or MkDocs, add build instructions here.
EOF

# Create ARCHITECTURE.md
cat > docs/ARCHITECTURE.md << 'EOF'
# Architecture

## Overview

Describe the overall architecture of your application.

## Project Structure

```
your_app/
├── app/               # Main application code
│   ├── engine/       # Core business logic (UI-agnostic)
│   ├── services/     # External integrations (DB, APIs, files)
│   ├── config/       # Configuration management
│   └── utils/        # Utility functions
├── cli/              # Command-line interface
├── tests/            # Test suite
└── docs/             # Documentation
```

## Design Principles

- **Separation of Concerns**: UI logic separated from business logic
- **Testability**: Core logic is framework-agnostic
- **Modularity**: Components are loosely coupled

## Key Components

### Engine
Contains the core business logic and workflows that are independent of the UI layer.

### Services
Handles all external interactions:
- Database operations
- File I/O
- API calls
- External service integrations

### Configuration
Centralized configuration management for different environments.

## Data Flow

Describe how data flows through your application.

## Dependencies

List and justify major dependencies.
EOF

# Create CHANGELOG.md
cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project setup
- Project structure created
- Basic configuration files

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.1.0] - YYYY-MM-DD

### Added
- Initial release
EOF

# Create CONTRIBUTING.md
cat > CONTRIBUTING.md << 'EOF'
# Contributing Guidelines

Thank you for considering contributing to this project!

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - System information

### Suggesting Enhancements

1. Check if the enhancement has been suggested
2. Create a new issue describing:
   - The problem you're solving
   - Your proposed solution
   - Alternative solutions considered

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests and linters
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Setup

1. Clone the repository
2. Create a virtual environment: `python -m venv venv`
3. Activate virtual environment
4. Install dependencies: `pip install -r requirements.txt`
5. Install dev dependencies: `pip install -r requirements-dev.txt` (if exists)

## Code Standards

### Python Style Guide

- Follow PEP 8
- Use type hints where appropriate
- Write docstrings for functions and classes
- Maximum line length: 88 characters (Black default)

### Testing

- Write tests for new features
- Maintain or improve code coverage
- Run all tests before submitting PR: `pytest`

### Code Quality

Before submitting, ensure:
- [ ] Tests pass: `pytest`
- [ ] Code is formatted: `black .`
- [ ] Linting passes: `flake8`
- [ ] Type checking passes: `mypy .`
- [ ] Imports are sorted: `isort .`

## Commit Messages

- Use clear and descriptive commit messages
- Start with a verb in present tense (Add, Fix, Update, etc.)
- Reference issue numbers when applicable

Example:
```
Add user authentication feature (#123)

- Implement login/logout endpoints
- Add JWT token generation
- Include unit tests
```

## Code Review Process

1. Maintainers will review your PR
2. Address any requested changes
3. Once approved, your PR will be merged

## Questions?

Feel free to open an issue for any questions or concerns.
EOF

# Create build tracking files
cat > build_tracking/BUILD_LOG.md << 'EOF'
# Build Log

Track your build history and issues here.

## Build History

### Build YYYY-MM-DD HH:MM

- **Status**: Success/Failed
- **Version**: 0.1.0
- **Platform**: Windows/Linux/macOS
- **Builder**: PyInstaller/cx_Freeze/etc.
- **Output Size**: X MB
- **Notes**: 

### Issues Encountered

- Issue 1: Description and resolution
- Issue 2: Description and resolution

## Build Checklist

Before creating a release build:

- [ ] All tests pass
- [ ] Code is properly formatted and linted
- [ ] Version number updated
- [ ] CHANGELOG.md updated
- [ ] Documentation updated
- [ ] Dependencies reviewed and updated
- [ ] Build tested on target platforms
- [ ] Installer/executable tested
- [ ] Release notes prepared

## Build Commands

### Development Build
```bash
# Add your development build command
```

### Production Build
```bash
pyinstaller pyinstaller/app.spec
```

### Testing Build
```bash
# Run the built executable
./dist/app  # or dist\app.exe on Windows
```

## Distribution Notes

- Minimum system requirements
- Known platform-specific issues
- Installation instructions
EOF

# Create version tracking file
cat > build_tracking/VERSION_HISTORY.md << 'EOF'
# Version History

## Version Tracking

| Version | Date | Type | Description |
|---------|------|------|-------------|
| 0.1.0 | YYYY-MM-DD | Initial | Initial release |

## Version Numbering

Following [Semantic Versioning](https://semver.org/):
- MAJOR: Incompatible API changes
- MINOR: Backwards-compatible functionality
- PATCH: Backwards-compatible bug fixes

## Release Process

1. Update version in `app/config/settings.py`
2. Update `CHANGELOG.md`
3. Update this file
4. Create git tag: `git tag -a v0.1.0 -m "Release version 0.1.0"`
5. Build release: `pyinstaller pyinstaller/app.spec`
6. Test executable
7. Push tag: `git push origin v0.1.0`
8. Create GitHub release (if applicable)
EOF

# Create logs .gitkeep
cat > logs/.gitkeep << 'EOF'
# This file ensures the logs directory is tracked by git
# Log files themselves should be in .gitignore
EOF

echo -e "${GREEN}✓ Project structure created${NC}"
echo -e "${GREEN}✓ Starter files generated${NC}"
echo -e "${GREEN}✓ Documentation templates created${NC}"
echo -e "${GREEN}✓ Logging configuration added${NC}"
echo -e "${GREEN}✓ Build tracking templates created${NC}"
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
