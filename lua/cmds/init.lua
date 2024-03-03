-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local general = vim.api.nvim_create_augroup('general', { clear = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = general,
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'remove trailing spaces from files on save',
  group = general,
  callback = function ()
    vim.cmd([[ %s/\s\+$//e ]])
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'disable adding comment to new line',
  group = general,
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'update file when there are changes',
  group = general,
  callback = function()
      vim.cmd "checktime"
  end,
})
