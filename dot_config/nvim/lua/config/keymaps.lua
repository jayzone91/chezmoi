-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---@param key string
---@param mode string|table
---@return nil
local del = function(mode, key)
  vim.keymap.del(mode, key)
end

-- disable some keymaps from LazyVim
-- Move Lines
del("n", "<A-j>")
del("n", "<A-k>")
del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")

-- buffers
del("n", "<S-h>")
del("n", "<S-l>")
del("n", "[b")
del("n", "]b")

-- toggle options
del("n", "<leader>uf")
del("n", "<leader>uF")
del("n", "<leader>us")
del("n", "<leader>uw")
del("n", "<leader>uL")
del("n", "<leader>ul")
del("n", "<leader>uc")
del("n", "<leader>ub")

-- windows
del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>-")
del("n", "<leader>|")

-- tabs
del("n", "<leader><tab>l")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")

---@param mode string|table
---@param key string
---@param func string|function
---@param opts table?
---@return nil
local map = function(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts or {})
end

-- Increment and decrement
map("n", "+", "<c-a>")
map("n", "-", "<c-x>")

-- Duplicate Lines
map("n", "<leader><down>", "Yp", { desc = "Duplicate Line Down" })
map("n", "<leader>j", "Yp", { desc = "Duplicate Line Down" })
map("n", "<leader><up>", "YP", { desc = "Duplicate Line Up" })
map("n", "<leader>k", "YP", { desc = "Duplicate Line Up" })

-- Move Lines
map("n", "<a-down>", "<cmd>m .+1<cr>==")
map("n", "<a-j>", "<cmd>m .+1<cr>==")
map("n", "<a-up>", "<cmd>m .-2<cr>==")
map("n", "<a-k>", "<cmd>m .-2<cr>==")

-- split Window
map("n", "<leader>ss", "<cmd>vsplit<cr>", { desc = "Split Screen horizontal" })
map("n", "<leader>sv", "<cmd>split<cr>", { desc = "Split Screen vertical" })

-- Select All
map({ "i", "n" }, "<C-a>", "<esc>gg<S-v>G")
