vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.ai' },
    { src = 'https://github.com/nvim-mini/mini.align' },
    { src = 'https://github.com/nvim-mini/mini.bracketed' },
    { src = 'https://github.com/nvim-mini/mini.extra' },
    { src = 'https://github.com/nvim-mini/mini.files' },
    { src = 'https://github.com/nvim-mini/mini.hipatterns' },
    { src = 'https://github.com/nvim-mini/mini.move' },
    { src = 'https://github.com/nvim-mini/mini.operators' },
    { src = 'https://github.com/nvim-mini/mini.sessions' },
    { src = 'https://github.com/nvim-mini/mini.splitjoin' },
    { src = 'https://github.com/nvim-mini/mini.surround' },
})

local MiniExtra = require('mini.extra')
local ai = require('mini.ai')
local spec_treesitter = ai.gen_spec.treesitter

ai.setup({
    custom_textobjects = {
        F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
        C = spec_treesitter({ a = '@comment.outer', i = '@comment.inner' }),
        P = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
        O = spec_treesitter({ a = '@block.outter', i = '@block.inner' }),
        k = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
        o = spec_treesitter({
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
        })
    }
})

require('mini.move').setup()
require('mini.align').setup()
require('mini.bracketed').setup()
require('mini.operators').setup({
    evaluate = { prefix = 'g|', func = nil, },
    exchange = { prefix =  'g.', reindent_linewise = true, },
    multiply = { prefix = 'gm', func = nil, },
    replace = { prefix = 'gk', reindent_linewise = true, },
    sort = { prefix = 'gs', func = nil, }
})

require('mini.surround').setup({
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    -- custom_surroundings = {
    --     s = { input = { '%[%[().-()%]%]' }, output = { left = '[[', right =  ']]' } },
    -- },
    mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
    }
})

require('mini.splitjoin').setup()

local hi_words = MiniExtra.gen_highlighter.words
require('mini.hipatterns').setup({
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = hi_words({ 'FIXME', 'Fixme', 'fixme' }, "MiniHipatternsFixme"),
        hack = hi_words({ 'HACK', 'Hack', 'hack' }, "MiniHipatternsHack"),
        todo = hi_words({ 'TODO', 'Todo', 'todo' }, "MiniHipatternsTodo"),
        note = hi_words({ 'NOTE', 'Note', 'note' }, "MiniHipatternsNote"),
        done = hi_words({ 'DONE', 'Done', 'done' }, "MiniHipatternsFixme"),

        -- Highlight hex color strings (`#rrggbb`) using that color
        -- hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

vim.keymap.set('n', "<leader>q", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, { desc = "Open parent directory" })
vim.keymap.set('n', "<leader>Q", function() require("mini.files").open() end, { desc = "File Explore" })
require('mini.files').setup({
    mappings = {
        go_in_plus = "<cr>",
        go_out_plus = "<Esc>",
    },
})

require('mini.sessions').setup({
    directory = '~/.cache/nvim/sessions',
})
