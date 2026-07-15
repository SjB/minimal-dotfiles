
local conform = require('conform')

conform.setup({
    notify_on_error = false,
    formatters = {
        shfmt = {
            prepend_args = { "-i", "2", "-ci" },
        },
        dprint = {
            condition = function(ctx)
                return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
            end,
        },
    },
    formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        lua = { 'stylua' },
        go = { "goimports", "gofmt" },
        rust = { "dprint", "rustfmt", lsp_format = "fallback" },
        python = { "isort", "black", stop_after_first = true },
        javascript = { "dprint", "prettier", stop_after_first = true   },
        markdown = { "dprint", "prettier", stop_after_first = true },
        javascriptreact = { "dprint", "prettier", stop_after_first = true },
        typescript = { "dprint", "prettier", stop_after_first = true },
        typescriptreact = { "dprint", "prettier", stop_after_first = true },
        svelte = { "dprint", "prettier", stop_after_first = true },
        html = { "dprint", "prettier", stop_after_first = true },
    },
})

vim.keymap.set({ 'n', 'v' }, '<leader>bf',
function()
    conform.format { async = true, lsp_format = 'fallback' }
end,
{ desc = 'Format buffer' })


