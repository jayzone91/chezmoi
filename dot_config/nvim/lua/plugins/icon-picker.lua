-- [[
--
-- ]]

return {
  "ziontee113/icon-picker.nvim",
  lazy = false,
  config = function()
    require("icon-picker").setup({ disable_legacy_commands = true })

    vim.keymap.set(
      "n",
      "<leader>fi",
      "<cmd>IconPickerNormal<cr>",
      { noremap = true, silent = true, desc = "Find Icons" }
    )
  end,
}
