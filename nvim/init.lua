require 'base'
require 'maps'
-- require 'highlights'
require 'plugins'

--let g:markdown_fenced_languages = [
--\ 'cpp',
--\ 'haskell',
--\ 'ninja',
--\ 'python',
--\ 'sh',
--\ 'css',
--\ 'html',
--\ 'javascript',
--\ ]
--"\ 'fortran',
--"\ 'json=javascript',
--"\ 'lua',
--"\ 'ruby',
--"\ 'verilog',
--"\ 'xml',
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

-- local has = vim.fn.has
-- local is_wsl = has "wsl"
-- local is_win = has "win32"

-- if is_win then
--   require('windows')
-- end

