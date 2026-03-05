# ⚠️ TEMPLATE REPOSITORY — DO NOT USE AS A PROJECT

This repository is a **project template and scaffold generator**.

❌ Do NOT:

- write application code here
- add business logic here
- treat this as a runnable app

✅ Correct usage:

1. Click **Use this template** on GitHub
2. Clone the newly created repo
3. Run:

   ```bash
   python -m scaffold

## Project Overview: Ouroboros

An interactive Python-based project scaffolding wizard that quickly generates production-ready Python projects with intelligent defaults based on project archetype.

## 🎯 Features

- **Interactive Wizard** - Beautiful, colorful CLI with guided prompts
- **Archetype-Based Templates** - Smart defaults for common project types:
  - **GUI** - Desktop GUI Applications
  - **CLI** - Console/Command-line Applications  
  - **Web** - Web Applications (Backend/API)
  - **Lib** - Python Libraries/Packages
- **Jinja2 Template System** - Flexible template-based project generation
- **Intelligent Package Selection** - Context-aware recommendations for frameworks and tools
- **Add-ons System** - Modular package bundles (data, visualization, docs, HTTP, config, database)
- **Development Bundles** - Pre-configured dev tool sets (standard, minimal, strict)
- **Modern Python** - Uses pyproject.toml for project configuration
- **Virtual Environment** - Optional venv creation
- **Git Integration** - Optional repository initialization
- **Self-Destruct Pattern** - Optionally removes scaffold code after generation

## 🚀 Quick Start

1. **Clone or download** this repository
2. **Navigate** to the directory:

   ```bash
   cd Ouroboros
   ```

3. **Run the bootstrap script**:

   ```bash
   ./bootstrap.sh       # Linux/macOS/Git Bash
   ```

   or

   ```powershell
   ./bootstrap.ps1      # Windows PowerShell
   ```

4. **Follow the interactive prompts** to configure your project

## 📋 What Gets Created

### Project Structure

The wizard generates a well-organized project using Jinja2 templates. The structure varies by archetype:

**Base Structure** (all archetypes):

```text
your_new_project/
├── app/                        # Main application package
│   ├── __init__.py
│   ├── config/
│   │   └── __init__.py
│   ├── engine/                 # Core business logic
│   │   └── __init__.py
│   ├── services/               # I/O, DB, filesystem, APIs
│   │   └── __init__.py
│   └── utils/
│       ├── __init__.py
│       └── logger.py           # Logging configuration
├── tests/
│   └── test_smoke.py
├── logs/                       # Application logs directory
├── requirements/               # Generated dependency files (when selected)
│   ├── base.txt
│   ├── dev.txt
│   └── all.txt
├── pyproject.toml              # Modern Python project config
├── README.md
└── run.py                      # Entry point
```

**Additional for GUI archetype:**

```text
├── ui/
│   └── main_window.py          # GUI main window
```

**Additional for CLI archetype:**

```text
├── ui/
│   └── main_window.py          # CLI interface
```

**Additional for Web archetype:**

```text
├── ui/
│   └── main_window.py          # Web routes/views
```

**Optional**: If `use_src_layout` is enabled, the main package is placed under a `src/` directory (recommended for libraries)

## 🎨 Configuration Options

### Archetypes

Choose from 4 project archetypes:

- **gui** - Desktop GUI applications
- **cli** - Command-line/console applications
- **web** - Web applications and APIs
- **lib** - Python libraries and packages

### GUI Frameworks (for GUI archetype)

- **PyQt6** - Modern Qt bindings
- **PySide6** - Official Qt bindings
- **PyQt5** - Mature Qt bindings
- **tkinter** - Built-in Python GUI (no install needed)
- **Kivy** - Cross-platform including mobile

Optional: Add PyInstaller for building standalone executables

### Add-ons

Modular package bundles you can enable:

- **data** - Data tools (numpy, pandas, openpyxl) - *recommended*
- **viz** - Visualization (matplotlib, plotly)
- **docs** - Document generation (jinja2, python-docx, reportlab)
- **http** - HTTP client (requests)
- **config** - Environment config (python-dotenv) - *recommended*
- **db** - Database ORM (sqlalchemy)

### Development Tool Bundles

Choose a dev tools configuration:

- **standard** - pytest+cov, ruff, mypy - *recommended*
- **minimal** - pytest only
- **strict** - pytest+cov, ruff, black, mypy (maximum rigor)

### Project Options

- **Use src/ layout** - Package under src/ directory (recommended for libraries)
- **Create venv** - Create virtual environment in new project
- **Install dependencies** - Run pip install automatically after generation
- **Initialize git** - Initialize git repository
- **Self-destruct** - Remove scaffold/ folder after generation (Pattern A)

## 🛠️ Requirements

- **Python 3.10+** (required for the scaffold tool)
- **pip** (Python package manager)
- **Git** (optional, for repository initialization in generated projects)

## 💡 Usage Examples

### Example 1: GUI Application with PyQt6

```bash
./bootstrap.sh

# Wizard prompts:
# - Project display name: My GUI App
# - Project slug: my-gui-app
# - Package name: my_gui_app
# - Archetype: gui
# - GUI Framework: PyQt6
# - Add PyInstaller: Yes
# - Add-ons: data (yes), config (yes)
# - Dev bundle: standard
# - Use src/ layout: No
# - Create venv: Yes
# - Initialize git: Yes
# - Self-destruct: Yes
```

Result: Complete PyQt6 project with data tools, professional structure, and testing.

### Example 2: CLI Application

```bash
./bootstrap.sh

