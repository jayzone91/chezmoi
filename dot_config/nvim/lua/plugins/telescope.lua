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
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-numbers",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },
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
    pcall(telescope.load_extension, "flutter")

    local builtin = require("telescope.builtin")

    local map = function(mode, key, func, desc)
      vim.keymap.set(mode, key, func, { desc = desc })
    end

    map("n", "<leader>ff", builtin.find_files, "Find Files")
    map("n", "<leader>fc", function()
      require("telescope").extensions.flutter.commands()
    end, "Find Flutter Commands")
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
