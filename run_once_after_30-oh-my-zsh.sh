#!/bin/sh
set -eu

# Clone only: never run the installer that can replace .zshrc or change shells.
# Existing private/Mac installations are left completely untouched.
target="$HOME/.oh-my-zsh"
if [ -e "$target" ] || [ -L "$target" ]; then
    if [ -r "$target/oh-my-zsh.sh" ]; then
        printf '%s\n' 'Oh My Zsh already exists; leaving it unchanged.'
        exit 0
    fi
    printf '%s\n' '~/.oh-my-zsh exists without a readable loader; stopping instead of overwriting it.' >&2
    exit 1
fi
if ! command -v git >/dev/null 2>&1; then
    printf '%s\n' 'Git is required to install Oh My Zsh; stopping.' >&2
    exit 1
fi

commit=964ddf789b022b6958b27d02d7fa54f552de21e9
git clone --no-checkout --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$target"
git -C "$target" fetch --depth=1 origin "$commit"
git -C "$target" checkout --detach "$commit"
if [ ! -r "$target/oh-my-zsh.sh" ]; then
    printf '%s\n' 'Oh My Zsh loader is missing after checkout; stopping.' >&2
    exit 1
fi
