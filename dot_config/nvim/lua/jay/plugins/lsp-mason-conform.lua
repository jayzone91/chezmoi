local servers = require("jay.config.mason").lspserver
local linter = require("jay.config.mason").linter
local formatter = require("jay.config.mason").formatter

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    { "j-hui/fidget.nvim", opts = {} },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

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

    -- Autoformatting
    "stevearc/conform.nvim",
  },
  config = function()
    local capabilities = nil
    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local lspconfig = require("lspconfig")

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == table then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    local formatters_to_install = {}
    for _, value in pairs(formatter) do
      vim.list_extend(formatters_to_install, value)
    end

    local linter_to_install = {}
    for _, value in pairs(linter) do
      vim.list_extend(linter_to_install, value)
    end

    require("mason").setup()
    local ensure_installed = {}

    vim.list_extend(ensure_installed, servers_to_install)
    vim.list_extend(ensure_installed, formatters_to_install)
    vim.list_extend(ensure_installed, linter_to_install)

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_startup = true,
      start_delay = 3000,
      -- debounce_hours = 5,
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

        local settings = servers[client.name]
        if type(settings) ~= "table" then
          settings = {}
        end

        local builtin = require("telescope.builtin")

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
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

    -- Autoformatting
    require("conform").setup({
      formatters_by_ft = formatter,
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

    require("lsp_lines").setup()
    vim.diagnostic.config({ virtual_text = false })
  end,
}
