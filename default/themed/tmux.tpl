color_bg0="{{ background }}"
color_bg1="{{ color0 }}"
color_bg2="{{ color7 }}"
color_fg0="{{ foreground }}"
color_fg1="{{ color3 }}"

color_status_fg="{{ color4 }}"
color_status_bg="{{ color0 }}"

color_selected_fg="{{ selection_foreground }}"
color_selected_bg="{{ selection_background }}"

color_highlight_fg="{{ color2 }}"
color_highlight_bg="{{ background }}"

color_current_fg="{{ color1 }}"
color_current_bg="{{ background }}"

color_check_fg="{{ color5 }}"

pane_border_fg="{{ foreground }}"
pane_border_selected_fg="{{ color2 }}"

set -g @prefix_highlight_fg "${color_highlight_fg}"
set -g @prefix_highlight_bg "${color_highlight_bg}"

# Status bar settings
set -g status-style "bg=${color_bg0},fg=${color_fg0}"
set -g status "on"
set -g status-bg "${color_bg0}"
set -g status-justify "left"
#set -g status-left-length "100"
set -g status-right-length "100"

set -g window-style "bg=${color_bg0},fg=${color_fg0}"
set -g window-active-style "bg=${color_bg0},fg=${color_fg0}"

# Messages
set -g message-style "fg=${color_selected_fg},bg=${color_selected_bg}"
set -g message-command-style "fg=${color_selected_fg},bg=${color_selected_bg}"

# Panes
set -g pane-border-style "fg=${pane_border_fg}"
set -g pane-active-border-style "fg=${pane_border_selected_fg}"

# Windows
set -g window-status-activity-style "fg=${color_fg0},bg=${color_bg0},none"
set -g window-status-separator ""
set -g window-status-style "fg=${color_fg0},bg=${color_bg0},none"

# Statusline - current window
set -g window-status-current-format "#[fg=${color_current_fg},bg=${color_current_bg}]#I: #[fg=${color_check_fg},bg=${color_current_bg}](✓) #[fg=${color_current_fg},bg=${color_current_bg}]#W "

# Statusline - other windows
set -g window-status-format "#[fg=${color_highlight_fg},bg=${color_highlight_bg}]#I: #[fg=${color_fg0},bg=${color_highlight_bg}]#W "

# Statusline - right side
set -g status-right "#[fg=${color_fg1},bg=${color_bg0},nobold,nounderscore,noitalics]%Y-%m-%d %H:%M #[fg=${color_fg0},bg=${color_highlight_fg}] #[fg=${color_fg0},bg=${color_bg1}] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) #[fg=${color_fg0},bg=${color_current_fg}] #[fg=${color_fg0},bg=${color_bg1}] #S #[fg=${color_fg0},bg=${color_status_fg}] #[fg=${color_fg0},bg=${color_bg1}] #h"

# Modes
set -g clock-mode-colour "${color_status_fg}"
set -g mode-style "fg=${color_highlight_fg} bg=${color_bg1} bold"

# Statusline - left side (empty)
set -g status-left ""

