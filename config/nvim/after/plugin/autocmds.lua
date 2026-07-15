-- When Nvim is idle or you switch focus/buffers, check if files changed
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "checktime",
})

-- get terminal to follow directory
-- vim.api.nvim_create_autocmd({ 'TermRequest' }, {
--     desc = 'Handles OSC 7 dir change requests',
--     callback = function(ev)
--         local pwd, n = string.gsub(ev.data.sequence, '\027]7;file://[^/]*', '')
--         if n <= 0 then return end
--         if vim.fn.isdirectory(pwd) == 0 then return end
--         if vim.api.nvim_get_current_buf() ~= ev.buf then return end
--         vim.cmd.cd(pwd)
--     end
-- })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = 'Check time',
  group = vim.api.nvim_create_augroup("sjb-checktime", { clear = true}),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('sjb-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- windows to close
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "OverseerForm",
    "OverseerList",
    "floggraph",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-summary",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  group = vim.api.nvim_create_augroup('sjb-quick-close', { clear = true }),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("sjb-wrap-spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("sjb-auto-create-dir", { clear = true}),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    if vim.fn.isdirectory(".jj") == 1 then
      vim.fn.jobstart({"jj", "status"}, {
        on_exit = function(_, exit_code)
          if exit_code ~= 0 then
            vim.notify("jj command failed", vim.log.levels.WARN)
          end
        end,
      })
    end
  end,
})

local gpgGroup = vim.api.nvim_create_augroup("customGpg", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
        pattern = "*.gpg",
        group = gpgGroup,
        callback = function()
                -- Make sure nothing is written to shada file while editing an encrypted file.
                vim.opt_local.shada = nil
                -- We don't want a swap file, as it writes unencrypted data to disk
                vim.opt_local.swapfile = false
                -- Switch to binary mode to read the encrypted file
                vim.opt_local.bin = true
                -- Save the current 'ch' value to a buffer-local variable
                vim.b.ch_save = vim.opt_local.ch:get()
                vim.cmd "set ch=2"
        end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
        pattern = "*.gpg",
        group = gpgGroup,
        callback = function()
                vim.cmd "'[,']!gpg --decrypt 2> /dev/null"
                -- Switch to normal mode for editing
                vim.opt_local.bin = false
                -- Restore the 'ch' value from the buffer-local variable
                vim.opt_local.ch = vim.b.ch_save
                vim.cmd "unlet b:ch_save"
                vim.cmd(":doautocmd BufReadPost " .. vim.fn.expand "%:r")
        end,
})

-- Convert all text to encrypted text before writing
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
        pattern = "*.gpg",
        group = gpgGroup,
        callback = function()
                -- Switch to binary mode to write the encrypted file
                vim.opt_local.bin = true
                -- So we can avoid the armor option
                vim.cmd("'[,']!gpg --default-recipient-self -e 2>/dev/null")
        end,
})
-- Undo the encryption so we are back in the normal text, directly after the file has been written.
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
        pattern = "*.gpg",
        group = gpgGroup,
        callback = function()
                vim.cmd("u")
                -- Switch to normal mode for editing
                vim.opt_local.bin = false
        end,
})
