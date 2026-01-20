return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "javascript",
        "typescript",
        "html",
        "scss",
        -- Add more filetypes as needed
      },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features
        css_fn = true, -- Enable all CSS *functions*
        mode = "virtualtext",
      },
    })
  end,
}
