set -g fish_color_valid_path

if status is-interactive

    # theme
    # set -g theme_color_scheme terminal-dark
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always

    fish_config prompt choose default
    fish_hybrid_key_bindings

    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.cargo/bin"

    set -gx npm_config_prefix "$HOME/.local"

    if command -q mise
        mise activate fish | source
    end

    if command -q direnv
        direnv hook fish | source
    end

    if command -q zoxide;
        zoxide init fish | source
    end

    if command -q fzf
       fzf --fish | source
       alias zk="nvim \$(fzf --walker=file --walker-root=/home/sjb/Documents/nca-notes/ --preview 'bat --color=always -n --line-range :500 {}')"
       #set -gx FZF_CTRL_T_OPTS  "--preview 'bat --color=always -n --line-range :500 {}'"
       #set -gx FZF_ALT_C_OPTS "--preview 'eza --icons=always --color=always {} | head -200'"
    end

    if command -q jj
        jj util completion fish | source
    end

    # fish_config theme choose "kanagawa"
    # fish_config theme choose "Dracula"

    command -q nmcli && alias nmlist "nmcli device wifi list"
    if command -q tree 
        alias tree "tree -L 3 -a -I '.git' --charset X "
        alias dtree "tree -L 3 -a -d -I '.git' --charset X "
    end

    if command -q wl-copy 
        alias cwd "wl-copy \$(pwd)"
        alias cc  "wl-copy \$(echo \$history[1])"
    end

    command -q fabric && alias ai "fabric -p \$(fabric-ai -l | fzf)"
    command -q xdg-open && alias o "xdg-open"

    command -q lazygit && alias lg lazygit


    if command -q nvim
        set -gx EDITOR nvim
    else if command -qv vim
        set -gx EDITOR vim
    end 

    command -q jj && alias rev "jj log -G -T 'commit_id.short(8)'"

    if command -q shred
        alias nuke "shred -u -n 1" 
    end
    
    if command -q wt
        alias wtc "wt switch --create --execute=$EDITOR"
        alias wts "wt switch"
        alias wtr "wt remove @"
    end

    if command -q opencode
        alias oc "opencode"
    end

    # Commands to run in interactive sessions can go here
    alias ll="exa -l -g --icons"
    alias ls="exa -al --color=always --group-directories-first"
    alias oo="cd ~/Documents/nca-notes/"
    alias on="v +Obsidian new"
    alias os="v +Obsidian search"
    alias cat="bat"
    alias g=git

    set -gx VISUAL $EDITOR

    # NVM
    function __check_nvm --on-variable PWD --description 'Do nvm stuff'
             status --is-command-substitution; and return

             if test -f .nvmrc; and test -r .nvmrc;
                nvm use
             else
             end
    end
end
