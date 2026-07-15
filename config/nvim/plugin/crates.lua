
local crates = require("crates")
local opts = { silent = true }

vim.keymap.set("n", "<leader>cct", crates.toggle, { desc = 'toggle' })
vim.keymap.set("n", "<leader>ccr", crates.reload, { desc = 'reload' })
vim.keymap.set("n", "<leader>ccv", crates.show_versions_popup, { desc = 'show versions' })
vim.keymap.set("n", "<leader>ccf", crates.show_features_popup, { desc = 'show features' })
vim.keymap.set("n", "<leader>ccd", crates.show_dependencies_popup, { desc = 'show dependencies' })
vim.keymap.set("n", "<leader>ccu", crates.update_crate, { desc = 'update' })
vim.keymap.set("v", "<leader>ccu", crates.update_crates, { desc = 'update' })
vim.keymap.set("n", "<leader>cca", crates.update_all_crates, { desc = 'update all' })
vim.keymap.set("n", "<leader>ccU", crates.upgrade_crate, { desc = 'upgrade' })
vim.keymap.set("v", "<leader>ccU", crates.upgrade_crates, { desc = 'upgrade' })
vim.keymap.set("n", "<leader>ccA", crates.upgrade_all_crates, { desc = 'upgrade all' })
vim.keymap.set("n", "<leader>ccx", crates.expand_plain_crate_to_inline_table, { desc = 'expand' })
vim.keymap.set("n", "<leader>ccX", crates.extract_crate_into_table, { desc = 'extract' })
vim.keymap.set("n", "<leader>ccH", crates.open_homepage, { desc = 'open homepage' })
vim.keymap.set("n", "<leader>ccR", crates.open_repository, { desc = 'open repository' })
vim.keymap.set("n", "<leader>ccD", crates.open_documentation, { desc = 'open documents' })
vim.keymap.set("n", "<leader>ccC", crates.open_crates_io, { desc = 'open crates.io' })
vim.keymap.set("n", "<leader>ccL", crates.open_lib_rs, { desc = 'open lib.rs' })

require('crates').setup({
    completion = {
        crates = {
            enabled = true,
        },
    },
    lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
    },
})
