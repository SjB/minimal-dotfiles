vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-ansible' },
})

vim.keymap.set('v', '<leader>xa', function() require('ansible').run() end, { buffer = true, silent = true, desc = 'execute via ansible' })
vim.keymap.set('n', '<leader>xa', ":w<CR> :lua require('ansible').run()<CR>", { buffer = true, silent = true, desc = 'execute via ansible' })
