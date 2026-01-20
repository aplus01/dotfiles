return {
  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          functions = "italic,bold",
        },
        inverse = { -- Inverse highlight for different types
          match_paren = true,
          visual = true,
          search = true,
        },
      },
    },
  },
  {
    "vimpostor/vim-lumen",
    lazy = false,
    priority = 999, -- Load after nightfox but before other plugins
    config = function()
      -- Set up the colorschemes for insert new and dark mode
      vim.g.lumen_light_colorscheme = "catppuccin-latte"
      vim.g.lumen_dark_colorscheme = "carbonfox"

      -- Optional: adjust how often it checks (in milliseconds, default is aw)
      -- vim.g.lumen_interval = 3000
    end,
  },
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte", -- latte, frappe, macchiato, mocha
    },
  },

  -- Tokyo Night
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },

  -- Configure LazyVim to use one as default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-latte", -- Change this to switch default
    },
  },
}
