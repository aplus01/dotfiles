-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if vim.fn.argc() == 0 then
      -- No args: open explorer in cwd
      require("snacks").explorer()
    elseif vim.fn.argc() == 1 and vim.fn.isdirectory(arg) == 1 then
      -- Directory specified: open explorer there
      require("snacks").explorer({ cwd = vim.fn.fnamemodify(arg, ":p") })
    end
    -- File specified: do nothing
  end,
})
