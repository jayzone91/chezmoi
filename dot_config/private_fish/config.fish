if status is-interactive
  # Commands to run in interactive sessions can go here
  # nvm
  nvm use lts
  clear
end

# Disable welcome message
set -g fish_greeting

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# FZF
fzf --fish | source
# Zoxide
zoxide init fish | source
# Starship
starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# abbr
abbr vim "nvim"

# Rust
set PATH $HOME/.cargo/bin/ $PATH

# Helpful aliases
command -q exa; and alias la="exa -abghl --git --color=automatic"
command -q exa; and alias ll="exa -bghl --git --color=automatic"

# Fisher!
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
