vim.pack.add({
    { src = 'https://github.com/mbbill/undotree' },
})

vim.keymap.set({'n'}, '<leader>uu', vim.cmd.UndotreeToggle, { desc = 'Undo Tree toggle' })
