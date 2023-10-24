vim.cmd [[ inoremap <silent> jj <ESC>]]

-- insert ',' with space.
vim.api.nvim_set_keymap('i', ',', ',<Space>', { noremap = true, silent = true })
