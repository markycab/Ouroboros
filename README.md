# Python Project Setup Assistant

An interactive, bash script for quickly scaffolding production-ready Python projects with intelligent defaults based on project type.

## 🎯 Features

- **Interactive Setup** - Beautiful, colorful CLI with guided prompts
- **Project Type Detection** - Smart defaults based on whether you're building:
  - Console Applications (CLI)
  - Desktop GUI Applications
  - Web Applications (Backend/API)
  - Mobile Applications
  - Python Libraries/Packages
- **Intelligent Package Selection** - Context-aware recommendations for frameworks and tools
- **Complete Project Structure** - Automatically generates a well-organized folder hierarchy
- **Development Tools** - Testing, linting, formatting, and type checking setup
- **Documentation Templates** - Ready-to-use docs, changelog, and contributing guidelines
- **Logging Infrastructure** - Pre-configured logging system with daily log rotation
- **Build Tracking** - Templates for tracking builds, versions, and releases
- **Virtual Environment** - Optional venv creation and activation
- **Git Integration** - Repository initialization with comprehensive .gitignore

## 🚀 Quick Start

1. **Clone or download** this repository
2. **Navigate** to the directory:

   ```bash
   cd Ouroboros
   ```

3. **Run the script**:

   ```bash
   bash init_project.sh
   ```

4. **Follow the prompts** to configure your project

## 📋 What Gets Created

### Project Structure

```text
your_new_project/
├── app/
│   ├── main.py                 # Entry point with logging
│   ├── engine/                 # Core business logic (UI-agnostic)
│   │   ├── workflows.py
│   │   ├── calculations.py
│   │   └── models.py
│   ├── services/               # I/O, DB, filesystem, APIs
│   ├── config/                 # Configuration management
│   │   └── settings.py
│   └── utils/
│       └── logger.py           # Logging configuration
├── cli/
│   ├── commands.py             # CLI framework integration
│   └── formatters.py
├── ui/
│   ├── widgets/             # GUI widgets
│   └── assets/              # Images, icons, stylesheets
├── tests/
│   └── test_example.py
├── docs/
│   ├── README.md
│   └── ARCHITECTURE.md
├── logs/                       # Application logs
├── build_tracking/             # Build history and versions
│   ├── BUILD_LOG.md
│   └── VERSION_HISTORY.md
├── templates/                  # Jinja2 templates (if enabled)
│   ├── README.md
│   └── reports/
│       └── example_report.html
├── pyinstaller/
│   └── app.spec                # PyInstaller configuration
├── CHANGELOG.md
├── CONTRIBUTING.md
├── README.md                   # Project README
├── pyproject.toml
├── requirements.txt
└── .gitignore
```

### Documentation Files

- **README.md** - Complete project documentation
- **ARCHITECTURE.md** - System design and architecture
- **CHANGELOG.md** - Version history
- **CONTRIBUTING.md** - Contribution guidelines
- **BUILD_LOG.md** - Build history and checklist
- **VERSION_HISTORY.md** - Version tracking

## 🎨 Package Categories

### Framework Selection (Based on Project Type)

**Console Apps:**

- CLI frameworks: click, typer, argparse, fire
- Rich (beautiful terminal output)

**Desktop GUI:**

- GUI frameworks: tkinter, PyQt5, PyQt6, PySide6, Kivy
- Executable builders: PyInstaller, cx_Freeze, py2exe

**Web Apps:**

- Web frameworks: FastAPI, Flask, Django, Sanic
- ORMs: SQLAlchemy, Flask-SQLAlchemy
- Extensions: Flask-CORS, Django REST framework

**Mobile Apps:**

- Frameworks: Kivy, BeeWare Briefcase, PyQt for Android
- Build tools: Buildozer, python-for-android

**Libraries:**

- Build tools: build, twine
- Version management: setuptools-scm

### Additional Packages (All Project Types)

**Data Visualization:**

- matplotlib, seaborn, plotly

**Data Processing:**

- pandas, numpy, openpyxl

**Utilities:**

- requests (HTTP library)
- python-dotenv (environment variables)
- loguru (enhanced logging)
- pydantic (data validation)

