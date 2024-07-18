local servers = require("jay.config.mason").lspserver

return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufEnter", "BufNew" },
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", config = function() end },
    { "j-hui/fidget.nvim", opts = {} },
    {
      "folke/lazydev.nvim",
      dependencies = {
        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      },
      ft = "lua",
      cmd = "LazyDev",
      opts = {
        library = {
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  opts = function()
    local ret = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        codelens = {
          enabled = false,
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
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
      },
    }
    return ret
  end,
  config = function(_, opts)
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end
    local lspconfig = require("lspconfig")

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

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        local has_telescope, builtin = pcall(require, "telescope.builtin")

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        if has_telescope then
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
        end

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set(
          "n",
          "<space>ca",
          vim.lsp.buf.code_action,
          { buffer = 0 }
        )

        local filetype = vim.bo[bufnr].filetype
        if disable_semantic_tokens[filetype] then
          client.server_capabilities.semanticTokensProvider = nil
        end

        -- Override server capabilities
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end,
    })
  end,
}
