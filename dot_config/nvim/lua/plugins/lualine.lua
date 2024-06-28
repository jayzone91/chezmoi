return {
  "nvim-lualine/lualine.nvim",
  opts = {
    theme = "rose-pine",
    options = {
      icons_enabled = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
        },
      },
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
      },
      lualine_c = { "filename" },
      lualine_x = {
        "encoding",
        "fileformat",
        "filetype",
      },
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
