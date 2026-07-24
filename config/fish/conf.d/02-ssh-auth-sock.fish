# Create a predictable symlink to the current SSH auth socket.
# tmux forces SSH_AUTH_SOCK to ~/.ssh/ssh_auth_sock globally
# (see config/tmux/tmux.conf), so this symlink must exist for every
# interactive shell -- not just bash login shells.
set -l auth_sock "$HOME/.ssh/ssh_auth_sock"
if set -q SSH_AUTH_SOCK; and test "$SSH_AUTH_SOCK" != "$auth_sock"; and test -S "$SSH_AUTH_SOCK"
    mkdir -p "$HOME/.ssh"
    ln -sf "$SSH_AUTH_SOCK" "$auth_sock"
end
