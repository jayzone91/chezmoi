-- [[
-- vim-illuminate
-- illuminate.vim - (Neo)Vim plugin for automatically
-- highlighting other uses of the word under the cursor
-- using either LSP, Tree-sitter, or regex matching.
-- https://github.com/RRethy/vim-illuminate
-- ]]

return {
  "RRethy/vim-illuminate",
  event = "BufEnter",
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
