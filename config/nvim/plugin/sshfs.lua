
vim.pack.add({
    { src = 'https://github.com/uhs-robert/sshfs.nvim' },
})

require('sshfs').setup({
    mounts = {
        base_dir = vim.fn.expand("$HOME") .. "/Public", -- where remote mounts are created
    },
    lead_prefix = "<leader>t",     
    -- Refer to the configuration section below
    -- or leave empty for defaults
})

