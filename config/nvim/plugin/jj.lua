if vim.fn.executable("jj") == 1 then
    vim.pack.add({ 
        { src = 'https://github.com/Glhou/jjsigns.nvim', version = 'fix/skip-extra-lines' },
        { src = 'https://github.com/julienvincent/hunk.nvim' },
        { src = 'https://github.com/NicolasGB/jj.nvim' },
        { src = 'https://github.com/rafikdraoui/jj-diffconflicts' },
    })
    
    local cmd = require("jj.cmd")
    local annotate = require("jj.annotate")

    vim.keymap.set("n", "<leader>vja", annotate.file, { desc = "JJ annotate file" })
    vim.keymap.set("n", "<leader>vjA", annotate.line, { desc = "JJ annotate line" })
    vim.keymap.set("n", "<leader>vjbc", cmd.bookmark_create, { desc = "JJ bookmark create" })
    vim.keymap.set("n", "<leader>vjbd", cmd.bookmark_delete, { desc = "JJ bookmark delete" })
    vim.keymap.set("n", "<leader>vjbm", cmd.bookmark_move, { desc = "JJ bookmark move" })
    vim.keymap.set("n", "<leader>vjd", cmd.describe, { desc = "JJ describe" })
    vim.keymap.set("n", "<leader>vjl", cmd.log, { desc = "JJ log" })
    vim.keymap.set("n", "<leader>vje", cmd.edit, { desc = "JJ edit" })
    vim.keymap.set("n", "<leader>vjn", cmd.new, { desc = "JJ new" })
    --vim.keymap.set("n", "<leader>vjs", cmd.status, { desc = "JJ status" })
    vim.keymap.set("n", "<leader>vjS", cmd.squash, { desc = "JJ squash" })
    vim.keymap.set("n", "<leader>vjju", cmd.undo, { desc = "JJ undo" })
    vim.keymap.set("n", "<leader>vjr", cmd.rebase, { desc = "JJ rebase" })
    vim.keymap.set("n", "<leader>vjR", cmd.redo, { desc = "JJ redo" })
    vim.keymap.set("n", "<leader>vjf", cmd.fetch, { desc = "JJ fetch" })
    vim.keymap.set("n", "<leader>vjx", cmd.abandon, { desc = "JJ abandon" })
    vim.keymap.set("n", "<leader>vjpp", cmd.push, { desc = "JJ push" })
    vim.keymap.set("n", "<leader>vjpr", cmd.open_pr, { desc = "JJ open PR from bookmark in current revision or parent" })
    vim.keymap.set("n", "<leader>vjpl", function()
        cmd.open_pr { list_bookmarks = true }
    end, { desc = "JJ open PR listing available bookmarks" })


    -- Diff commands
    local diff = require("jj.diff")
    vim.keymap.set("n", "<leader>vjdv", function() diff.open_vdiff() end, { desc = "JJ diff current buffer" })
    vim.keymap.set("n", "<leader>vjdh", function() diff.open_hsplit() end, { desc = "JJ hdiff current buffer" })

    -- Pickers
    local picker = require("jj.picker")
    vim.keymap.set("n", "<leader>vjs", function() picker.status() end, { desc = "JJ Picker status" })
    vim.keymap.set("n", "<leader>vjh", function() picker.file_history() end, { desc = "JJ Picker history" })

    -- Some functions like `log` can take parameters
    vim.keymap.set("n", "<leader>vjL", function()
        cmd.log {
            revisions = "all()", -- equivalent to jj log -r ::
        }
    end, { desc = "JJ log all" })


    -- This is an alias i use for moving bookmarks its so good
    vim.keymap.set("n", "<leader>vjt", function()
        cmd.j "tug"
        cmd.log {}
    end, { desc = "JJ tug" })

    require("jj").setup({
        diff = {
            backend = "native",
        },
        cmd = {
            describe = {
                editor = {
                    type = "buffer",
                }
            }
        },
        describe = {
            editor = {
                type = "buffer",
            }
        }
    })

    require("hunk").setup()
    require('jjsigns').setup({
        enabled = true,
        attach = {
            auto = false,
        }
    })

    vim.keymap.set("n", "<leader>uJ", function() require('jjsigns').toggle() end, { desc = "Toggle JJ signs" })
end
