import shutil
import subprocess
import sys
from pathlib import Path
from .config import ProjectConfig
from .render import render_tree # type: ignore

def _run(cmd: list[str], cwd: Path) -> None:
    subprocess.check_call(cmd, cwd=str(cwd))


def _pip_install_requirements(target: Path) -> None:
    req_file = target / "requirements" / "all.txt"
    if not req_file.exists():
        return

    print("Installing dependencies from requirements/all.txt...")
    venv_pip = target / ".venv" / ("Scripts" if sys.platform == "win32" else "bin") / ("pip.exe" if sys.platform == "win32" else "pip")

    if venv_pip.exists():
        _run([str(venv_pip), "install", "-r", str(req_file)], target)
        print("Dependencies installed.")
        return

    _run([sys.executable, "-m", "pip", "install", "-r", str(req_file)], target)
    print("Dependencies installed.")


def _write_requirements(cfg: ProjectConfig, target: Path) -> None:
    requirements_dir = target / "requirements"
    requirements_dir.mkdir(parents=True, exist_ok=True)

    if cfg.extra_packages:
        (requirements_dir / "base.txt").write_text(
            "\n".join(cfg.extra_packages) + "\n", encoding="utf-8"
        )

    if cfg.dev_packages:
        (requirements_dir / "dev.txt").write_text(
            "\n".join(cfg.dev_packages) + "\n", encoding="utf-8"
        )

    all_lines: list[str] = []
    if cfg.extra_packages:
        all_lines.append("-r base.txt")
    if cfg.dev_packages:
        all_lines.append("-r dev.txt")
    if all_lines:
        (requirements_dir / "all.txt").write_text(
            "\n".join(all_lines) + "\n", encoding="utf-8"
        )

def scaffold_project(cfg: ProjectConfig, repo_root: Path) -> Path:
    """
    Creates a new project folder *next to* the template repo root.
    """
    # SAFETY: refuse to scaffold into the template repo itself
    marker = repo_root / ".template-repo"
    if marker.exists():
        raise RuntimeError(
            "This is the TEMPLATE repository.\n"
            "Scaffolding into the template itself is not allowed.\n"
            "Create a new repo from the template or run the generator externally.\n"
            "If you wish to overwrite the template repo, remove the .template-repo file and try again."
        )
        
    target = repo_root.parent / cfg.project_slug
    target.mkdir(parents=True, exist_ok=True)

    templates_root = repo_root / "scaffold" / "templates"
    context: dict[str, str|bool] = {
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

    # Define requirements files with resolved dependencies
    if cfg.extra_packages or cfg.dev_packages:
        _write_requirements(cfg, target)

    # Optional: venv + git
    if cfg.create_venv:
        _run(["python", "-m", "venv", ".venv"], target)

    if cfg.install_deps:
        _pip_install_requirements(target)

    if cfg.init_git:
        _run(["git", "init"], target)

    # Pattern A: remove scaffold engine from generated project (if it exists)
    # Note: since we render templates only, scaffold/ isn’t copied—this is just a safety net.
    if cfg.self_destruct:
        maybe_scaffold = target / "scaffold"
        if maybe_scaffold.exists():
            shutil.rmtree(maybe_scaffold, ignore_errors=True)

    return target
