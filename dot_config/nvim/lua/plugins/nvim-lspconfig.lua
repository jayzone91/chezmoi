return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },

    -- fancy LSP Loading indicator
    { "j-hui/fidget.nvim", opts = {} },

    -- Autoformatting
    "stevearc/conform.nvim",

    -- Schema information
    "b0o/SchemaStore.nvim",
  },
  opts = {
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
    inlay_hints = { enabled = true },
    codelens = { enabled = true },
    document_highlight = { enabled = true },
  },
  config = function(_, opts)
    require("neodev").setup()

    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local signs =
      { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in ipairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local lspconfig = require("lspconfig")

    vim.diagnostic.config(vim.deepcopy(opts.diagnostic))

    local servers = require("config.lsp-servers").servers
    local formatter = require("config.formatters").formatters
    local linter = require("config.linter").linter

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == "table" then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local ensure_installed = {}

    vim.list_extend(ensure_installed, servers_to_install)
    vim.list_extend(ensure_installed, formatter)
    vim.list_extend(ensure_installed, linter)

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      -- debounce_hours = 5, -- at least 5 hours between attemps to install/update
    })

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

    local disable_semantic_tokens = {
      lua = true,
    }
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = assert(
          vim.lsp.get_client_by_id(args.data.client_id),
          "must have valid client"
        )

        if client.name == "tailwindcss" then
          vim.keymap.set(
            "n",
            "<leader>tf",
            "<cmd>TailwindSort<CR>",
            { buffer = 0, desc = "Sort Tailwind Classes" }
          )
        end

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        else
          vim.lsp.inlay_hint.enable(false)
        end

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set(
          "n",
          "gd",
          vim.lsp.buf.definition,
          { buffer = 0, desc = "GoTo Definition" }
        )
        vim.keymap.set(
          "n",
          "gr",
          vim.lsp.buf.references,
          { buffer = 0, desc = "GoTo References" }
        )
        vim.keymap.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          { buffer = 0, desc = "GoTo Declaration" }
        )
        vim.keymap.set(
          "n",
          "gt",
          vim.lsp.buf.type_definition,
          { buffer = 0, desc = "GoTo Type Definition" }
        )
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<leader>cr",
          vim.lsp.buf.rename,
          { buffer = 0, desc = "Rename" }
        )
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          { buffer = 0, desc = "Code Actions" }
        )
        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end,
    })

    -- Autoformatting setup
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        markdown = { "prettierd" },
        python = { "isort", "black" },
        php = { "php-cs-fixer" },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        })
      end,
    })
  end,
}
