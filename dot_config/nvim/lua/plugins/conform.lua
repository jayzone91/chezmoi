return {
  "stevearc/conform.nvim",
  event = "BufEnter",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

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
  end,
}
