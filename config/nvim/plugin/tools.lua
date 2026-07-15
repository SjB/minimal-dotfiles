require('kulala').setup()

if vim.fn.executable("just") == 1 then
    vim.pack.add({ { src = 'https://github.com/al1-ce/just.nvim' } })

    require("just").setup({
        fidget_message_limit = 32, -- limit for length of fidget progress message
        open_qf_on_error = true,   -- opens quickfix when task fails
        open_qf_on_run = true,     -- opens quickfix when running `run` task (`:JustRun`)
        open_qf_on_any = false;    -- opens quickfix when running any task (overrides other open_qf options)
        autoscroll_qf = true,      -- automatically scroll quickfix window on output
        register_commands = true,  -- if set to true then commands (:Just*) will be registered
        notify = vim.notify,       -- what to use to show messages/errors
    })
end

if vim.fn.executable("mise") == 1 then
require('mise').setup({
    unset_vars = true,
    load_on_setup = true,
    force_run = true,
})
end


if vim.fn.executable("git") == 1 then
require('neogit').setup({
    -- disable_context_highlighting = true,
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
    disable_signs = true,
    integrations = { diffview = true, fz_lua = false },
    auto_refresh = false,
    console_timeout = 5000,
    auto_show_console = false,
    sections = {
        stashes = {
            folded = false,
        },
        recent = { folded = false },
    },
})
end

if vim.fn.executable("zoxide") == 1 then
    require('zincoxide').setup({
        zincoxide_cmd = "zoxide",
        complete = true,
        behaviour = "tabs",
    })
end

require('trouble').setup({
    defaults = {
        auto_close = true,
        auto_open = true,
    },
})

vim.api.nvim_create_autocmd('PackChanged', { 
    callback = function()
        local core = vim.fn.stdpath("data") .. "/site/pack/core/opt/jupynvim/core"
        vim.fn.system({
            "cargo", "build", "--release",
            "--manifest-path", core .. "/Cargo.toml",
        })
    end
})

require("overseer").setup({
    templates = { "builtin", "user" },
    component_aliases = {
        default = {
            { 'display_duration', detail_level = 2 },
            'on_output_summarize',
            'on_exit_set_status',
            'on_complete_notify',
            'on_result_diagnostics',
            {'on_result_diagnostics_quickfix', open = true, close = true},
        },
        default_vscode = {
            'default',
            'on_result_diagnostics',
            {'on_result_diagnostics_quickfix', open = true, close = true},
            'on_complete_notify',
        },
    }
})

local osys = require("cmake-tools.osys")
require("cmake-tools").setup {
    cmake_command = "cmake", -- this is used to specify cmake command path
    ctest_command = "ctest", -- this is used to specify ctest command path
    cmake_use_preset = true,
    cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
    cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
    -- support macro expansion:
    --       ${kit}
    --       ${kitGenerator}
    --       ${variant:xx}
    cmake_build_directory = function()
        if osys.iswin32 then
            return "out\\${variant:buildType}"
        end
        return "out/${variant:buildType}"
    end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
    cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
    cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
    cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
    cmake_variants_message = {
        short = { show = true }, -- whether to show short message
        long = { show = true, max_length = 40 }, -- whether to show long message
    },
    cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
    },
    cmake_executor = { -- executor to use
        name = "quickfix", -- name of the executor
        opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for executors
            quickfix = {
                show = "always", -- "always", "only_on_error"
                position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
                size = 10,
                encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
                auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
            },
            toggleterm = {
                direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
                close_on_exit = false, -- whether close the terminal when exit
                auto_scroll = true, -- whether auto scroll to the bottom
                singleton = true, -- single instance, autocloses the opened one, if present
            },
            overseer = {
                new_task_opts = {
                    strategy = {
                        "toggleterm",
                        direction = "horizontal",
                        autos_croll = true,
                        quit_on_exit = "success"
                    }
                }, -- options to pass into the `overseer.new_task` command
                on_new_task = function(task)
                    require("overseer").open(
                        { enter = false, direction = "right" }
                    )
                end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
            },
            terminal = {
                name = "Main Terminal",
                prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                split_direction = "horizontal", -- "horizontal", "vertical"
                split_size = 11,

                -- Window handling
                single_terminal_per_instance = true, -- Single viewport, multiple windows
                single_terminal_per_tab = true, -- Single viewport per tab
                keep_terminal_static_location = true, -- Static location of the viewport if avialable
                auto_resize = true, -- Resize the terminal if it already exists

                -- Running Tasks
                start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
                focus = false, -- Focus on terminal when cmake task is launched.
                do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
            }, -- terminal executor uses the values in cmake_terminal
        },
    },
    cmake_runner = { -- runner to use
        name = "terminal", -- name of the runner
        opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for runners
            quickfix = {
                show = "always", -- "always", "only_on_error"
                position = "belowright", -- "bottom", "top"
                size = 10,
                encoding = "utf-8",
                auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
            },
            toggleterm = {
                direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
                close_on_exit = false, -- whether close the terminal when exit
                auto_scroll = true, -- whether auto scroll to the bottom
                singleton = true, -- single instance, autocloses the opened one, if present
            },
            overseer = {
                new_task_opts = {
                    strategy = {
                        "toggleterm",
                        direction = "horizontal",
                        autos_croll = true,
                        quit_on_exit = "success"
                    }
                }, -- options to pass into the `overseer.new_task` command
                on_new_task = function(task)
                end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
            },
            terminal = {
                name = "Main Terminal",
                prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
                split_direction = "horizontal", -- "horizontal", "vertical"
                split_size = 11,

                -- Window handling
                single_terminal_per_instance = true, -- Single viewport, multiple windows
                single_terminal_per_tab = true, -- Single viewport per tab
                keep_terminal_static_location = true, -- Static location of the viewport if avialable
                auto_resize = true, -- Resize the terminal if it already exists

                -- Running Tasks
                start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
                focus = false, -- Focus on terminal when cmake task is launched.
                do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
            },
        },
    },
    cmake_notifications = {
        runner = { enabled = true },
        executor = { enabled = true },
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
        refresh_rate_ms = 100, -- how often to iterate icons
    },
    cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
}

vim.keymap.set({'n'}, '<leader>vn', '<cmd>Neogit kind=auto<cr>', { desc = 'Neogit' })
vim.keymap.set({'n'}, '<leader>vN', '<cmd>Neogit kind=floating<cr>', { desc = 'Neogit' })

vim.keymap.set({'n'}, '<leader>kp', '<cmd>PasteImage<cr>', { desc = "Paste image from system clipboard"  })
vim.keymap.set({'n'}, '<leader>xM', '<cmd>Lazy reload mise.nvim<cr>', { desc = "Reload mise environment"  })
vim.keymap.set({'n'}, '<leader>uu', vim.cmd.UndotreeToggle, { desc = 'Undo Tree toggle' })

vim.keymap.set('n', "<leader>cx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set('n', "<leader>cX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set('n', "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set('n', "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set('n', "<leader>cL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set('n', "<leader>cQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

vim.keymap.set('n', "<leader>uo", "<cmd>OverseerToggle<CR>", { desc = "Overseer Toggle"  })
vim.keymap.set('n', "<F5>", "<cmd>OverseerRun<CR>", { desc = "Run Overseer"  })
vim.keymap.set('n', "<F6>", "<cmd>OverseerToggle<CR>", { desc = "Overseer Toggle"  })
