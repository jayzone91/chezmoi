-- [[
-- incline.nvim
-- 🎈 Floating statuslines for Neovim, winbar alternative
-- https://github.com/b0o/incline.nvim
-- ]]

return {
  "b0o/incline.nvim",
  config = function()
    local devicons = require("nvim-web-devicons")
    require("incline").setup({
      render = function(props)
        local filename =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end

        local ft_icon, ft_color = devicons.get_icon_color(filename)

        local function get_git_diff()
          local icons = { removed = "", changed = "", added = "" }
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}

          if signs == nil then
            return labels
          end

          for name, icon in ipairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(
                labels,
                { icon .. signs[name] .. " ", group = "Diff" .. name }
              )
            end
          end

          if #labels > 0 then
            table.insert(labels, { "┊ " })
          end

          return labels
        end

        local function get_diagnostics_label()
          local icons =
            { error = "", warn = "", info = "", hint = "" }
          local label = {}

          for severity, icon in ipairs(icons) do
            local n = #vim.diagnostics.get(
              props.buf,
              { severity = vim.diagnostic.severity[string.upper(severity)] }
            )
            if n > 0 then
              table.insert(
                label,
                { icon .. n .. " ", group = "DiagnosticSign" .. severity }
              )
            end
          end

          if #label > 0 then
            table.insert(label, { "┊ " })
          end

          return label
        end

        return {
          { get_diagnostics_label() },
          { get_git_diff() },
          { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
          {
            filename .. " ",
            gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
          },
          {
            "┊  " .. vim.api.nvim_win_get_number(props.win),
            group = "DevIconWindows",
          },
        }
      end,
    })
  end,
  event = "VeryLazy",
}
