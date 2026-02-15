ARCHETYPES = ["gui", "cli", "web", "lib"]

GUI_FRAMEWORKS = [ # type: ignore
    ("PyQt6", ["PyQt6"]),
    ("PySide6", ["PySide6"]),
    ("PyQt5", ["PyQt5"]),
    ("tkinter (built-in)", []),
    ("Kivy", ["kivy"]),
]

ADDONS = [
    ("data", "Data tools (numpy, pandas, openpyxl)", ["numpy", "pandas", "openpyxl"], True),
    ("viz", "Visualization (matplotlib, plotly)", ["matplotlib", "plotly"], False),
    ("docs", "Document generation (jinja2, python-docx, reportlab)", ["jinja2", "python-docx", "reportlab"], False),
    ("http", "HTTP client (requests)", ["requests"], False),
    ("config", "Env config (python-dotenv)", ["python-dotenv"], True),
    ("db", "Database ORM (sqlalchemy)", ["sqlalchemy"], False),
]

DEV_BUNDLES = [
    ("standard", "pytest+cov, ruff, mypy", ["pytest", "pytest-cov", "ruff", "mypy"], True),
    ("minimal", "pytest only", ["pytest"], False),
    ("strict", "pytest+cov, ruff, black, mypy", ["pytest", "pytest-cov", "ruff", "black", "mypy"], False),
]
