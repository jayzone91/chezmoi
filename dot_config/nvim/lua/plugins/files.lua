return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = vim.fn.executable("make") == 1 and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = vim.fn.executable("make") == 1
          or vim.fn.executable("cmake") == 1,
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          wrap_results = true,
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      pcall(telescope.load_extension, "fzf")

      local builtin = require("telescope.builtin")

      local map = vim.keymap.set

      map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      map(
        "n",
        "<leader>fs",
        function()
          builtin.current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            })
          )
        end,
        { desc = "Fuzzy Search in Current Buffer" }
      )
      map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", ":Neotree reveal<CR>", { desc = "Neotree reveal" } },
    },
    opts = {
      window = {
        position = "float",
      },
    },
  },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
}
