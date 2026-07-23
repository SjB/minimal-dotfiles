vim.pack.add({
    { src = 'https://github.com/hedyhli/outline.nvim' },
})

require('outline').setup({
    symbol_folding = {
        -- Unfold entire symbol tree by default with false, otherwise enter a
        -- number starting from 1
        autofold_depth = false,
        -- autofold_depth = 1,
    },
})
vim.keymap.set('n', '<leader>so', '<cmd>Outline<CR>', { desc = "Toggle outline" })
