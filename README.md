# dotfiles

Personal baseline dotfiles managed by chezmoi, with development runtimes managed by mise.

## Platforms

- **Fedora Server (first target):** dnf installs shell/editor packages and build prerequisites. Homebrew is never used on Linux.
- **macOS:** install Homebrew and Xcode Command Line Tools manually first. The Brewfile installs chezmoi, mise, Neovim, ripgrep, and the Tree-sitter CLI required for Neovim parser builds.

## Bootstrap safety

Before every apply, review `chezmoi diff`. The repository includes scripts that install packages:

1. `run_once_before_10-packages.sh.tmpl` runs before dotfiles are written. On Fedora it runs `dnf install` as root, or `sudo dnf install` as a regular user. On macOS it runs `brew bundle install --no-upgrade`; installing missing packages can still update dependencies.
2. `run_once_after_20-mise.sh` runs after the mise config is written. It installs mise from https://mise.run only when missing, then runs `mise install` from the home directory.

3. `run_once_after_30-oh-my-zsh.sh` clones Oh My Zsh at a recorded commit when missing. Existing installations are untouched. It does not run the standard installer or rewrite `.zshrc`.

These scripts do not change the login shell, uninstall old version managers, or copy private configuration. They stop on failures. Do not run apply until package installation and any required sudo use have been approved.

`run_once` means once per successful rendered-script content hash. Editing a script can cause it to run again. Brewfile changes also change the macOS package script's hash. After changing runtime versions, run `mise install` explicitly; the plain after-script does not rerun merely because the mise config changed.

## Neovim

The existing NvChad configuration and `lazy-lock.json` are tracked. The initial lazy.nvim clone uses the commit in that lockfile. Restore locked plugin versions with `:Lazy restore`; do not use `:Lazy update` during bootstrap verification.

Mason owns language-server and formatter installation. Install the required tools through `:Mason`; enabling a server in the config does not itself declare a Mason installation list. Some tools also need runtimes such as Java or .NET, which are not installed by this first-pass bootstrap. On Fedora, native Neovim plugins and Erlang source builds use the provided compiler/build packages. Optional Erlang GUI/Java build components are not included.

## Private machine configuration

The shared `.zshrc` optionally sources `~/.config/zsh/local.zsh` after mise activation. If the overlay has not already loaded Oh My Zsh, a fallback loads the installed framework with `robbyrussell` and the `git` plugin by default; automatic framework updates are disabled for this fallback. This preserves a Mac overlay that already loads Spaceship and custom plugins, without loading the framework twice. Keep this overlay private; it is deliberately excluded from chezmoi. A fresh machine works without it, but private settings require a separate secure transfer.

The Mac's existing `.zprofile` and OrbStack SSH integration remain unmanaged. Never add SSH private keys, tokens, `.env` files, authentication stores, or shell history to this repository.
