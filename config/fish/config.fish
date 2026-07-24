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
    command -q zero.js && alias zero 'zero.js'

    if command -q nvim 
        alias oo "cd $SECOND_BRAIN"
        alias on "nvim '+Obsidian new'"
        alias os "nvim '+Obsidian search'"
        alias mini "NVIM_APPNAME=mini.nvim nvim"
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

    if command -q /usr/bin/opencode
        alias oc "opencode"
    end

    # Commands to run in interactive sessions can go here
    if command -q eza
        alias ll "eza -l -g --icons"
        alias ls "eza -al --color=always --group-directories-first"
    end

    command -q bat && alias cat "bat"
    command -q git && alias g git

    if command -q jj
        /usr/bin/jj util completion fish | source
    end

    # NVM
    function __check_nvm --on-variable PWD --description 'Do nvm stuff'
             status --is-command-substitution; and return

             if test -f .nvmrc; and test -r .nvmrc;
                nvm use
             else
             end
    end
end
