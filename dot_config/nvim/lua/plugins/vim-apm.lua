return {
  "jayzone91/vim-apm",
  lazy = false,
  config = function()
    local apm = require("vim-apm")
    apm:setup({})

    vim.keymap.set("n", "<leader>tt", function()
      apm:toggle_monitor()
    end, { desc = "Toggle APM" })
  end,
}
