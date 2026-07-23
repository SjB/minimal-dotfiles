vim.pack.add({
    { src = 'https://github.com/folke/persistence.nvim' },
})

require("persistence").setup({
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
  options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used when saving sessions
})

vim.keymap.set('n', "<leader>xr", function() require("persistence").load() end, { desc = "Restore Session"  })
vim.keymap.set('n', "<leader>xs", function() require("persistence").save() end, { desc = "Save Session"  })
vim.keymap.set('n', "<leader>xl", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session"  })
vim.keymap.set('n', "<leader>xd", function() require("persistence").stop() end, { desc = "Don't Save Current Session"  })
