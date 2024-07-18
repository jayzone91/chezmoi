return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    -- Plugins
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    -- https://github.com/nvim-telescope/telescope-node-modules.nvim
    -- https://github.com/xiyaowong/telescope-emoji.nvim
  },
  opts = {},
  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files<CR>",
      { desc = "Telescope Find Files" },
    },
    {
      "<leader>fg",
      "<cmd>Telescope live_grep<CR>",
      { desc = "Telescope Live Grep" },
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers<CR>",
      { desc = "Telescope Buffers" },
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<CR>",
      { desc = "Telescope Help Tags" },
    },
  },
}
