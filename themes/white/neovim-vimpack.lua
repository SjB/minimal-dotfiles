vim.pack.add({{ src = 'https://github.com/bjarneo/white.nvim' }})

require("white").setup({})

vim.opt.background = 'light'
vim.cmd("colorscheme white")
