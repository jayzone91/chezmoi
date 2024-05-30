-- [[
-- todo-comments.nvim
-- ✅ Highlight, list and search todo comments in your projects
-- https://github.com/folke/todo-comments.nvim
-- ]]

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- [[
    -- plenary.nvim
    -- plenary: full; complete; entire; absolute; unqualified.
    -- All the lua functions I don't want to write twice.
    -- https://github.com/nvim-lua/plenary.nvim
    -- ]]
    "nvim-lua/plenary.nvim",
  },
  opts = {},
}
