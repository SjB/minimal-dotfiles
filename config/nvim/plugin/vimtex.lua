vim.pack.add({
    { src = 'https://github.com/lervag/vimtex' },
})
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura" -- Change to your preferred PDF viewer
vim.g.vimtex_quickfix_mode = 0       -- Disable quickfix window
--      vim.opt.conceallevel = 2             -- Enable concealment for nicer inline math display
vim.g.tex_conceal = "abdmg"          -- Conceal accents, bold, delimiters, math, Greek
