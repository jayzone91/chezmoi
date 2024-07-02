local servers = require("config.external").lspserver

return {
  "b0o/SchemaStore.nvim",
  {
    "neovim/nvim-lspconfig",
    event = { "BufEnter", "BufNewFile" },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        dependencies = {
          { "Bilal2453/luvit-meta", lazy = true },
        },
        opts = {
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            { path = "lazy.nvim", words = { "Lazyvim" } },
          },
        },
      },
      { "j-hui/fidget.nvim", opts = {} },
      {
        "ray-x/lsp_signature.nvim",
        enabled = false,
        opts = {},
        config = function(_, opts)
          require("lsp_signature").setup(opts)
        end,
      },
      {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        config = function()
          require("flutter-tools").setup({})
        end,
      },
    },
    opts = function()
      return {
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.HINT] = " ",
              [vim.diagnostic.severity.INFO] = " ",
            },
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = { "vue" },
        },
        codelens = {
          enabled = false,
        },
        document_highlight = {
          enabled = true,
        },
        capabilities = {
          formatting_options = nil,
          timeout_ms = nil,
        },
      }
    end,
    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      if vim.fn.has("nvim-0.10.0") == 0 then
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]
              :lower()
              :gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
      end

      local lspconfig = require("lspconfig")
      local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp.default_capabilities() or {},
        opts.capabilities or {}
      )

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend(
          "force",
          { capabilities = vim.deepcopy(capabilities) },
          { capabilities = capabilities },
          config
        )

        lspconfig[name].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(
            vim.lsp.get_client_by_id(args.data.client_id),
            "must have valid client"
          )

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          local has_telescope, builtin = pcall(require, "telescope.builtin")
          if has_telescope then
            vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
            vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          end

          vim.opt_local_omnifunc = "v:lua.vim.lsp.omnifunc"
          local function opts_keys(desc)
            return { buffer = 0, desc = "LSP: " .. desc }
          end
          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            opts_keys("Go to declaration")
          )
          vim.keymap.set(
            "n",
            "gT",
            vim.lsp.buf.type_definition,
            opts_keys("Go ro type Definition")
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set(
            "n",
            "ca",
            vim.lsp.buf.code_action,
            opts_keys("Code actions")
          )
          vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts_keys("Rename"))

          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                v = nil
              end
              client.server_capabilities[k] = v
            end
          end
        end,
      })
    end,
  },
}
