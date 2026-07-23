vim.pack.add({
    { src = 'https://github.com/salkin-mada/openscad.nvim' },
})

vim.g.openscad_load_snippets = true
require("openscad").setup({})
