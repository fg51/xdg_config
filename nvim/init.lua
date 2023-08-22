vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = { 'utf-8', 'default', 'ucs-bom', 'euc-jp', 'cp932', 'shift-jis', 'latin1' }

-- require 'impatient'

vim.g.mapleader = " "

-- require 'base'
vim.opt.expandtab = true -- indent  -- priority to editorconfig
vim.opt.shiftwidth = 2 -- indent  -- priority to editorconfig
vim.opt.softtabstop = 2 -- indent --bo.softtabstop = 2  -- priority to editorconfig
vim.opt.tabstop = 2 -- indent  -- priority to editorconfig
-- require 'maps'
-- require 'highlights'
-- require 'plugins'
-- require 'plugins-packer'
require 'config.lazy'

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require 'base'
    require 'maps'

    vim.cmd [[ let g:markdown_fenced_languages = [
      \ 'cpp',
      \ 'haskell',
      \ 'ninja',
      \ 'python',
      \ 'sh',
      \ 'css',
      \ 'html',
      \ 'javascript',
      \ ]
    ]]

  end,
})


-- local has = vim.fn.has
-- local is_wsl = has "wsl"
-- local is_win = has "win32"

-- if is_win then
--   require('windows')
-- end
