vim.pack.add({ 
    { src = 'https://github.com/NeogitOrg/neogit' },
    { src = 'https://github.com/sindrets/diffview.nvim' },
})

require('neogit').setup({
    -- disable_context_highlighting = true,
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
    disable_signs = true,
    integrations = { diffview = true, fz_lua = false },
    auto_refresh = false,
    console_timeout = 5000,
    auto_show_console = false,
    sections = {
        stashes = {
            folded = false,
        },
        recent = { folded = false },
    },
})

vim.keymap.set({'n'}, '<leader>vn', '<cmd>Neogit kind=auto<cr>', { desc = 'Neogit' })
vim.keymap.set({'n'}, '<leader>vN', '<cmd>Neogit kind=floating<cr>', { desc = 'Neogit' })

