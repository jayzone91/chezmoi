-- [[
-- Jay´s NeoVim Config für Windows
-- Eigentlich nur an der Arbeit genutzt.
-- für MacOs Config einfach im main branch schauen!
-- ]]

-- Einmal alle NeoVim Options
require("options")
-- Keymaps
require("keymaps")
-- Autocommands
require("autocommands")

-- Lazy.nvim als Packagemanager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      import = "plugins",
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
