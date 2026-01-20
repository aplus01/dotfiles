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
    -- Only open if no file was specified
    if vim.fn.argc() == 0 then
      require("snacks").explorer()
    -- Or open to file's directory if opening a file
    elseif vim.fn.argc() == 1 then
      local file = vim.fn.expand("%:p")
      if vim.fn.filereadable(file) == 1 then
        require("snacks").explorer({ cwd = vim.fn.expand("%:p:h") })
      end
    end
  end,
})
