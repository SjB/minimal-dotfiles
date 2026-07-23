vim.g.mapleader = ' '

vim.g.have_nerd_fonts = true
vim.g.autoformat = true
vim.g.editorconfig = true
vim.wo.number = true

vim.opt.background = 'dark'
vim.opt.backup = false
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.cmdheight = 1
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect', 'fuzzy', 'popup' }
vim.opt.conceallevel = 0
-- vim.opt.concealcursor = ""
vim.opt.encoding = "UTF-8"
vim.opt.lazyredraw = true
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
vim.opt.synmaxcol = 300
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.hlsearch = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.backspace = "indent,eol,start"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showmatch = true
vim.opt.showtabline = 0
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.splitkeep =  "screen"
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 250 -- default 250
vim.opt.timeoutlen = 500 -- default 1000
vim.opt.ttimeoutlen = 0 
-- vim.opt.timeout = false
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.autochdir = false
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.hidden = true
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.spelllang = { "en" }
vim.opt.selection = "inclusive"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
local scrolloff = math.floor(vim.o.lines / 2) - 3
vim.opt.scrolloff = scrolloff
vim.opt.sidescrolloff = 8
vim.opt.shell = vim.env.SHELL
vim.opt.sessionoptions = { "blank", "buffers", "curdir", "tabpages", "winsize", "winpos", "terminal", "localoptions", "help", "skiprtp", "folds" }
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")

vim.opt.winminwidth = 5
-- vim.opt.hidden = false
-- vim.opt.cindent = true
-- vim.opt.autoindent = true

if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.smoothscroll = true
end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.errorbells = false
vim.opt.belloff = "all"
vim.opt.undodir = vim.fn.stdpath('data') .. "/undodir"
vim.opt.incsearch = true
vim.opt.fillchars = { eob = " " }
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.colorcolumn = "100"

vim.diagnostic.config({
    virtual_text = { current_line = true }
})

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

vim.pack.add({
    { src = 'https://github.com/MunifTanjim/nui.nvim' },
    { src = 'https://github.com/SmiteshP/nvim-navic' },
    { src = 'https://github.com/esmuellert/codediff.nvim' },
    { src = 'https://github.com/folke/todo-comments.nvim' },
    { src = 'https://github.com/j-hui/fidget.nvim' },
    { src = 'https://github.com/norcalli/nvim-colorizer.lua' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' }, 
    { src = 'https://github.com/nvim-neotest/nvim-nio' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

