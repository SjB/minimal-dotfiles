vim.pack.add({
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
})

-- build = "make install_jsregexp",
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({ paths = "./json_snippets" })

local luasnip = require("luasnip")
luasnip.add_snippets("zig", require("snippets.zig"))

vim.api.nvim_create_autocmd('PackChanged', { 
    callback = function()
        vim.system({ "make", "install_jsregexp" }, {}):wait()
    end
})

