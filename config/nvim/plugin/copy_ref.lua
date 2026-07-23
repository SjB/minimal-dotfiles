-- from smnatale's github.com/smnatale/nvim-config
--
-- Copy file path / selection reference for pasting into AI chats

local scratch_buf = nil
local scratch_buf_name = "copy-refs"

local function get_or_create_scratch()
	-- if we already created a buffer and it's still valid, reuse it
	if scratch_buf and vim.api.nvim_buf_is_valid(scratch_buf) then
		return scratch_buf
	end

    -- look for an existing buffer by name
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) then
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("/" .. scratch_buf_name .. "$") or name == scratch_buf_name then
                scratch_buf = buf
                return scratch_buf
            end
        end
    end

    -- create a new unlisted scratch buffer
    scratch_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(scratch_buf, scratch_buf_name)
    vim.bo[scratch_buf].buftype = "nofile"
    vim.bo[scratch_buf].bufhidden = "hide"
    vim.bo[scratch_buf].swapfile = false

	return scratch_buf
end

local function open_scratch()
		local buf = get_or_create_scratch()
		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.8)
		local row = math.floor((vim.o.lines - height) / 2)
		local col = math.floor((vim.o.columns - width) / 2)
		local _ = vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = width,
			height = height,
			row = row,
			col = col,
			style = "minimal",
			border = "rounded",
		})
		vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
end

local function copy_ref(opts)
	-- "%" is the current buffer's file name; ":." makes it relative to the cwd
	local path = vim.fn.expand("%:.")
	-- ref is what ends up in the clipboard; start with just the path
	local ref = path

	if opts.visual then
		-- '< and '> are only set after leaving visual mode, so read the live selection:
		-- "v" is the line where visual mode was started (the anchor)
		local start_line = vim.fn.line("v")
		-- "." is the line the cursor is on now (the moving end of the selection)
		local end_line = vim.fn.line(".")
		-- if the selection was made upward, swap so start is always the smaller line
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		-- append the range, e.g. "lua/config/keymaps.lua:1:23"
		ref = path .. ":" .. start_line .. ":" .. end_line
	end

	-- ask for an optional free-text note on the command line (Enter to skip)
	local note = vim.fn.input("Prompt (optional): ")
	if note ~= "" then
		-- append the note after the ref, separated by a space
		ref = ref .. " " .. note
	end

	-- write ref into the "+" register, which is the system clipboard
	vim.fn.setreg("+", ref)

	-- append to scratch buffer
	local buf = get_or_create_scratch()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local insert_pos = #lines
	if insert_pos > 0 and lines[insert_pos] ~= "" then
		vim.api.nvim_buf_set_lines(buf, insert_pos, insert_pos, false, { "", ref })
	else
		vim.api.nvim_buf_set_lines(buf, insert_pos, insert_pos, false, { ref })
	end

	-- clear visual selection if we were in visual mode
	if opts.visual then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	end

	-- show a confirmation message with what was copied
	vim.notify("Copied: " .. ref)
end

-- normal mode: copy just the file path
vim.keymap.set("n", "<leader>bc", function()
	copy_ref({})
end, { desc = "Copy file path" })

-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>bc", function()
	copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })

-- open the copy-ref scratch buffer 
vim.keymap.set("n", "<leader>b.", function()
	open_scratch()
end, { desc = "Open copy-ref scratch buffer" })

-- clear the copy-ref scratch buffer
vim.keymap.set("n", "<leader>bx", function()
	local buf = get_or_create_scratch()
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
	vim.notify("Cleared copy-refs buffer")
end, { desc = "Clear copy-ref scratch buffer" })

-- yank the entire copy-ref scratch buffer into the + register
vim.keymap.set("n", "<leader>by", function()
	local buf = get_or_create_scratch()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local content = table.concat(lines, "\n")
	vim.fn.setreg("+", content)
	vim.notify("Yanked copy-refs buffer (" .. #lines .. " lines)")
end, { desc = "Yank copy-ref scratch buffer" })
