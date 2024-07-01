return {
  "hrsh7th/nvim-cmp",
  event = "BufEnter",
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "lukas-reineke/cmp-rg",
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = (not vim.uv.os_uname().sysname:find("Windows") ~= nil)
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    },
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp_ui = {
      icons = true,
      lspkind_text = true,
      style = "atom_colored",
    }
    local cmp_style = cmp_ui.style

    local field_arrangement = {
      atom = { "kind", "abbr", "menu" },
      atom_colored = { "kind", "abbr", "menu" },
    }

    local formatting_style = {
      fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
      format = function(_, item)
        local icons = {
          Namespace = "󰌗",
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰆧",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈚",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
          Table = "",
          Object = "󰅩",
          Tag = "",
          Array = "[]",
          Boolean = "",
          Number = "",
          Null = "󰟢",
          String = "󰉿",
          Calendar = "",
          Watch = "󰥔",
          Package = "",
          Copilot = "",
          Codeium = "",
          TabNine = "",
        }
        local icon = (icons and icons[item.kind]) or ""

        if cmp_style == "atom" or cmp_style == "atom_colored" then
          icon = " " .. icon .. " "
          item.menu = cmp_ui.lspkind_text and "  (" .. item.kind .. ")" or ""
          item.kind = icon
        else
          icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
          item.kind = string.format(
            "%s %s",
            icon,
            cmp_ui.lspkind_text and item.kind or ""
          )
        end

        return item
      end,
    }
    local function cmp_border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local lspkind = require("lspkind")
    lspkind.init()

    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      snippet = {
        -- REQUIRED
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = {
          side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored")
              and 1
            or 0,
          winhighlight = "Normal:CmpPmenu,CursorLine:Visual,Search:None",
          -- winblendwinhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          scrollbar = false,
        },
        documentation = {
          border = cmp_border("CmpDocBorder"),
          winhighlight = "Normal:CmpDoc",
        },
      },
      formatting = formatting_style,

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
          { name = "luasnip" },
          { name = "rg" },
        },
      },

      sorting = defaults.sorting,
    })
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
