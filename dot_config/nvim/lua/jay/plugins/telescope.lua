return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    -- Plugins
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- https://github.com/nvim-telescope/telescope-node-modules.nvim
    "nvim-telescope/telescope-node-modules.nvim",
    -- https://github.com/xiyaowong/telescope-emoji.nvim
    "xiyaowong/telescope-emoji.nvim",
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
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
  config = function(_, opts)
    require("telescope").setup(opts)
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "node_modules")
    pcall(require("telescope").load_extension, "emoji")

    vim.keymap.set(
      "n",
      "<leader>fn",
      "<cmd>Telescope node_modules list<CR>",
      { desc = "Search Node Modules" }
    )
    vim.keymap.set(
      "n",
      "<leader>fe",
      "<cmd>Telescope emoji<CR>",
      { desc = "Search Emoji" }
    )
  end,
}
