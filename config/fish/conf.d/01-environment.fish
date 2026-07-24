fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"

set -gx npm_config_prefix "$HOME/.local"

if command -q nvim 
    set -gx EDITOR nvim
fi
set -gx VISUAL $EDITOR
