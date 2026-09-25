* {
    background: {{ background }};
    foreground: {{ foreground }};
    active-background: {{ lighter_background }};
    urgent-background: {{ accent }};

    normal-foreground: {{ dark_foreground }};
    normal-background: {{ dark_background }};

    selected-foreground: {{ selection_foreground }};
    selected-background: {{ selection_background }};

    seperator-color: {{ background }};
    border-color: {{ accent }};

    prompt-color: {{ light_foreground }};
    prompt-background-color: {{ darker_background }};

    window-border-size: 1px;
    window-border-radius: 8px;

    background-color: @background;
    text-color: @foreground;
}


