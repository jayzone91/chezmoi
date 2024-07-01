return {
  "danymat/neogen",
  version = "*",
  config = function()
    require("neogen").setup({
      enabled = true,
      input_after_comment = true,
    })
    local opts =
      { noremap = true, silent = true, desc = "Generate Annotations" }
    vim.api.nvim_set_keymap(
      "n",
      "<leader>n",
      ":lua require('neogen').generate()<CR>",
      opts
    )
  end,
}
