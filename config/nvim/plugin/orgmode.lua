vim.pack.add({
    { src = 'https://github.com/SjB/orgmode', version = 'sjb-wip' }, 
    { src = 'https://github.com/chipsenkbeil/org-roam.nvim' },
    { src = 'https://github.com/akinsho/org-bullets.nvim' },
})
require('orgmode').setup({
    ui = {
        input = {
            use_vim_ui = true
        }
    },
    org_agenda_files = {'~/Documents/notes/*project*org', '~/Documents/notes/Inbox*org', '~/Documents/journals/*.org'},
    org_default_notes_file = "~/Documents/notes/Inbox.org",
    org_todo_keywords = { 'TODO(t)', 'NEXT(n)', '|', 'DONE(d)', 'DELEGATED(a)' },
    mappings = {
        capture = {
            org_capture_refile = 'R',
        }
    },
    org_capture_templates = {
        t = {
            description = "Todo item",
            template = "* TODO %?\n  SCHEDULED: %t\n  DEADLINE: %T\n", -- Template content
            headline = "Tasks",
        },
        j = {
            description = "Journal entry",
            target = "~/Documents/notes/journals/%<%Y-%m-%d>.org",
            template = "* %<%Y-%m-%d %H:%M> %?\n",
        },
    },
})

require("org-bullets").setup({
    concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
    symbols = {
        -- list symbol
        list = "•",
        -- headlines can be a list
        headlines = { "◉", "○", "✸", "✿" },
        -- or a function that receives the defaults and returns a list
        headlines = function(default_list)
            table.insert(default_list, "♥")
            return default_list
        end,
        -- or false to disable the symbol. Works for all symbols
        headlines = false,
        -- or a table of tables that provide a name
        -- and (optional) highlight group for each headline level
        headlines = {
            { "◉", "MyBulletL1" },
            { "○", "MyBulletL2" },
            { "✸", "MyBulletL3" },
            { "✿", "MyBulletL4" },
        },
        checkboxes = {
            half = { "", "@org.checkbox.halfchecked" },
            done = { "✓", "@org.keyword.done" },
            todo = { "˟", "@org.keyword.todo" },
        },
    }
})

require('org-roam').setup({
    bindings = {
        prefix = "<LocalLeader>oO",
    },
    directory = "~/Documents/notes",
    extensions = {
        dailies = {
            directory = "journals"
        },
    },
})
