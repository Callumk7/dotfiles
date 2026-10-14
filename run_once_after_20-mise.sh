#!/bin/sh
set -eu

export PATH="$HOME/.local/bin:$PATH"
# Homebrew paths are relevant only on macOS, never Fedora.
if [ "$(uname -s)" = Darwin ]; then
    export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi

if ! command -v mise >/dev/null 2>&1; then
    if [ -e "$HOME/.local/bin/mise" ] || [ -L "$HOME/.local/bin/mise" ]; then
        printf '%s\n' 'A non-executable mise already exists in ~/.local/bin; stopping instead of overwriting it.' >&2
        exit 1
    fi
    if ! command -v curl >/dev/null 2>&1; then
        printf '%s\n' 'curl is required to install mise; stopping.' >&2
        exit 1
    fi
    # Download first so a failed fetch cannot be hidden by a shell pipeline.
    umask 077
    installer=$(mktemp "${TMPDIR:-/tmp}/dotfiles-mise.XXXXXX")
    trap 'rm -f "$installer"' EXIT
    trap 'exit 1' HUP INT TERM
    curl -fsSL https://mise.run -o "$installer"
    MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh "$installer"
fi

config="${XDG_CONFIG_HOME:-$HOME/.config}/mise/config.toml"
if [ ! -r "$config" ]; then
    printf '%s\n' 'The managed mise config is missing; stopping.' >&2
    exit 1
fi

# Use the user-level config, not an incidental project working directory.
cd "$HOME"
mise install
