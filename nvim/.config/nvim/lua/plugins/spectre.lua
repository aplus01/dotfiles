return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search Word (Spectre)" },
      { "<leader>sp", function() require("spectre").open_file_search() end, desc = "Search in Current File (Spectre)" },
    },
    opts = {
      open_cmd = "noswapfile vnew",
      mapping = {
        ["delete_line"] = {
          map = "<leader>rd",
          cmd = "<cmd>lua require('spectre.actions').delete_line_file_current()<CR>",
          desc = "delete current line",
        },
      },
    },
  },
}
