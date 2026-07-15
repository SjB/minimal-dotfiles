require("tree-sitter-manager").setup({
    -- Default Options
    -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
    -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
    -- auto_install = false, -- if enabled, install missing parsers when editing a new file
    -- highlight = true, -- treesitter highlighting is enabled by default
    -- languages = {}, -- override or add new parser sources
})

-- vim.g.no_plugin_maps = true
-- local ts_parsers = {
--     "bash",
--     "dockerfile",
--     "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
--     "go", "gomod", "gosum",
--     "json", "toml", "yaml",
--     "lua",
--     "make",
--     "markdown",
--     "python",
--     "terraform",
--     "vim", "vimdoc",
--     'c',
--     "lua",
--     "markdown",
--     "markdown_inline",
--     "query",
--     "html", "xml",
--     "zig",
--     "typescript", "javascript", "svelte",
--     "regex",
--     "rust",
--     "http",
-- }
--
-- local nts = require("nvim-treesitter")
-- nts.install(ts_parsers)
-- -- vim.api.nvim_create_autocmd('PackChanged', {
-- --     callback = function()
-- --         nts.update()
-- --     end
-- -- })
--
vim.api.nvim_create_autocmd("FileType", { -- enable treesitter highlighting and indents
    callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if vim.treesitter.language.add(lang) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.start()
        end
    end
})

-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = ts_parsers,
--     callback = function()
--         vim.treesitter.start()
--     end,
-- })

-- require('ts-context-commentstring').setup({
--     enable_autocmd = false
-- })

require("treesitter-context").setup({
    mode = "cursor",
    max_lines = 3,
    multiline_threshold = 1,
    separator = '-',
    min_window_height = 20,
    line_numbers = true,
})
