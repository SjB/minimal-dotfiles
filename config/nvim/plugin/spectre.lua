
vim.keymap.set({ 'n' }, "<leader>sr", function() require("spectre").open() end, { desc = "Replace in files (Spectre)" })

require('spectre').setup({ 
    open_cmd = "noswapfile vnew",
    highlight = {
        search = "SpectreSearch",
        replace = "SpectreReplace",
    },
    mapping = {
        ["send_to_qf"] = {
            map = "<C-q>",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix",
        },
    },
})
