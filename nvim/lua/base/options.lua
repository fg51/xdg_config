-- local global = require("core.global")

--vim.scriptencoding = 'utf-8'

local function load_options()
  local global_local = {
    -- backupdir = global.cache_dir .. "backup/",
    -- directory = global.cache_dir .. "swap/",
    -- spellfile = global.cache_dir .. "spell/en.uft-8.add",
    -- viewdir = global.cache_dir .. "view/",
    autoindent = true, -- indent
    autoread = true, -- buffer
    --autowrite = true,
    backspace = "indent,eol,start", -- input
    backup = false,
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    breakat = [[\ \	;:,!?]],
    breakindentopt = "shift:2,min:20",
    clipboard = "unnamedplus",
    cmdheight = 1, -- 0, 1, 2  -- view
    cmdwinheight = 5,
    complete = ".,w,b,k",
    completeopt = "menuone,noselect",
    -- * menuone: display menu at one
    -- * noinsert: disable insert with displaying menu
    -- cmd("set completeopt-=preview")
    -- opt.completeopt = "menu,menuone,noselect"
    -- cmd("set completeopt-=preview")
    concealcursor = "niv",
    conceallevel = 0,
    cursorcolumn = false, -- view
    cursorline = false, --view
    diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience",
    display = "lastline",
    encoding = "utf-8",
    equalalways = false,
    -- errorbells = true,
    -- expandtab = true,  -- indent -- priority to editorconfig
    fileencoding = "utf-8",
    fileencodings = "utf-8,default,ucs-bom,euc-jp,cp932,shift-jis,latin1",
    --vim.opt.fileencodings = { 'utf-8', 'default', 'ucs-bom', 'euc-jp', 'cp932', 'shift-jis', 'latin1' }
    fileformats = "unix,mac,dos",
    foldenable = true,
    foldlevelstart = 99,
    formatoptions = "1jcroql",
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --hidden --vimgrep --smart-case --",
    helpheight = 12,
    hidden = true, -- buffer -- disable unsaved file
    history = 2000,
    ignorecase = true,
    inccommand = "nosplit",
    incsearch = true,
    infercase = true,
    jumpoptions = "stack",
    laststatus = 2, -- view
    linebreak = true,
    list = true, -- view  -- show invisible chars
    listchars = "tab:»-,nbsp:%,trail:-,extends:»,precedes:«",
    magic = true,
    mousescroll = "ver:3,hor:6",
    number = true,
    previewheight = 12,
    -- Do NOT adjust the following option (pumblend) if you're using transparent background
    pumblend = 0,
    pumheight = 15,
    redrawtime = 1500,
    relativenumber = false,
    ruler = false,
    scrolloff = 2,
    sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize",
    shada = "!,'500,<50,@100,s10,h",
    shiftround = true,
    -- shiftwidth = 2 -- indent  -- priority to editorconfig
    shortmess = "aoOTIcF",
    showbreak = "↳  ",
    showcmd = true,
    --showmode = false,
    showtabline = 2,
    sidescrolloff = 5,
    signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
    smartcase = true, -- search --  Don't ignore case with capitals
    smarttab = true, -- indent
    -- softtabstop = 2, -- indent  -- priority to editorconfig
    splitbelow = true,
    splitkeep = "screen",
    splitright = true,
    startofline = false,
    swapfile = false,
    switchbuf = "usetab,uselast",
    synmaxcol = 2500,
    -- tabstop = 2,  -- priority to editorconfig
    termguicolors = true,
    timeout = true,
    timeoutlen = 300,
    ttimeout = true,
    ttimeoutlen = 0,
    --undodir = global.cache_dir .. "undo/",
    undofile = true,
    -- Please do NOT set `updatetime` to above 500, otherwise most plugins may not function correctly
    updatetime = 200,
    viewoptions = "folds,cursor,curdir,slash,unix",
    virtualedit = "block",
    visualbell = true,
    -- whichwrap = "h,l,<,>,[,],~",
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    wildignorecase = true,

    -- Do NOT adjust the following option (winblend) if you're using transparent background
    -- winblend = 0,
    winminwidth = 10,
    winwidth = 30,
    wrap = false,
    wrapscan = true,
    writebackup = false,
  }

  local function isempty(s)
    return s == nil or s == ""
  end

  local function use_if_defined(val, fallback)
    return val ~= nil and val or fallback
  end

  ---- custom python provider
  --local conda_prefix = os.getenv("CONDA_PREFIX")
  --if not isempty(conda_prefix) then
  --  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
  --  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
  --else
  --  vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
  --  vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
  --end
  vim.g.python3_host_prog = vim.env.HOME .. "/.local/share/nvim_python3_host/.venv/bin/python3"

  --for name, value in pairs(require("modules.utils").extend_config(global_local, "user.options")) do
  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
end

load_options()

vim.g.markdown_fenced_languages = {
  "bash",
  "c",
  "cpp",
  "css",
  "fish",
  "javascript",
  "js=javascript",
  -- "jsx",
  "html",
  "python",
  "rust",
  "sh",
  -- "svelte",
  -- "tsx",
  "typescript",
  "ts=typescript",
  "zig",
}

vim.scriptencoding = "utf-8"
--markdown_fenced_languages = { "html", "python" },
