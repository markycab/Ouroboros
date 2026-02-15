from pathlib import Path
from .wizard import collect_config
from .actions import scaffold_project

def main() -> None:
    repo_root = Path(__file__).resolve().parents[1]  # template repo root
    cfg = collect_config()
    out = scaffold_project(cfg, repo_root)
    print(f"\n✅ Created project at: {out}")
    print("Next:")
    print(f"  cd {out}")
    if (out / ".venv").exists():
        print("  # activate venv then install deps")
    print("  code .")

if __name__ == "__main__":
    main()
