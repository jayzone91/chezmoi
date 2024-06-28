local servers = {
  gopls = true,
  html = {
    filetypes = {
      "html",
      "templ",
      "nunjuks",
    },
  },
  tsserver = true,
  intelephense = true,
  lua_ls = {
    settings = {
      workspace = {
        checkThirdParty = false,
      },
      codeLens = { enabled = true },
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        -- diagnostics = { globals = { 'vim' } },
      },
      completion = { callSnippet = "replace" },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
}
local linter = {
  "luacheck",
  "eslint",
  "jsonlint",
  "phpcs",
  "stylelint",
  "htmlhint",
}
local formatter = {
  "stylua",
  "prettier",
  "php-cs-fixer",
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatic install of LSPs, Linters and Formatters
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Autocomplete
    {
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
    },
    -- Formatting
    {
      "stevearc/conform.nvim",
      event = "BufEnter",
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
        },
      },
    },
    -- Linting
    {
      "mfussenegger/nvim-lint",
      event = { "BufEnter", "InsertLeave" },
    },
    -- Others
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files.
      opts = {
        library = {
          -- Library items can be absolute paths
          -- "~/projects/my-awesome-lib",
          -- Or relative, which means they will be
          -- resolved as a plugin
          -- "LazyVim",
          -- When relative, you can also provide a
          -- path to the library in the plugin dir
          {
            path = "luvit-meta/library",
            words = { "vim%.uv" },
          },
          "lazy.nvim",
        },
      },
      dependencies = {
        "Bilal2453/luvit-meta", -- optional "vim.uv" typings
      },
    },
    { "j-hui/fidget.nvim", opts = {} },
    "b0o/SchemaStore.nvim",
  },
  opts = function()
    return {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
      },
      document_highlight = {
        enabled = true,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
    }
  end,
  config = function(_, opts)
    -- Setup Mason
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    require("mason-lspconfig").setup()
    -- Setup Mason Tool Installer
    local servers_to_install = vim.tbl_filter(
      function(key) return servers[key] end,
      vim.tbl_keys(servers)
    )

    local ensure_installed = {}

    vim.list_extend(ensure_installed, servers_to_install)
    vim.list_extend(ensure_installed, linter)
    vim.list_extend(ensure_installed, formatter)
    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_startup = true,
      start_delay = 3000,
      integrations = {
        ["mason-lspconfig"] = true,
      },
    })

    -- CMP Setup
    local lspkind = require("lspkind")
    lspkind.init()
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp_conf = require("cmp")
    local defaults = require("cmp.config.default")()

    cmp_conf.setup({
      completion = {
        completeopt = "menu,menuone,noinser",
      },
      snippet = {
        -- REQUIRED
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      window = {
        completion = cmp_conf.config.window.bordered(),
        documentation = cmp_conf.config.window.bordered(),
      },
      mapping = cmp_conf.mapping.preset.insert({
        ["<C-n>"] = cmp_conf.mapping.select_next_item({
          behavior = cmp_conf.SelectBehavior.Insert,
        }),
        ["<C-p>"] = cmp_conf.mapping.select_prev_item({
          behavior = cmp_conf.SelectBehavior.Insert,
        }),
        ["<C-b>"] = cmp_conf.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp_conf.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp_conf.mapping.complete(),
        ["<C-e>"] = cmp_conf.mapping.abort(),
        ["<CR>"] = cmp_conf.mapping(function(fallback)
          if cmp_conf.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp_conf.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),
        ["<Tab>"] = cmp_conf.mapping(function(fallback)
          if cmp_conf.visible() then
            cmp_conf.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp_conf.mapping(function(fallback)
          if cmp_conf.visible() then
            cmp_conf.select_prev_item()
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

    local lspconfig = require("lspconfig")
    -- Setup Capabilities
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp.default_capabilities() or {},
      opts.capabilities or {}
    )

    for name, config in pairs(servers) do
      if config == true then config = {} end
      config = vim.tbl_deep_extend(
        "force",
        { capabilities = vim.deepcopy(capabilities) },
        { capabilities = capabilities },
        config
      )

      lspconfig[name].setup(config)
    end

    -- Lsp Attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(
          vim.lsp.get_client_by_id(args.data.client_id),
          "must have valid client"
        )

        local settings = servers[client.name]
        if type(settings) ~= "table" then settings = {} end

        local has_telescope, telescope = pcall(require, "telescope.builtins")
        if not has_telescope then return end

        vim.opt_local_omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set("n", "rn", vim.lsp.buf.rename, { buffer = 0 })

        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then v = nil end
            client.server_capabilities[k] = v
          end
        end
        vim.filetype.add({ extension = { templ = "templ" } })
      end,
    })

    -- Formatter Config
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettier" },
        css = { "prettier" },
        nunjucks = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        php = { "php-cs-fixer" },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
          async = false,
        })
      end,
    })

    -- Linter Config
    require("lint").linters_by_ft = {
      lua = { "luacheck" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      html = { "htmlhint" },
      php = { "phpcs" },
      css = { "stylelint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function() require("lint").try_lint() end,
    })
  end,
}
