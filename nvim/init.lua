if not vim.g.vscode then
  require("base")

  --vim.cmd([[ inoremap <silent> jj <ESC>]])
  ---- insert ',' with space.
  --vim.api.nvim_set_keymap("i", ",", ",<Space>", { noremap = true, silent = true })

  -- -- require 'base'
  -- vim.opt.expandtab = true -- indent  -- priority to editorconfig
  -- vim.opt.shiftwidth = 2 -- indent  -- priority to editorconfig
  -- vim.opt.softtabstop = 2 -- indent --bo.softtabstop = 2  -- priority to editorconfig
  -- vim.opt.tabstop = 2 -- indent  -- priority to editorconfig

  require("config.lazy")
end
