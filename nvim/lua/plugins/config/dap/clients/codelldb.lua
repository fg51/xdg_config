-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

function input_args()
  local argument_string = vim.fn.input("Program arg(s) (enter nothing to leave it null): ")
  return vim.fn.split(argument_string, " ", true)
end

function input_exec_path()
  return vim.fn.input('Path to executable (default to "a.out"): ', vim.fn.expand("%:p:h") .. "/a.out", "file")
end

return function()
  local dap = require("dap")
  --local utils = require("modules.utils.dap")
  --local is_windows = require("core.global").is_windows
  local is_windows = false

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.exepath("codelldb"), -- Find codelldb on $PATH
      args = { "--port", "${port}" },
      detached = is_windows and false or true,
    },
  }
  dap.configurations.c = {
    {
      name = "Debug",
      type = "codelldb",
      request = "launch",
      --program = utils.input_exec_path(),
      program = input_exec_path(),
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      terminal = "integrated",
    },
    {
      name = "Debug (with args)",
      type = "codelldb",
      request = "launch",
      --program = utils.input_exec_path(),
      --args = utils.input_args(),
      program = input_exec_path(),
      args = input_args(),
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      terminal = "integrated",
    },
    {
      name = "Attach to a running process",
      type = "codelldb",
      request = "attach",
      --program = utils.input_exec_path(),
      program = input_exec_path(),
      stopOnEntry = false,
      waitFor = true,
    },
  }
  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.c
end