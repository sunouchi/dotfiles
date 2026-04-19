-- Netrw tree-style listing
vim.g.netrw_liststyle = 3

-- Display
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.background = "dark"

-- Apple Terminal strips 24-bit color escapes, so termguicolors=true
-- makes modern colorschemes fall back to the profile default color.
-- Force termguicolors=false, and keep forcing it after any colorscheme
-- load (many themes re-enable it in their setup).
vim.opt.termguicolors = false
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.opt.termguicolors = false
  end,
})

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
