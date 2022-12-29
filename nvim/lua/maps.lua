vim.g.mapleader = ","

vim.cmd [[ inoremap <silent> jj <ESC>]]

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
})

-- insert ',' with space.
vim.api.nvim_set_keymap('i', ',', ',<Space>', { noremap = true, silent = true })
