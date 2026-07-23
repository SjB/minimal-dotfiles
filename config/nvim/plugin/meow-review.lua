vim.pack.add({
    { src = 'https://github.com/SjB/meow.review.nvim', version = 'fix-invalid-buffer-id' },
})

require("meow.review").setup({
-- Your custom configuration goes here
})

vim.keymap.set({ "n", "v" }, "<leader>ra", "<Plug>(MeowReviewAdd)", { desc = "Add Review Comment"  })
vim.keymap.set({ "n", "v" }, "<leader>rd", "<Plug>(MeowReviewDelete)", { desc = "Delete Review Comment"  })
vim.keymap.set({ 'n' }, "<leader>re", "<Plug>(MeowReviewEdit)", { desc = "Edit Review Comment"  })
vim.keymap.set({ 'n' }, "<leader>rv", "<Plug>(MeowReviewView)", { desc = "View Review Comment"  })
vim.keymap.set({ 'n' }, "<leader>rE", "<Plug>(MeowReviewExport)", { desc = "Export Review"  })
vim.keymap.set({ 'n' }, "<leader>rX", "<Plug>(MeowReviewExportAndClear)", { desc = "Export and Clear"  })
vim.keymap.set({ 'n' }, "<leader>rf", "<Plug>(MeowReviewExportFile)", { desc = "Export Current File"  })
vim.keymap.set({ 'n' }, "<leader>rc", "<Plug>(MeowReviewClear)", { desc = "Clear All Comments"  })
vim.keymap.set({ 'n' }, "<leader>rg", "<Plug>(MeowReviewGoto)", { desc = "Go to Review Comment"  })
vim.keymap.set({ 'n' }, "<leader>rG", "<Plug>(MeowReviewGotoFile)", { desc = "Go to Comment in File"  })
vim.keymap.set({ 'n' }, "<leader>rt", "<Plug>(MeowReviewGotoType)", { desc = "Go to Comment by Type"  })
vim.keymap.set({ 'n' }, "<leader>rR", "<Plug>(MeowReviewResolve)", { desc = "Resolve Comment"  })
vim.keymap.set({ 'n' }, "<leader>rA", "<Plug>(MeowReviewResolveAll)", { desc = "Resolve All Comments"  })
vim.keymap.set({ 'n' }, "<leader>rr", "<Plug>(MeowReviewReload)", { desc = "Reload Review"  })
vim.keymap.set({ 'n' }, "]r",         "<Plug>(MeowReviewNext)", { desc = "Next Review Comment"  })
vim.keymap.set({ 'n' }, "[r",         "<Plug>(MeowReviewPrev)", { desc = "Previous Review Comment"  })
