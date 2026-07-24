
function refresh_ssh_agent --on-event fish_preexec --on-event fish_postexec
    if set -q TMUX
        # Fetch the current SSH_AUTH_SOCK from the active tmux environment
        set -l tmux_sock (tmux show-environment | string match -r '^SSH_AUTH_SOCK=(.*)')
        if test -n "$tmux_sock"
            # Extract the path from the 'SSH_AUTH_SOCK=/path/to/sock' string
            set -l sock_path (string split -m 1 '=' $tmux_sock)[2]
            if test -n "$sock_path"; and test "$SSH_AUTH_SOCK" != "$sock_path"
                set -gx SSH_AUTH_SOCK $sock_path
            end
        end
    end
end
