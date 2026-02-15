from pathlib import Path
from jinja2 import Environment, FileSystemLoader

def env_for(templates_dir: Path) -> Environment:
    return Environment(
        loader=FileSystemLoader(str(templates_dir)),
        autoescape=False,
        keep_trailing_newline=True,
    )

def render_tree(src_dir: Path, dst_dir: Path, context: dict) -> None: # type: ignore
    """
    Render all files under src_dir into dst_dir.
    - Files ending with .j2 get rendered and suffix removed.
    - Other files copied as-is.
    """
    e = env_for(src_dir)
    for path in src_dir.rglob("*"):
        if path.is_dir():
            continue
        rel = path.relative_to(src_dir)
        out_rel = rel
        if out_rel.suffix == ".j2":
            out_rel = out_rel.with_suffix("")
        out_path = dst_dir / out_rel
        out_path.parent.mkdir(parents=True, exist_ok=True)

        if path.suffix == ".j2":
            tpl = e.get_template(str(rel).replace("\\", "/"))
            out_path.write_text(tpl.render(**context), encoding="utf-8")
        else:
            out_path.write_bytes(path.read_bytes())
