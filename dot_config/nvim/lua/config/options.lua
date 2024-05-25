-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Overrides from Default Options
vim.g.maplocalleader = " "

local opt = vim.opt
opt.autowrite = false
opt.conceallevel = 0
opt.foldlevel = 0
opt.scrolloff = 10

-- New Options
opt.shada = { "'10", "<0", "s10", "h" } -- use .shada file upon startup and exiting
opt.autoindent = true -- take indent for new line from previous line
opt.background = "dark" -- "dark" or "light", used for highlight colors
opt.backspace = "indent,eol,start" -- how backspace works at start of line
opt.copyindent = true -- make "autoindent" use existing indent structure
opt.hlsearch = true -- highlight matches with last search
opt.swapfile = false -- whether to use a swapfile for a buffer
