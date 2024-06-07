-- [[
-- nvim-lspconfig
-- Quickstart configs for Nvim LSP
-- https://github.com/neovim/nvim-lspconfig
-- ]]

return {
  "neovim/nvim-lspconfig",
  event = "BufEnter",
  dependencies = {
    -- [[
    -- neodev.nvim
    -- 💻 Neovim setup for init.lua and plugin development
    -- with full signature help, docs and completion
    -- for the nvim lua API.
    -- https://github.com/folke/neodev.nvim
    -- Disable neoved, because its EOL sind 2.6.24
    -- ]]
    {
      "folke/neodev.nvim",
      enabled = false,
    },
    -- [[
    -- lazydev.nvim
    -- lazydev.nvim is a plugin that properly
    -- configures LuaLS for editing your Neovim
    -- config by lazily updating your workspace libraries.
    -- https://github.com/folke/lazydev.nvim
    -- ]]
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
          "luvit-meta/library",
        },
      },
      dependencies = {
        "Bilal2453/luvit-meta", -- optional "vim.uv" typings
      },
    },

    -- [[
    -- fidget.nvim
    -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
    -- https://github.com/j-hui/fidget.nvim
    -- ]]
    { "j-hui/fidget.nvim", opts = {} },
    -- [[
    -- SchemaStore
    -- 🛍 JSON schemas for Neovim
    -- https://github.com/b0o/SchemaStore.nvim
    -- ]]
    "b0o/SchemaStore.nvim",
    -- [[
    -- templ Syntax for vim
    -- https://github.com/joerdav/templ.vim
    -- ]]
    "joerdav/templ.vim",
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
    -- require("neodev").setup()

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local lspconfig = require("lspconfig")
    local servers = require("config.lspserver")
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
        {
          capabilities = capabilities,
        },
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
        if not has_telescope then
          return
        end

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
            if v == vim.NIL then
              v = nil
            end
            client.server_capabilities[k] = v
          end
        end
        vim.filetype.add({ extension = { templ = "templ" } })
      end,
    })
  end,
}
