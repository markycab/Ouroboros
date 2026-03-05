from __future__ import annotations

from typing import cast
from .config import Archetype, ProjectConfig
from .prompts import slugify, pkgify
from .presets import ARCHETYPES, GUI_FRAMEWORKS, ADDONS, DEV_BUNDLES
from .cli_ui import banner, section, ask_text, ask_yes_no, ask_choice, ok
from .deps import Selection, resolve_deps


def collect_config() -> ProjectConfig:
    banner()

    section("Project Identity")
    project_name = ask_text("Project display name", default="My Application")
    project_slug = slugify(ask_text("Project slug (folder/repo name)", default=project_name))
    package_name = pkgify(ask_text("Package name (import name)", default=project_slug))

    section("Archetype")
    archetype = cast(Archetype, ask_choice("Select archetype", ARCHETYPES, default_index=0))
    ok(f"Archetype set to: {archetype}")

    gui_fw: str | None = None
    extra_pkgs: list[str] = []

    # GUI framework
    if archetype == "gui":
        section("GUI Framework")

        gui_labels = [label for (label, _pkgs) in GUI_FRAMEWORKS]
        gui_fw = ask_choice("Select GUI framework", gui_labels, default_index=0)

        fw_map = {label: pkgs for (label, pkgs) in GUI_FRAMEWORKS}
        extra_pkgs += fw_map.get(gui_fw, [])

        if ask_yes_no("Add PyInstaller (build executable)?", default=True):
            extra_pkgs.append("pyinstaller") # type: ignore

    # Add-ons
    section("Add-ons")
    addon_keys: list[str] = []
    for key, label, _pkgs, default in ADDONS:
        if ask_yes_no(label, default=default):
            addon_keys.append(key)

    # Dev tools bundle
    section("Dev Tools")
    dev_bundle_labels = [label for (_key, label, _pkgs, _default) in DEV_BUNDLES]
    default_idx = next((i for i, (_k, _l, _p, d) in enumerate(DEV_BUNDLES) if d), 0)
    selected_dev_label = ask_choice("Select dev bundle", dev_bundle_labels, default_index=default_idx)

    # Map label -> key -> packages
    label_to_key = {label: key for (key, label, _pkgs, _default) in DEV_BUNDLES}
    dev_bundle_key = label_to_key[selected_dev_label]
    dev_pkgs = {key: pkgs for (key, _label, pkgs, _default) in DEV_BUNDLES}[dev_bundle_key]

    # Resolve deps (pure logic)
    deps, _ = resolve_deps(Selection(archetype, gui_fw, addon_keys, dev_bundle_key))
    deps += extra_pkgs
    deps = list(dict.fromkeys(deps)) # de-dupe stable order

    section("Project Options")
    use_src = ask_yes_no("Use src/ layout?", default=(archetype == "lib"))
    create_venv = ask_yes_no("Create venv in new project?", default=True)
    install_deps = ask_yes_no("Install dependencies with pip after generation?", default=True)
    init_git = ask_yes_no("Initialize git in new project?", default=True)
    self_destruct = ask_yes_no("Remove scaffold/ after generation (Pattern A)?", default=True)

    return ProjectConfig(
        project_name=project_name,
        project_slug=project_slug,
        package_name=package_name,
        archetype=archetype,  # must match your Archetype Literal
        use_src_layout=use_src,
        create_venv=create_venv,
        install_deps=install_deps,
        init_git=init_git,
        self_destruct=self_destruct,
        extra_packages=deps,
        dev_packages=dev_pkgs,
    )
