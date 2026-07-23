vim.pack.add({{ src = "https://github.com/martindur/zdiff.nvim" }})

vim.keymap.set('n', "<leader>gz", "<cmd>Zdiff<cr>", { desc = "Zdiff (uncommitted)" })
vim.keymap.set('n', "<leader>gZ", "<cmd>Zdiff main<cr>", { desc = "Zdiff (vs main)" })
