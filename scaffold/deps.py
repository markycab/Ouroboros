from dataclasses import dataclass
from typing import List
from .presets import ADDONS

@dataclass(frozen=True)
class Selection:
    archetype: str
    gui_framework: str | None
    addon_keys: List[str]
    dev_bundle_key: str

def resolve_deps(sel: Selection) -> tuple[list[str], list[str]]:
    deps: list[str] = []
    dev: list[str] = []

    # Archetype baselines
    if sel.archetype == "web":
        deps += ["fastapi", "uvicorn[standard]", "pydantic"]
    if sel.archetype == "lib":
        pass  # usually none
    if sel.archetype == "cli":
        pass  # your call: typer/rich baseline if you want

    # Add-ons
    addon_map = {k: pkgs for (k, _, pkgs, _) in ADDONS}
    for k in sel.addon_keys:
        deps += addon_map.get(k, [])

    # De-dupe preserving order
    deps = list(dict.fromkeys(deps))
    dev = list(dict.fromkeys(dev))
    return deps, dev
