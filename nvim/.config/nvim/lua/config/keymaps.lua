-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Insert mode Tab (already have this)
vim.keymap.set("i", "<Tab>", function()
  local blink = require("blink.cmp")
  if blink.is_visible() then
    return blink.accept()
  else
    return "\t"
  end
end, { expr = true })

-- Cmdline mode Tab (add this)
vim.keymap.set("c", "<Tab>", function()
  if require("blink.cmp").is_visible() then
    require("blink.cmp").select_next()
    return ""
  else
    return "<C-z>"
  end
end, { expr = true })

vim.keymap.set("c", "<S-Tab>", function()
  if require("blink.cmp").is_visible() then
    require("blink.cmp").select_prev()
    return ""
  else
    return "<C-z>"
  end
end, { expr = true })
