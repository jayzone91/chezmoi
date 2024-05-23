return {
  "tris203/precognition.nvim",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>tp",
      function() require("precognition").toggle() end
    )
  end,
}
