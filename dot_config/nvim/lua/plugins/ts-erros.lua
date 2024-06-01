return {
  "dmmulroy/ts-error-translator.nvim",
  event = "LspAttach",
  ft = {
    "typescript",
    "typescriptreact",
  },
  config = function()
    require("ts-error-translator").setup()
  end,
}
