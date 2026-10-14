#!/bin/sh
set -eu

# Clone only: never run the installer that can replace .zshrc or change shells.
# Existing framework/plugin checkouts are left completely untouched.
target="$HOME/.oh-my-zsh"
if [ -e "$target" ] || [ -L "$target" ]; then
    if [ ! -r "$target/oh-my-zsh.sh" ]; then
        printf '%s\n' '~/.oh-my-zsh exists without a readable loader; stopping instead of overwriting it.' >&2
        exit 1
    fi
    printf '%s\n' 'Oh My Zsh already exists; leaving it unchanged.'
else
    if ! command -v git >/dev/null 2>&1; then
        printf '%s\n' 'Git is required to install Oh My Zsh; stopping.' >&2
        exit 1
    fi
    # Preserve the existing framework pin. External plugins below are unpinned.
    commit=964ddf789b022b6958b27d02d7fa54f552de21e9
    git clone --no-checkout --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$target"
    git -C "$target" fetch --depth=1 origin "$commit"
    git -C "$target" checkout --detach "$commit"
    if [ ! -r "$target/oh-my-zsh.sh" ]; then
        printf '%s\n' 'Oh My Zsh loader is missing after checkout; stopping.' >&2
        exit 1
    fi
fi

plugin_root="${ZSH_CUSTOM:-$target/custom}/plugins"
install_plugin() {
    name=$1
    repo=$2
    destination="$plugin_root/$name"
    if [ -e "$destination" ] || [ -L "$destination" ]; then
        if [ ! -r "$destination/$name.plugin.zsh" ]; then
            printf '%s\n' "$destination exists without its plugin loader; stopping instead of overwriting it." >&2
            return 1
        fi
        printf '%s\n' "$name already exists; leaving it unchanged."
        return 0
    fi
    if ! command -v git >/dev/null 2>&1; then
        printf '%s\n' "Git is required to install $name; stopping." >&2
        return 1
    fi
    mkdir -p "$plugin_root"
    # New machines get the current default branch; existing clones never auto-update.
    git clone --depth=1 "$repo" "$destination"
    if [ ! -r "$destination/$name.plugin.zsh" ]; then
        printf '%s\n' "$name loader is missing after clone; stopping." >&2
        return 1
    fi
}

install_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git
install_plugin fzf-tab https://github.com/Aloxaf/fzf-tab.git
install_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
