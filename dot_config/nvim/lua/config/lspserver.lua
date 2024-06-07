-- LSP Server and config

local server = {
  bashls = true,
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      workspace = {
        checkThirdParty = false,
      },
      codeLens = {
        enabled = true,
      },
      completion = {
        callSnippet = "replace",
      },
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
  rust_analyzer = true,
  cssls = true,
  tsserver = true,
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
  emmet_ls = true,
  docker_compose_language_service = true,
  dockerls = true,
  html = {
    filetypes = {
      "html",
      "templ",
    },
  },
  intelephense = true,
  marksman = true,
  prismals = true,
  pyright = true,
  sqls = true,
  tailwindcss = {
    filetypes = {
      "html",
      "templ",
      "astro",
      "typescript",
      "javascript",
      "react",
    },
    init_options = {
      userLanguages = {
        templ = "html",
      },
    },
  },
  taplo = true,
  typos_lsp = true,
  templ = true,
}

return server
