from __future__ import annotations
from typing import Final

ARCHETYPES: Final[list[str]] = ["gui", "cli", "web", "lib"]

GUI_FRAMEWORKS: Final[list[tuple[str, list[str]]]] = [
    ("PyQt6", ["PyQt6"]),
    ("PySide6", ["PySide6"]),
    ("PyQt5", ["PyQt5"]),
    ("tkinter (built-in)", []),
    ("Kivy", ["kivy"]),
]

# (key, label, packages, default_selected)
ADDONS: Final[list[tuple[str, str, list[str], bool]]] = [
    ("data", "Data tools (numpy, pandas, openpyxl)", ["numpy", "pandas", "openpyxl"], True),
    ("viz", "Visualization (matplotlib, plotly)", ["matplotlib", "plotly"], False),
    ("docs", "Document generation (jinja2, python-docx, reportlab)", ["jinja2", "python-docx", "reportlab"], False),
    ("http", "HTTP client (requests)", ["requests"], False),
    ("config", "Env config (python-dotenv)", ["python-dotenv"], True),
    ("db", "Database ORM (sqlalchemy)", ["sqlalchemy"], False),
]

# (key, label, packages, default_selected)
DEV_BUNDLES: Final[list[tuple[str, str, list[str], bool]]] = [
    ("standard", "pytest+cov, ruff, mypy", ["pytest", "pytest-cov", "ruff", "mypy"], True),
    ("minimal", "pytest only", ["pytest"], False),
    ("strict", "pytest+cov, ruff, black, mypy", ["pytest", "pytest-cov", "ruff", "black", "mypy"], False),
]
