# dotfiles

Personal baseline dotfiles managed by chezmoi, with development runtimes and lazygit managed by mise.

## Platforms

- **Fedora Server (first target):** dnf installs shell/editor packages and build prerequisites. Homebrew is never used on Linux.
- **macOS:** install Homebrew and Xcode Command Line Tools manually first. The Brewfile installs chezmoi, mise, Neovim, ripgrep, fzf, zoxide, eza, bat, Delta, gh, glab, and the Tree-sitter CLI required for Neovim parser builds. Fedora uses dnf for the equivalent system tools. Lazygit comes from mise on both platforms, avoiding a Fedora COPR repository.

## Bootstrap safety

Before every apply, review `chezmoi diff`. The repository includes scripts that install packages:

1. `run_once_before_10-packages.sh.tmpl` runs before dotfiles are written. On Fedora it runs `dnf install` as root, or `sudo dnf install` as a regular user. On macOS it runs `brew bundle install --no-upgrade`; installing missing packages can still update dependencies.
2. `run_once_after_20-mise.sh.tmpl` runs after the mise config is written. It installs mise from https://mise.run only when missing, then runs `mise install` from the home directory. The rendered script includes a config checksum, so changing managed tool versions or adding tools triggers installation.

3. `run_once_after_30-oh-my-zsh.sh` clones Oh My Zsh at a recorded commit when missing, then installs missing autosuggestions, fzf-tab, and syntax-highlighting plugins from their current default branches without commit pins. Existing framework/plugin checkouts are untouched and never auto-updated. It does not run the standard installer or rewrite `.zshrc`.

These scripts do not change the login shell, uninstall old version managers, or copy private configuration. They stop on failures. Do not run apply until package installation and any required sudo use have been approved.

`run_once` means once per successful rendered-script content hash. Editing a script can cause it to run again. Brewfile changes also change the macOS package script's hash. Managed mise config changes change the after-script's hash and rerun `mise install` on the next approved apply. This installs newly declared tools without upgrading the pinned runtimes.

## Neovim

The existing NvChad configuration and `lazy-lock.json` are tracked. The initial lazy.nvim clone uses the commit in that lockfile. Restore locked plugin versions with `:Lazy restore`; do not use `:Lazy update` during bootstrap verification.

Mason owns language-server and formatter installation, not the machine bootstrap. The baseline is declared in `lua/configs/mason-tools.lua` and installed explicitly inside Neovim with `:MasonToolsInstall`. Startup installs and automatic tool updates are disabled. The command installs missing tools without upgrading existing unpinned tools; use `:MasonToolsUpdate` only when deliberately requesting updates.

The shared list contains only:

- Lua: `lua-language-server`, `stylua`.
- Web: `html-lsp`, `css-lsp`, `json-lsp`, `typescript-language-server`, `tailwindcss-language-server`.
- Formatting: `biome`, `prettier`, `shfmt`.
- Bash/Elixir: `bash-language-server`, `elixir-ls`.

The helper plugin itself is recorded in `lazy-lock.json`; it may be downloaded by lazy.nvim when first opening the updated editor, but no language servers or formatters are installed until the explicit command. Individual tool versions are not pinned by the lazy.nvim lockfile. The baseline uses the Node and Erlang/Elixir runtimes already provided by mise.

Use `:Mason` to install additional machine-specific tools. Existing LSP/formatter configurations remain available, and extra installed tools are not removed by `:MasonToolsInstall`. Do not run `:MasonToolsClean`: it removes tools outside the baseline list. Some optional tools need runtimes such as Java or .NET, which are not installed by this bootstrap. On Fedora, native Neovim plugins and Erlang source builds use the provided compiler/build packages. Optional Erlang GUI/Java build components are not included.

## Shell and Git conveniences

Shared aliases provide eza's `ls`, `ll`, `lts`, `lt`, `lta`, `lg`, and `lga`; bat's `cat` and `package`; and lazygit's `lz`. They are enabled only when their commands exist and load after framework defaults. These named shared aliases take precedence over earlier definitions, including private-overlay definitions. eza icons need a compatible font in the connecting terminal, not fonts installed on the headless server.

Lazygit 0.66.0 is managed by mise. Its existing Delta diff-renderer config is shared at native paths: `~/.config/lazygit/config.yml` on Linux and `~/Library/Application Support/lazygit/config.yml` on macOS. Only configuration is tracked, not lazygit state or pull-request caches.

GitHub and GitLab authentication stays private. Authenticate separately on each machine with `gh auth login` and `glab auth login`; never add their credential files to chezmoi.

## Private machine configuration

The shared `.zshrc` optionally sources `~/.config/zsh/local.zsh` after mise activation. If the overlay has not already loaded Oh My Zsh, a fallback loads the installed framework with `robbyrussell` and the shared plugins (`git`, `zoxide`, `fzf`, `fzf-tab`, `zsh-autosuggestions`, `zsh-interactive-cd`, and `zsh-syntax-highlighting`); automatic framework updates are disabled for this fallback. fzf-tab loads before widget wrappers, and syntax highlighting loads last. fzf and zoxide come from dnf/Homebrew. The other four plugins are bundled with Oh My Zsh. This preserves a Mac overlay that already loads Spaceship and custom plugins, without loading the framework twice. Keep this overlay private; it is deliberately excluded from chezmoi. A fresh machine works without it, but private settings require a separate secure transfer.

The Mac's existing `.zprofile` and OrbStack SSH integration remain unmanaged. Never add SSH private keys, tokens, `.env` files, authentication stores, or shell history to this repository.
