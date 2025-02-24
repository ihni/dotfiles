require('settings')
require('plugins')

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "c",
      "lua",
      "python",
      "markdown",
      "bash",
      "asm"
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
  },
}
-- oil / file explorer
require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
    },
    view_options = {
        show_hidden = true,
    },
})

-- colorscheme
vim.o.background = "dark" -- or "light" for light mode
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")

-- lualine
require('lualine').setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      'filename',
      function()
        return vim.fn['nvim_treesitter#statusline'](180)
      end},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
