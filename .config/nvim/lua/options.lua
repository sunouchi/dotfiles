-- Netrw tree-style listing
vim.g.netrw_liststyle = 3

-- Display
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.termguicolors = true  -- required for tokyonight and other modern colorschemes to render their full palette
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
