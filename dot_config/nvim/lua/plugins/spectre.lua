return {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function() require("specter").open() end,
      desc = "Replace in Files (Spectre)",
    },
  },
}
