local lspkind = require("lspkind")
lspkind.init()

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local defaults = require("cmp.config.default")()

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinser",
  },
  snippet = {
    -- REQUIRED
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ["<C-p>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({
            select = true,
          })
        end
      else
        fallback()
      end
    end),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    {
      { name = "path" },
      { name = "buffer" },
    },
    {
      -- { name = "luasnip" },
      { name = "rg" },
    },
  },
  sorting = defaults.sorting,
})
