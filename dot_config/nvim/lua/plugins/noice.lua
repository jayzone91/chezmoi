-- [[
-- noice.nvim
-- 💥 Highly experimental plugin that completely replaces
-- the UI for messages, cmdline and the popupmenu.
-- https://github.com/folke/noice.nvim
-- ]]

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L. %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- [[
    -- nui.nvim
    -- UI Component Library for Neovim.
    -- https://github.com/MunifTanjim/nui.nvim
    -- ]]
    "MunifTanjim/nui.nvim",
    --[[
    -- nvim-notify
    -- A fancy, configurable, notification manager for NeoVim
    -- https://github.com/rcarriga/nvim-notify
    --]]
    {
      "rcarriga/nvim-notify",
      lazy = false,
      opts = {
        stages = "static",
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      },
    },
  },
}