-- Don't report unsued self arguments of methods.
self = false

-- Rerun tests only if ther modification time changed.
cache = true

std = luajit
codes = true
max_comment_line_length = false

ignore = {
  "631", -- max_line_length
  "212/_.*", -- unused argument, for vars with "_" prefix
  "121", -- setting read-only global variable 'vim'
  "122", -- setting read-only field of global variable 'vim'
}

-- Global objects defined by the C code
read_globals = {
  "vim",
}

globals = {
  "vim.g",
  "vim.b",
  "vim.w",
  "vim.o",
  "vim.bo",
  "vim.wo",
  "vim.go",
  "vim.env",
}
