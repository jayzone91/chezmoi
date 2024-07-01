return {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    auto = true,
    filetypes = {
      "html",
      "js",
      "cjs",
      "mjs",
      "ts",
      "jsx",
      "tsx",
      "cjsx",
      "mjsx",
      "go",
    },
    mappings = {
      toggle = "gR",
    },
    narrative = {
      indendation_string = "> ", -- default '  '
    },
    debug = false,
    display = "popup", --- "popup" | "split"
  },
}
