from __future__ import annotations

import re
from typing import Sequence, TypeVar

T = TypeVar("T")


def yn(prompt: str, default: bool = True) -> bool:
    """
    Yes/No prompt.

    Args:
        prompt: Question text
        default: Value used if user presses Enter

    Returns:
        bool
    """
    suffix = "Y/n" if default else "y/N"
    raw = input(f"{prompt} ({suffix}): ").strip().lower()
    if raw == "":
        return default
    return raw in {"y", "yes"}


def choice(prompt: str, options: Sequence[T], default_index: int = 0) -> T:
    """
    Menu selection prompt.

    Args:
        prompt: Prompt header
        options: List/tuple of options to display
        default_index: Option index used if user presses Enter

    Returns:
        selected option (same type as entries in `options`)
    """
    if not options:
        raise ValueError("choice() requires at least one option")

    print(prompt)
    for i, opt in enumerate(options, 1):
        star = " (default)" if (i - 1) == default_index else ""
        print(f"  {i}. {opt}{star}")

    while True:
        raw = input("Select option #: ").strip()
        if raw == "":
            return options[default_index]
        if raw.isdigit():
            idx = int(raw) - 1
            if 0 <= idx < len(options):
                return options[idx]
        print("Invalid selection. Try again.")


def ask_text(prompt: str, default: str | None = None) -> str:
    """
    Free-text prompt.

    Args:
        prompt: Prompt text
        default: Returned if user presses Enter

    Returns:
        str
    """
    if default is None:
        raw = input(f"{prompt}: ").strip()
        return raw
    raw = input(f"{prompt} (default: {default}): ").strip()
    return raw or default


def slugify(value: str, fallback: str = "my_project") -> str:
    """
    Convert arbitrary input into a filesystem-safe slug.
    """
    s = value.strip().lower()
    s = re.sub(r"[^a-z0-9_-]+", "-", s)
    s = re.sub(r"-{2,}", "-", s).strip("-")
    return s or fallback


def pkgify(value: str, fallback: str = "my_package") -> str:
    """
    Convert arbitrary input into a valid-ish python package name.
    """
    s = value.strip().lower()
    s = re.sub(r"[^a-z0-9_]+", "_", s)
    s = re.sub(r"_{2,}", "_", s).strip("_")
    if not s:
        s = fallback
    if s[0].isdigit():
        s = f"pkg_{s}"
    return s
