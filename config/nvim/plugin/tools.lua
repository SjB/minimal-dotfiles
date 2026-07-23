vim.pack.add({
    { src = 'https://github.com/3rd/image.nvim' },
    { src = 'https://github.com/HakonHarnes/img-clip.nvim' },
})

require('img-clip').setup()
require('image').setup({
    backend = "sixel"
})

vim.keymap.set({'n'}, '<leader>kp', '<cmd>PasteImage<cr>', { desc = "Paste image from system clipboard"  })

