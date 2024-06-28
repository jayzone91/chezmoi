local M = {}

M.lspserver = {
  bashls = true,
  rust_analyzer = true,
  cssls = true,
  tsserver = true,
  emmet_ls = true,
  docker_compose_language_service = true,
  dockerls = true,
  intelephense = true,
  marksman = true,
  prismals = true,
  pyright = true,
  sqls = true,
  taplo = true,
  html = true,
  yamlls = true,
  jsonls = true,
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
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      doc = {
        privateName = { "^_" },
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
  },
}

M.linter = {
  "stylelint", -- css
  "eslint", -- ts, tsx, js, jsx
  "jsonlint", -- json
  "htmlhint", -- html
  "phpcs", -- php
  "ruff", -- python
  "markdownlint", -- markdown
  "sqlfluff", -- sql,
}

M.formatter = {
  "stylua", -- lua formatter
  "prettierd", -- html, css, ts, tsx, js, jsx, scss, json, md formatter
  "php-cs-fixer", -- php formatter
  "isort", -- python import sorter
  "black", -- python formatter
  "sql-formatter", -- sql formatter
  "beautysh", -- zsh formatter
}

return M
