vim.pack.add({ "https://github.com/alex35mil/pi.nvim" })

vim.keymap.set({'n'}, '<leader>mp', '<cmd>Pi<cr>',  { noremap = true, silent = true, desc = "Toggle Pi Agent" })
require("pi").setup({
    cli = {
        args = { "--approve" },
    },
})

