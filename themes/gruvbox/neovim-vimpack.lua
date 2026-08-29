vim.pack.add({{ src = 'https://github.com/ellisonleao/gruvbox.nvim' }})

require("gruvbox").setup({
    contrast = "hard",
    transparent_mode = true,
})

vim.opt.background = 'dark'
vim.cmd("colorscheme gruvbox")
