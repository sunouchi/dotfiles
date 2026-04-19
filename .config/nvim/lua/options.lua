-- Netrw tree-style listing
vim.g.netrw_liststyle = 3

-- Display
vim.opt.number = true
vim.opt.laststatus = 3
-- termguicolors is intentionally left off: Apple Terminal strips 24-bit
-- color escapes, which makes modern colorschemes fall back to the default
-- profile color. Colorschemes use their 256-color definitions instead.
vim.opt.background = "dark"

-- Files / buffers
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.confirm = true

-- Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Movement
vim.opt.startofline = false

-- Bells
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Clipboard
vim.opt.clipboard = "unnamedplus"
