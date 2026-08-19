vim.keymap.set({ 'n' }, '<leader>mp', '<cmd>Pi<cr>', { noremap = true, silent = true, desc = "Toggle Pi Agent" })
vim.pack.add({
    "https://github.com/zgs225/pi2.nvim",
    -- Default chat-history renderer (render.engine = "render-markdown"):
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("pi").setup()
