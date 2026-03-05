from dataclasses import dataclass
from typing import Literal, List

Archetype = Literal["gui", "cli", "web", "lib"]

@dataclass(frozen=True)
class ProjectConfig:
    project_name: str          # human name (README)
    project_slug: str          # folder/repo name
    package_name: str          # python import package
    archetype: Archetype
    use_src_layout: bool
    create_venv: bool
    install_deps: bool
    init_git: bool
    self_destruct: bool        # Pattern A option: delete scaffold after generation
    extra_packages: List[str]
    dev_packages: List[str]
