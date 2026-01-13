return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
        },
      },
      hidden = true, -- Show hidden files
      ignored = true, -- Show .gitignore files
    },
    explorer = {
      close_on_file_open = false,
    },
  },
}
