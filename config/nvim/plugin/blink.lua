vim.pack.add({
    { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range('1.*') },
    { src = 'https://github.com/fang2hou/blink-copilot' },
    { src = 'https://github.com/moyiz/blink-emoji.nvim' },
})

require('blink.cmp').setup({
    enabled = function()
        local filetype = vim.bo[0].filetype
        if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
            return false
        end
        return true
    end,
    snippets = { preset = 'luasnip' },
    completion = {
        --   keyword = {
            --     -- 'prefix' will fuzzy match on the text before the cursor
            --     -- 'full' will fuzzy match on the text before *and* after the cursor
            --     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
            --     range = "full",
            --   },
            -- keymap = {
            --     -- Change "<Tab>" to "<Right>" if you prefer the arrow key
            --     ["C-y"] = { "select_and_accept", "fallback" }, 
            -- },
            menu = {
                draw = {
                    treesitter = { 'lsp' }
                }
                --     border = "single",
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                }
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                -- window = {
                    --     border = "single",
                    -- },
                },
                -- ghost_text = { enabled = true },
            },
            -- completion = {
            --     ghost_text = { enabled = true },
            -- },
            cmdline = {
                enabled = true,
            },
            signature = { enabled = true },
            sources = {
                per_filetype = {
                    org = {'orgmode'}
                },
                default = { 'orgmode', 'lsp', 'snippets', 'path', 'omni', 'buffer', 'markdown' },
                -- default = { 'orgmode', 'lsp', 'snippets', 'path', 'omni', 'buffer', 'codecompanion', 'markdown' },
                providers = {
                    orgmode = {
                        name = 'Orgmode',
                        module = 'orgmode.org.autocompletion.blink',
                        fallbacks = { 'buffer' },
                    },
                    markdown = {
                        name = 'RenderMarkdown',
                        module = 'render-markdown.integ.blink',
                        score_offset = 80,
                    },
                    lsp = {
                        name = 'lsp', -- IMPORTANT: use the same name as you would for nvim-cmp
                        enabled = true,
                        module = 'blink.cmp.sources.lsp',
                        -- fallbacks = { 'snippets', 'buffer', 'path' },
                        score_offset = 100,
                    },
                    path = {
                        name = 'path', -- IMPORTANT: use the same name as you would for nvim-cmp
                        module = 'blink.cmp.sources.path',
                        score_offset = 50,
                        fallbacks = { 'snippets', 'buffer' },
                        opts = {
                            trailing_slash = false,
                            label_trailing_slash = true,
                            get_cwd = function(context)
                                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                            end,
                            show_hidden_files_by_default = true,
                        },
                    },
                    buffer = {
                        name = "Buffer",
                        enabled = true,
                        max_items = 3,
                        module = "blink.cmp.sources.buffer",
                        min_keyword_length = 4,
                        score_offset = 15, -- the higher the number, the higher the priority
                    },
                    snippets = {
                        name = "snippets",
                        enabled = true,
                        max_items = 15,
                        min_keyword_length = 2,
                        module = "blink.cmp.sources.snippets",
                        score_offset = 90, -- the higher the number, the higher the priority
                    },
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 0, -- the higher the number, the higher the priority
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                    },
                },
            },
            appearance = {
                -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
                kind_icons = {
                    Copilot = "",
                    CodeCompanion = "",
                    Text = '󰉿',
                    Method = '󰊕',
                    Function = '󰊕',
                    Constructor = '󰒓',

                    Field = '󰜢',
                    Variable = '󰆦',
                    Property = '󰖷',

                    Class = '󱡠',
                    Interface = '󱡠',
                    Struct = '󱡠',
                    Module = '󰅩',

                    Unit = '󰪚',
                    Value = '󰦨',
                    Enum = '󰦨',
                    EnumMember = '󰦨',

                    Keyword = '󰻾',
                    Constant = '󰏿',

                    Snippet = '󱄽',
                    Color = '󰏘',
                    File = '󰈔',
                    Reference = '󰬲',
                    Folder = '󰉋',
                    Event = '󱐋',
                    Operator = '󰪚',
                    TypeParameter = '󰬛',
                },
            },
        })
