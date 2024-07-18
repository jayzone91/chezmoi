return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "catppuccin",
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
