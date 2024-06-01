-- [[
-- dial.nvim
-- enhanced increment/decrement plugin for Neovim.
-- https://github.com/monaqa/dial.nvim
-- ]]

return {
  "monaqa/dial.nvim",
  lazy = false,
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
      },
      typescript = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.new({ elements = { "let", "const" } }),
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
      },
    })

    vim.keymap.set("n", "+", function()
      require("dial.map").manipulate("increment", "normal")
    end)
    vim.keymap.set("n", "-", function()
      require("dial.map").manipulate("decrement", "normal")
    end)
  end,
}
