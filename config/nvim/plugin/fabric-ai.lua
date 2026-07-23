if vim.fn.executable("fabric-ai") == 1 then
    vim.pack.add({
        { src = 'https://github.com/PhantomYdn/fabric-ai.nvim' },
    })

    require('fabric-ai').setup({
        -- Default configuration (all optional)
        fabric_path = "fabric-ai", -- Path to Fabric CLI
        patterns_path = nil,   -- Custom patterns dir (auto-detect if nil)
        timeout = 300000,      -- Command timeout in ms (5 minutes)
        window = {
            width = 0.8,       -- 80% of editor width
            height = 0.8,      -- 80% of editor height
            border = "rounded",
        },
    })

    vim.keymap.set({ 'v' }, "<leader>fa", ":'<,'>Fabric<CR>", { desc = "Fabric AI" })
    vim.keymap.set({ 'n' }, '<leader>fa', ':Fabric<CR>', { desc = "Fabric AI" })
    vim.keymap.set({ 'n' }, '<leader>fu', ':Fabric url<CR>', { desc = "Fabric URL" })
end
