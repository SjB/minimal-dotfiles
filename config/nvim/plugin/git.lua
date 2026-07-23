vim.pack.add({
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

vim.keymap.set({ 'n' }, '<leader>ug', "Gitsigns toggle_signs", { desc = 'Gitsigns toggle' })

require('gitsigns').setup({
            auto_attach = true,
            signs_staged_enable = true,
            signcolumn = true,
            current_line_blame_opts = {
                delay = 50
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Actions
                -- visual mode
                map('v', '<leader>vs', function()
                    gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'stage git hunk' })

                map('v', '<leader>vr', function()
                    gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'reset git hunk' })

                -- normal mode

                map('n', '[v', function() gitsigns.nav_hunk 'prev' end, { desc = 'git previous hunk' })
                map('n', ']v', function() gitsigns.nav_hunk 'next' end, { desc = 'git next hunk' })
                map('n', '<leader>vgs', gitsigns.stage_hunk, { desc = 'git stage hunk' })
                map('n', '<leader>vgr', gitsigns.reset_hunk, { desc = 'git reset hunk' })
                map('n', '<leader>vgS', gitsigns.stage_buffer, { desc = 'git stage buffer' })
                map('n', '<leader>vgu', gitsigns.undo_stage_hunk, { desc = 'git undo stage hunk' })
                map('n', '<leader>vgR', gitsigns.reset_buffer, { desc = 'git reset buffer' })
                map('n', '<leader>vgP', gitsigns.preview_hunk, { desc = 'git preview hunk' })
                map('n', '<leader>vgb', gitsigns.blame_line, { desc = 'git blame line' })
                map('n', '<leader>vgP', gitsigns.diffthis, { desc = 'git diff against index' })
                map('n', '<leader>vgD', function()
                    gitsigns.diffthis '@'
                end, { desc = 'git [D]iff against last commit' })
                -- Toggles
                map('n', '<leader>uvb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
                map('n', '<leader>uvd', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
            end,
        })


