if vim.fn.executable("zoxide") == 1 then
    vim.pack.add({
        { src = 'https://github.com/thunder-coding/zincoxide' },
    })
    require('zincoxide').setup({
        zincoxide_cmd = "zoxide",
        complete = true,
        behaviour = "tabs",
    })
end

