-- [[
-- My Custom Neovim Config
-- see: https://github/jayzone91/chezmoi for more config files
-- ]]

-- Set Options first, to set <leader> key
require("options")
-- Set Keymaps. Plugin Keymaps are configured directly in the plugin configurations
require("keymaps")
-- Import Auto Commands
require("autocommands")
-- Import Settings for Neovide
require("neovide")

-- Check if git is present.
if vim.fn.executable("git") ~= 1 then
  print("You have to install Git on your system to use this config.")
  vim.fn.getchar()
  os.exit()
end

-- [[
-- Lazy.nvim
-- https://github.com/folke/lazy.nvim
-- 💤 A modern plugin manager for Neovim
-- ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- prepend lazy Path to the runtimepath of neovim
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Init Lazy
require("lazy").setup({
  -- Plugins
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true,
    version = false,
  },
  checker = {
    enabled = true,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disable_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