# Wizard prompts:
# - Project display name: Data Processor
# - Archetype: cli
# - Add-ons: data (yes), http (yes), config (yes)
# - Dev bundle: standard
# - Create venv: Yes
```

Result: CLI application with data processing capabilities and HTTP client.

### Example 3: Web API

```bash
./bootstrap.sh

# Wizard prompts:
# - Project display name: My API
# - Archetype: web
# - Add-ons: db (yes), config (yes)
# - Dev bundle: strict
# - Create venv: Yes
```

Result: Web application structure with database ORM and strict linting.

### Example 4: Python Library

```bash
./bootstrap.sh

# Wizard prompts:
# - Project display name: My Library
# - Archetype: lib
# - Add-ons: (select as needed)
# - Dev bundle: standard
# - Use src/ layout: Yes (recommended for libraries)
# - Create venv: Yes
```

Result: Library project with src/ layout, ready for packaging and distribution.

## 📝 Wizard Workflow

1. **Banner** - Displays the Ouroboros scaffolding wizard
2. **Project Identity** - Name, slug, and package name
3. **Archetype Selection** - Choose project type (gui/cli/web/lib)
4. **Framework Selection** - GUI framework selection (GUI archetype only)
5. **Add-ons** - Select additional package bundles
6. **Development Tools** - Choose dev tool bundle
7. **Project Options** - src/ layout, venv, git, self-destruct
8. **Generation** - Renders Jinja2 templates to create project structure
9. **Summary** - Displays project location and next steps

## 🎯 Architecture

The Ouroboros scaffold tool is structured as follows:

- **scaffold/\_\_main\_\_.py** - Entry point, orchestrates the workflow
- **scaffold/wizard.py** - Interactive wizard that collects configuration
- **scaffold/config.py** - ProjectConfig dataclass definition
- **scaffold/presets.py** - Archetype, framework, and package definitions
- **scaffold/cli\_ui.py** - Beautiful terminal UI components
- **scaffold/deps.py** - Dependency resolution logic
- **scaffold/actions.py** - Project scaffolding execution
- **scaffold/render.py** - Jinja2 template rendering engine
- **scaffold/prompts.py** - Utility functions for user input
- **scaffold/templates/** - Jinja2 templates organized by archetype
  - **base/** - Common templates for all archetypes
  - **gui/** - GUI-specific templates
  - **cli/** - CLI-specific templates  
  - **web/** - Web-specific templates
  - **lib/** - Library-specific templates

## 🎯 Best Practices

Generated projects follow these principles:

- **Separation of Concerns** - UI logic separated from business logic  
- **Testability** - Core logic is framework-agnostic
- **Modularity** - Loosely coupled components
- **Modern Python** - Uses pyproject.toml and current best practices
- **Code Quality** - Pre-configured linting and formatting via dev bundles
- **Type Safety** - Type hints with static type checking (mypy)
- **Logging** - Centralized logging infrastructure

## 🔧 Customization

You can extend Ouroboros by modifying:

- **scaffold/presets.py** - Add archetypes, frameworks, add-ons, or dev bundles
- **scaffold/templates/** - Customize or add new Jinja2 templates
- **scaffold/deps.py** - Modify dependency resolution logic
- **scaffold/cli_ui.py** - Enhance the terminal UI

### Adding a New Archetype

1. Add archetype name to `ARCHETYPES` list in presets.py
2. Create template directory under `scaffold/templates/<archetype>/`
3. Add archetype handling in deps.py if needed
4. Update the Archetype type hint in config.py

### Adding a New Add-on

Add to the `ADDONS` list in presets.py:

```python
("key", "Description", ["package1", "package2"], default_bool)
```

## 📖 Generated Project Usage

After the wizard completes, navigate to your new project:

```bash
cd ../your-project-slug

# Activate virtual environment (if created)
source .venv/bin/activate  # Linux/macOS/Git Bash
.venv\Scripts\activate     # Windows CMD
.venv\Scripts\Activate.ps1 # Windows PowerShell

# Install dependencies (generated from wizard selections)
pip install -r requirements/all.txt

# Optional editable install if you also manage dependencies in pyproject.toml
pip install -e .

# Run your application
python run.py

# Development commands (if using standard/strict dev bundle)
pytest                    # Run tests
pytest --cov=app          # Run tests with coverage
ruff check .              # Lint code
mypy app/                 # Type check
black .                   # Format code (if using strict bundle)
```

## 🤝 Contributing

Contributions are welcome! You can:

- Report bugs or suggest features via issues
- Add new archetypes or frameworks
- Improve templates
- Enhance the wizard UI
- Improve documentation

## 📜 License

This project is open source and available for anyone to use and modify.

## 🙏 Acknowledgments

Inspired by modern project scaffolding tools like create-t3-app, bringing an interactive, opinionated setup experience to Python projects.

The name "Ouroboros" (the serpent eating its own tail) reflects the self-referential nature of the tool - it's a Python project that creates Python projects and can optionally remove itself after generation (the self-destruct pattern).

---

**Happy Coding!** 🚀
