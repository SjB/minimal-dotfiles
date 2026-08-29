hl.config({
    general = {
        col = {
            active_border = { colors = {"rgb({{ accent_strip }})", "rgb({{ color1_strip }})" }, angle = 45 },
            inactive_border = { colors = {"rgb({{ color2_strip }})", "rgb({{ color2_strip }})" }, angle = 45 }
        }
    },
    group = {
        col = {
            border_active = { colors = {"rgb({{ accent_strip }})", "rgb({{ color1_strip }})" }, angle = 45 },
            border_inactive = { colors = {"rgb({{ color2_strip }})", "rgb({{ color2_strip }})" }, angle = 45 }
        }
    }
})
