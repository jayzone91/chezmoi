return {
  "nvim-pack/nvim-spectre",
  enabled = not vim.uv.os_uname().sysname:find("Windows") ~= nil,
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Replace in Files (Spectre)",
    },
  },
}
