# Create a predictable symlink to the current SSH auth socket.
# tmux forces SSH_AUTH_SOCK to ~/.ssh/ssh_auth_sock globally
# (see config/tmux/tmux.conf), so this symlink must exist for every
# interactive shell -- not just bash login shells.
#
# For herdr (which lacks tmux's setenv -g): if we inherit a real
# SSH_AUTH_SOCK, update the symlink. Then always export the symlink
# path so new panes that didn't inherit the env still pick it up.
set -l auth_sock "$HOME/.ssh/ssh_auth_sock"

# If we have a real socket (not the symlink), refresh the symlink
if set -q SSH_AUTH_SOCK; and test "$SSH_AUTH_SOCK" != "$auth_sock"; and test -S "$SSH_AUTH_SOCK"
    mkdir -p "$HOME/.ssh"
    ln -sf "$SSH_AUTH_SOCK" "$auth_sock"
end

# Always export the symlink path if it points to a live socket
if test -S "$auth_sock"
    set -gx SSH_AUTH_SOCK "$auth_sock"
end

