vim.pack.add({
    { src = 'https://github.com/folke/flash.nvim' },
})

require('flash').setup({
    modes = {
        char = {
            jump_labels = true,
            search = { wrap = true },
            highlight = { backdrop = false },
        },
        search = {
            -- when `true`, flash will be activated during regular search by default.
            -- You can always toggle when searching with `require("flash").toggle()`
            enabled = true,
            highlight = { backdrop = false },
            jump = { history = true, register = true, nohlsearch = true, autojump = true },
            search = {
                wrap = true,
                -- `forward` will be automatically set to the search direction
                -- `mode` is always set to `search`
                -- `incremental` is set to `true` when `incsearch` is enabled
            },
        },
        treesitter = {
            search = { wrap = true },
        }
    },
})

vim.keymap.set({ "n" }, "<leader>/", function() require("flash").treesitter() end, { desc = "Flash Treesitter"  })
vim.keymap.set({ "x", "o" }, "s", function() require("flash").treesitter() end, { desc = "Flash Treesitter"  })
vim.keymap.set({ "o" }, "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search"  })
vim.keymap.set({ "c" }, "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search"  })
