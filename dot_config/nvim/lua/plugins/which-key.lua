return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.register({
      e = {
        name = "Explorer",
      },
    })
  end,
}
