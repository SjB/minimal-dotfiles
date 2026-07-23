vim.pack.add({
    { src = 'https://github.com/akinsho/toggleterm.nvim' },
})

require("toggleterm").setup({
    -- highlights = require("rose-pine.plugins.toggleterm"),
    size = 20,
    open_mapping = [[<c-/>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persiste_size = true,
    shell = vim.env.SHELL,
    direction = 'horizontal',
    close_on_exit = true,
    float_opts = {
        border = "curved",
    }
})

vim.keymap.set('t', "<esc><esc>", "<c-\\><c-n>", { desc = "Escape input" })
vim.keymap.set('t', "<leader><esc>", "<c-\\><c-n>", { desc = "Escape input" })
