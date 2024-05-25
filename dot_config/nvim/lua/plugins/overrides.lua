return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "float",
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree reveal<CR>", desc = "Explorer" },
  },
}
