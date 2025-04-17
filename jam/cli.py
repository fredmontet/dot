#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path
import typer

app = typer.Typer()

def info(msg):
    print(f"[..] {msg}")

def success(msg):
    print(f"[OK] {msg}")

def fail(msg):
    print(f"[FAIL] {msg}")
    exit(1)

def link_file(src: Path, dst: Path, state):
    overwrite = False
    backup = False
    skip = False
    if dst.exists() or dst.is_symlink():
        try:
            current = dst.resolve()
        except Exception:
            current = None
        if current == src:
            success(f"skipped {src}")
            return
        if not any([state["overwrite_all"], state["backup_all"], state["skip_all"]]):
            action = input(
                f"File exists: {dst}, what do you want to do? [s]kip, [S]kip all, "
                "[o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all: "
            ).strip()
            if action == "o":
                overwrite = True
            elif action == "O":
                state["overwrite_all"] = True
            elif action == "b":
                backup = True
            elif action == "B":
                state["backup_all"] = True
            elif action == "s":
                skip = True
            elif action == "S":
                state["skip_all"] = True
        overwrite = overwrite or state["overwrite_all"]
        backup = backup or state["backup_all"]
        skip = skip or state["skip_all"]
        if overwrite:
            if dst.is_dir() or dst.is_file() or dst.is_symlink():
                dst.unlink()
            success(f"removed {dst}")
        if backup:
            dst.rename(dst.with_suffix(dst.suffix + ".backup"))
            success(f"moved {dst} to {dst}.backup")
        if skip:
            success(f"skipped {src}")
            return
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.symlink_to(src)
    success(f"linked {src} to {dst}")

def setup_git(jam_dir: Path):
    git_local = jam_dir / "rel/git/gitconfig.local.symlink"
    if not git_local.exists():
        info("Setup git")
        helper = "osxkeychain" if os.uname().sysname == "Darwin" else "cache"
        name = input("What is your github author name? ").strip()
        email = input("What is your github author email? ").strip()
        example = jam_dir / "rel/git/gitconfig.local.symlink.example"
        content = example.read_text()
        content = content.replace("AUTHOR_NAME", name).replace("AUTHOR_EMAIL", email)
        content = content.replace("GIT_CREDENTIAL_HELPER", helper)
        git_local.write_text(content)
        success("git")

@app.command("setup")
def setup():
    jam_dir = Path(os.environ.get("JAM", os.getcwd())).resolve()
    setup_git(jam_dir)
    info("Setup jam")
    state = {"overwrite_all": False, "backup_all": False, "skip_all": False}
    for src in jam_dir.rglob("*.symlink"):
        dst = Path.home() / f".{src.stem}"
        link_file(src, dst, state)
    success("Setup completed")

@app.command("install")
def install():
    jam_dir = Path(os.environ.get("JAM", os.getcwd())).resolve()
    info("Run following installers")
    for script in jam_dir.rglob("rel/*/install.sh"):
        print(script)
    print()
    info("Start")
    for script in jam_dir.rglob("rel/*/install.sh"):
        subprocess.run(["sh", "-c", str(script)], check=True)
    success("Install completed")

def main():
    app()

if __name__ == "__main__":
    main()