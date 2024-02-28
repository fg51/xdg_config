-- Now use `<A-k>` or `<A-1>` to back to the `dotstutor`.
local autocmd = {}

-- TODO: delete it. call from "keymap.lua"
function nvim_load_mapping_with_buf(buf, mapping)
  for key, value in pairs(mapping) do
    local modes, keymap = key:match("([^|]*)|?(.*)")
    --    if type(value) == "table" then
    for _, mode in ipairs(vim.split(modes, "")) do
      local rhs = value.cmd
      local options = value.options
      local buf = value.buffer
      if buf and type(buf) == "number" then
        vim.api.nvim_buf_set_keymap(buf, mode, keymap, rhs, options)
      else
        vim.api.nvim_set_keymap(mode, keymap, rhs, options)
      end
    end
    --    end
  end
end

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

-- defer setting LSP-related keymaps till LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
  callback = function(event)
    local keymap = require("base.keymap")
    if not _G._debugging then
      --mapping.lsp(event.buf)
      nvim_load_mapping_with_buf(event.buf, keymap.lsp)
    end
  end,
})

-- auto close some filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "nofile",
    "lspinfo",
    "terminal",
    "prompt",
    "toggleterm",
    "copilot",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
  end,
})

function autocmd.load_autocmds()
  local definitions = {
    lazy = {},
    bufs = {
      -- Reload vim config automatically
      {
        "BufWritePost",
        [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]],
      },
      -- Reload Vim script automatically if setlocal autoread
      {
        "BufWritePost,FileWritePost",
        "*.vim",
        [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
      },
      { "BufWritePre", "/tmp/*", "setlocal noundofile" },
      { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
      { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.bak", "setlocal noundofile" },
      -- auto place to last edit
      {
        "BufReadPost",
        "*",
        [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
      },
      -- Auto toggle fcitx5
      -- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
      -- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
      -- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
      -- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
    },
    wins = {
      -- Attempt to write shada when leaving nvim
      {
        "VimLeave",
        "*",
        [[if has('nvim') | wshada | else | wviminfo! | endif]],
      },
      -- Check if file changed when its window is focus, more eager than 'autoread'
      { "FocusGained", "* checktime" },
      -- Equalize window dimensions when resizing vim window
      { "VimResized", "*", [[tabdo wincmd =]] },
    },
    ft = {
      { "FileType", "alpha", "set showtabline=0" },
      { "FileType", "markdown", "set wrap" },
      { "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
      { "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
      {
        "FileType",
        "*",
        [[setlocal formatoptions-=cro]],
      },
      {
        "FileType",
        "c,cpp",
        "nnoremap <leader>h :ClangdSwitchSourceHeaderVSplit<CR>",
      },
    },
    yank = {
      {
        "TextYankPost",
        "*",
        [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]],
      },
    },
  }
  --autocmd.nvim_create_augroups(require("modules.utils").extend_config(definitions, "user.event"))
  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
