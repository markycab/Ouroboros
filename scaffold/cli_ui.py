from __future__ import annotations

from dataclasses import dataclass
from typing import Sequence, TypeVar

from rich.console import Console
from rich.panel import Panel
from rich.rule import Rule
from rich.table import Table
from rich.prompt import Prompt, Confirm, IntPrompt

T = TypeVar("T")

console = Console()

@dataclass(frozen=True)
class Theme:
    title: str = "Python Template Scaffold"
    accent: str = "cyan"
    good: str = "green"
    warn: str = "yellow"
    bad: str = "red"

THEME = Theme()


def banner() -> None:
    console.clear()
    console.print(
        Panel.fit(
            f"[bold {THEME.accent}]{THEME.title}[/]\n[dim]Interactive project generator[/]",
            border_style=THEME.accent,
        )
    )


def section(title: str) -> None:
    console.print(Rule(f"[bold {THEME.accent}]{title}[/]", style=THEME.accent))


def info(msg: str) -> None:
    console.print(f"[{THEME.accent}]•[/] {msg}")


def ok(msg: str) -> None:
    console.print(f"[{THEME.good}]✓[/] {msg}")


def warn(msg: str) -> None:
    console.print(f"[{THEME.warn}]![/] {msg}")


def error(msg: str) -> None:
    console.print(f"[{THEME.bad}]✗[/] {msg}")


def ask_text(prompt: str, default: str | None = None) -> str:
    if default is None:
        return Prompt.ask(f"[bold]{prompt}[/]").strip()
    return Prompt.ask(f"[bold]{prompt}[/]", default=default).strip()


def ask_yes_no(prompt: str, default: bool = True) -> bool:
    return Confirm.ask(f"[bold]{prompt}[/]", default=default)


def ask_choice(prompt: str, options: Sequence[T], default_index: int = 0) -> T:
    # Render a nice table menu
    table = Table(show_header=True, header_style=f"bold {THEME.accent}")
    table.add_column("#", style="dim", width=4)
    table.add_column("Option")

    for i, opt in enumerate(options, 1):
        d = " (default)" if (i - 1) == default_index else ""
        table.add_row(str(i), f"{opt}{d}")

    console.print(table)

    while True:
        idx = IntPrompt.ask(
            f"[bold]{prompt}[/] (enter #)",
            default=default_index + 1,
            show_default=True,
        )
        if 1 <= idx <= len(options):
            return options[idx - 1]
        warn("Invalid selection. Try again.")
