-- [[
-- telescope.nvim
-- Find, Filter, Preview, Pick. All lua, all the time.
-- https://github.com/nvim-telescope/telescope.nvim
-- ]]

return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  branch = "0.1.x",
  dependencies = {
    -- [[
    -- plenary.nvim
    -- plenary: full; complete; entire; absolute; unqualified.
    -- All the lua functions I don't want to write twice.
    -- https://github.com/nvim-lua/plenary.nvim
    -- ]]
    "nvim-lua/plenary.nvim",

    -- Plugins

    -- [[
    -- telescope-fzf-native.nvim
    -- FZF sorter for telescope written in c
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    -- ]]
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
          override_generic__sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    pcall(telescope.load_extension, "fzf")

    local builtin = require("telescope.builtin")

    local map = function(mode, key, func, desc)
      vim.keymap.set(mode, key, func, { desc = desc })
    end

    map("n", "<leader>ff", builtin.find_files, "Find Files")
    map("n", "<leader><space>", builtin.buffers, "Search open Buffers")
    map("n", "<leader>fr", builtin.oldfiles, "Find recent Files")
    map("n", "<leader>fk", builtin.keymaps, "Find Keymaps")
    map("n", "<leader>fo", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, "Search in open Files")
    map("n", "<leader>ft", ":TodoTelescope<CR>", "Show Todos")
    map("n", "<leader>xt", ":TodoTrouble<CR>", "Open Todos in Trouble")
    map("n", "<leader>fs", function()
      builtin.current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })
      )
    end, "Fuzzy Search in Current Buffer")
    map("n", "<leader>fg", builtin.live_grep, "Live Grep")
  end,
}
