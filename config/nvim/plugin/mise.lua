if vim.fn.executable("mise") == 1 then
    vim.pack.add({
        { src = 'https://plugins.ejri.dev/mise.nvim' },
    })

    require('mise').setup({
        unset_vars = true,
        load_on_setup = true,
        force_run = true,
    })

    vim.keymap.set({'n'}, '<leader>xM', '<cmd>Lazy reload mise.nvim<cr>', { desc = "Reload mise environment"  })
end
