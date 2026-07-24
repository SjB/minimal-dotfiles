vim.opt.background = 'dark'

vim.pack.add({{ src = 'https://github.com/folke/tokyonight.nvim' }})
require("tokyonight").setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
})

vim.cmd("colorscheme tokyonight")
