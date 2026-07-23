vim.pack.add({
    { src = "https://github.com/folke/trouble.nvim" },
})

require('trouble').setup({
    defaults = {
        auto_close = true,
        auto_open = true,
    },
})

vim.keymap.set('n', "<leader>cx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set('n', "<leader>cX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set('n', "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set('n', "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set('n', "<leader>cL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set('n', "<leader>cQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

