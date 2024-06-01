-- [[
-- nvim-lightbulb
-- VSCode 💡 for neovim's built-in LSP.
-- https://github.com/kosayoda/nvim-lightbulb
-- ]]

return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
    })
  end,
}