**Document Generation:**

- Jinja2 (template engine)
- python-docx (Word documents)
- reportlab (PDF generation)
- weasyprint (HTML to PDF with CSS)
- markdown (Markdown to HTML)

**Testing:**

- pytest (with pytest-cov, pytest-mock)
- unittest (built-in)
- nose2

**Type Checking:**

- mypy, pyright, pyre-check

**Code Quality:**

- black (formatter)
- flake8 (linter)
- pylint (linter)
- isort (import sorter)
- autopep8 (PEP8 formatter)

## 🛠️ Requirements

- **Bash** (Git Bash on Windows, or native on Linux/macOS)
- **Python 3.8+**
- **pip** (Python package manager)
- **Git** (optional, for repository initialization)

## 💡 Usage Examples

### Example 1: FastAPI Web Application

```bash
./init_project.sh

# Select:
# - Project Type: Web App (Backend/API)
# - Framework: FastAPI
# - Install SQLAlchemy: Yes
# - Testing: pytest
# - Type Checking: mypy
# - Linting: black + flake8
# - Virtual Environment: Yes
# - Git: Yes
```

Result: Complete FastAPI project with API structure, database ORM, testing suite, and documentation.

### Example 2: Desktop GUI with PyQt

```bash
./init_project.sh

# Select:
# - Project Type: Desktop GUI App
# - Framework: PyQt6
# - Executable Builder: PyInstaller
# - Data Visualization: matplotlib
# - Testing: pytest
# - Virtual Environment: Yes
```

Result: PyQt6 project with GUI structure, executable builder configuration, and plotting capabilities.

### Example 3: CLI Tool with Rich Output

```bash
./init_project.sh

# Select:
# - Project Type: Console App (CLI)
# - CLI Framework: click
# - Rich Terminal: Yes
# - Data Processing: pandas + numpy
# - Testing: pytest
# - Linting: black + flake8
```

Result: Professional CLI application with beautiful terminal output and data processing capabilities.

### Example 4: Document Generation with Jinja2

```bash
./init_project.sh

# Select:
# - Project Type: Console App (CLI)
# - Document Generation: Yes
# - Jinja2: Yes
# - python-docx: Yes
# - weasyprint: Yes
# - Testing: pytest
```

Result: Application with template-based document generation, supporting HTML templates, Word documents, and PDF export.

## 📝 Script Workflow

1. **Welcome Banner** - Displays project setup assistant
2. **Project Type** - Select application type (Console/GUI/Web/Mobile/Library)
3. **Framework Selection** - Choose relevant frameworks based on type
4. **Production Packages** - Data processing, visualization, utilities
5. **Development Packages** - Testing, type checking, linting
6. **Environment Setup** - Virtual environment and Git initialization
7. **Structure Creation** - Generate complete folder structure with templates
8. **Package Installation** - Install all selected dependencies
9. **Summary** - Display next steps and activation instructions

## 🎯 Best Practices

The generated projects follow these principles:

- **Separation of Concerns** - UI logic separated from business logic
- **Testability** - Core logic is framework-agnostic
- **Modularity** - Loosely coupled components
- **Documentation** - Comprehensive docs and inline comments
- **Code Quality** - Pre-configured linting and formatting
- **Type Safety** - Type hints and static type checking
- **Logging** - Centralized logging with file rotation
- **Version Control** - Git with sensible .gitignore

## 🔧 Customization

You can modify the script to:

- Add more framework options
- Include additional package categories
- Change default selections
- Customize folder structure
- Add custom templates

Simply edit `init_project.sh` and add your preferences.

## 📖 Generated Project Usage

After running the script, activate your environment and start coding:

```bash
# Activate virtual environment
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Run your application
python app/main.py

# Development commands
pytest                    # Run tests
black .                   # Format code
flake8 .                  # Lint code
mypy app/ cli/            # Type check
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Add framework options
- Improve templates
- Enhance documentation

## 📜 License

This project is open source and available for anyone to use and modify.

## 🙏 Acknowledgments

Inspired by the T3 Stack's create-t3-app, bringing similar interactive setup experience to Python projects.

---

**Happy Coding!** 🚀
