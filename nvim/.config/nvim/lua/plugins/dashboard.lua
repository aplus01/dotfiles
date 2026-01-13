return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    table.insert(opts.dashboard.preset.keys, 6, {
      icon = "󰂺",
      key = "t",
      desc = "Tutor",
      action = ":e $VIMRUNTIME/tutor/en/vim-01-beginner.tutor",
    })
  end,
}
