import shutil
import subprocess
from pathlib import Path
from .config import ProjectConfig
from .render import render_tree # type: ignore

def _run(cmd: list[str], cwd: Path) -> None:
    subprocess.check_call(cmd, cwd=str(cwd))

def scaffold_project(cfg: ProjectConfig, repo_root: Path) -> Path:
    """
    Creates a new project folder *next to* the template repo root.
    """
    target = repo_root.parent / cfg.project_slug
    target.mkdir(parents=True, exist_ok=True)

    templates_root = repo_root / "scaffold" / "templates"
    context = { # type: ignore
        "project_name": cfg.project_name,
        "project_slug": cfg.project_slug,
        "package_name": cfg.package_name,
        "use_src_layout": cfg.use_src_layout,
        "archetype": cfg.archetype,
    }

    # Base templates always
    render_tree(templates_root / "base", target, context)

    # Archetype templates
    render_tree(templates_root / cfg.archetype, target, context)

    # Optional: venv + git
    if cfg.create_venv:
        _run(["python", "-m", "venv", ".venv"], target)

    if cfg.init_git:
        _run(["git", "init"], target)

    # Pattern A: remove scaffold engine from generated project (if it exists)
    # Note: since we render templates only, scaffold/ isn’t copied—this is just a safety net.
    if cfg.self_destruct:
        maybe_scaffold = target / "scaffold"
        if maybe_scaffold.exists():
            shutil.rmtree(maybe_scaffold, ignore_errors=True)

    return target
