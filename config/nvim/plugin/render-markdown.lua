
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    -- render_modes = { 'n', 'v' },
    render_modes = true,
    enabled = true,
    anti_conceal = {
        enabled = false,
    },
    quote = { repeat_linebreak = true },
    checkbox = {
        -- unchecked = { icon = '✘ ' },
        checked = { icon = '✔ ', scope_highlight = '@markup.strikethrough' },
        custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
            important = { raw = '[~]', rendered = '󰓎 ', highlight = 'DiagnosticWarn', },
        },
    },
    latex = {
        enabled = false,
        converter = "latex2text",
    },
    win_options = {
        conceallevel = {
            default = 0,
            rendered = 2, -- Conceal level 2: hide LaTeX code fully
        },
        concealcursor = {
            default = "",
            rendered = "n", -- Conceal only in normal mode
        },
    }
})
