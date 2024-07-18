local Confirm = function(opts)
  local cmp = require("cmp")
  opts = vim.tbl_extend("force", {
    select = true,
    behavior = cmp.ConfirmBehavior.Insert,
  }, opts or {})
  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end

return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  event = { "InsertEnter" },
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    {
      "L3MON4D3/LuaSnip",
      build = (not vim.uv.os_uname().sysname:find("Windows") ~= nil)
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    },
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function()
    local lspkind = require("lspkind")
    lspkind.init({})
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local auto_select = true
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert"
          .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item
        or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = Confirm({ select = auto_select }),
        ["<C-y>"] = Confirm({ select = true }),
        ["<S-CR>"] = Confirm({
          behavior = cmp.ConfirmBehavior.Replace,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
}
