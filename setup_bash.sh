#!/usr/bin/env bash
#
# Symlink dotfiles into $HOME and back up anything that gets replaced.
#
#   dotfiles/*            -> ~/.<name>
#   bash_completion.d/*   -> ~/.bash_completion.d/
#   config/<dir>          -> ~/.config/<dir>
#
# Safe to re-run: entries already pointing at this repo are left alone.
#
set -u

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
STAMP=$(date +%s)
BACKUP="$ROOT/backup"
mkdir -p "$BACKUP/dotfiles" "$BACKUP/config"

backup_file() {
    # backup_file SRC DEST_DIR NAME
    local src=$1 dest_dir=$2 name=$3
    rm -f "$dest_dir/$name"
    cp -RpL "$src" "$dest_dir/${name}.${STAMP}"
    ln -s "$dest_dir/${name}.${STAMP}" "$dest_dir/$name"
    echo "Backed up $src -> $dest_dir/${name}.${STAMP}"
}

link_files() {
    # link_files SRC_DIR DEST_DIR PREFIX BACKUP_DIR
    local src_dir=$1 dest_dir=$2 prefix=$3 backup_dir=$4 src name dest
    mkdir -p "$dest_dir"
    for src in "$src_dir"/*; do
        [ -e "$src" ] || continue
        name=$(basename "$src")
        dest="$dest_dir/${prefix}${name}"

        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            continue
        fi
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            backup_file "$dest" "$backup_dir" "$name"
            rm -rf "$dest"
        fi
        ln -s "$src" "$dest"
        echo "Linked $dest -> $src"
    done
}

link_config_dirs() {
    local src_dir="$ROOT/config" src name dest
    mkdir -p "$HOME/.config"
    for src in "$src_dir"/*; do
        [ -d "$src" ] || continue
        name=$(basename "$src")
        dest="$HOME/.config/$name"

        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            continue
        fi
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            backup_file "$dest" "$BACKUP/config" "$name"
            rm -rI "$dest"
        fi
        ln -s "$src" "$dest"
        echo "Linked $dest -> $src"
    done
}

link_files "$ROOT/dotfiles" "$HOME" "." "$BACKUP/dotfiles"
link_config_dirs

if (( BASH_VERSINFO[0] < 5 || (BASH_VERSINFO[0] == 5 && BASH_VERSINFO[1] < 2) )); then
    echo "warning: bash >= 5.2 recommended (found ${BASH_VERSION})."
fi

missing=""
for cmd in git fzf bat nvim rg node npm; do
    command -v "$cmd" >/dev/null 2>&1 || missing="$missing $cmd"
done
if [ -n "$missing" ]; then
    echo "warning: missing tools:$missing — see the Dependencies section in README."
fi

if [ ! -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && [ ! -r /usr/share/bash-completion/bash_completion ]; then
    echo "note: bash-completion not found — install bash-completion@2 (macOS) or bash-completion (Fedora)."
fi

if command -v bat >/dev/null 2>&1; then
    echo "Building bat theme cache..."
    bat cache --build
fi

echo "Done. Open a new terminal (or run: exec bash -l)."
