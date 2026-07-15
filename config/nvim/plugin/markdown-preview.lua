vim.g.mkdp_filetypes = { "markdown" }

vim.keymap.set("n", "<leader>xmp", "<cmd>MarkdownPreview<CR>", { desc ="Markdown Preview"  })
vim.keymap.set("n", "<leader>xms", "<cmd>MarkdownPreviewStop<CR>", { desc ="Markdown Preview Stop"  })

vim.api.nvim_create_autocmd('PackChanged', { 
    callback = function()
        vim.fn["mkdp#util#install"]()
    end
})
