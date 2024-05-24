require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha, auto
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = true, -- dims the background color of inactive window
    shade = "dark",
    percentage = "0.10", -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- force no italic
  no_bold = false, -- force no bold
  no_underline = false, -- force no underline
  styles = { -- handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlighting = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = false,
    treesitter = true,
    notify = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- For more plugins integrations: (https://github.com/catppuccin/nvim#integrations)
    aerial = true,
    harpoon = true,
    indent_blankline = true,
    mason = true,
    neotree = true,
    neotest = true,
    noice = true,
    which_key = true,
  },
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
