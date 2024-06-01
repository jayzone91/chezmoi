-- [[
--
-- ]]

return {
  "danymat/neogen",
  config = function()
    require("neogen").setup()

    vim.keymap.set("n", "<leader>ng", function()
      require("neogen").generate()
    end, { noremap = true, silent = true, desc = "Generate Annotations" })
  end,
  lazy = false,
  -- version = "*"
}
