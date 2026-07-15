local function truncate_branch_name(branch)
    if not branch or branch == "" then
        return ""
    end

    -- Match the branch name to the specified format
    local _, _, ticket_number = string.find(branch, "skdillon/sko%-(%d+)%-")

    -- If the branch name matches the format, display sko-{ticket_number}, otherwise display the full branch name
    if ticket_number then
        return "sko-" .. ticket_number
    else
        return branch
    end
end

require("lualine").setup({
    options = {
        -- theme = "rose-pine",
        globalstatus = true,
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "█", right = "█" },
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        tabline = {
            lualine_a = {},
            lualine_b = {'branch'},
            lualine_c = {'filename'},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
    },
    sections = {
        lualine_b = {
            { "branch", icon = "", fmt = truncate_branch_name },
            "diff",
            "diagnostics",
        },
        lualine_c = {
            { 'lsp_progress' },
            {
                'buffers',
                show_filename_only = true,   -- Shows shortened relative path when set to false.
                hide_filename_extension = false,   -- Hide filename extension when set to true.
                show_modified_status = true, -- Shows indicator when the buffer is modified.
                mode = 0,
                max_length = vim.o.columns * 2 / 3,
                filetype_names = {
                    TelescopePrompt = ' ',
                },
                -- it can also be a function that returns
                -- the value of `max_length` dynamically.
                use_mode_colors = false,
                symbols = {
                    modified = ' ●',      -- Text to show when the buffer is modified
                    alternate_file = '#', -- Text to show to identify the alternate file
                    directory =  '',     -- Text to show when the buffer is a directory
                },
            },
        },
        lualine_x = {
            "windows",
            "fileformat",
            "filetype",
        },
    },
})
