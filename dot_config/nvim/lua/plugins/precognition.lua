-- [[
-- precognition.nvim
-- 💭👀precognition.nvim - Precognition uses virtual
-- text and gutter signs to show available motions.
-- https://github.com/tris203/precognition.nvim
-- ]]

return {
  "tris203/precognition.nvim",
  config = function()
    vim.keymap.set("n", "<leader>tp", function()
      require("precognition").toggle()
    end)
  end,
}
