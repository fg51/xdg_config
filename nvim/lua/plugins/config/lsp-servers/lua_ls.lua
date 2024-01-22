-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/lua_ls.lua

--@param names string[]
--@return string[]
local function get_plugin_paths(names)
  local plugins = require("lazy.core.config").plugins
  local paths = {}
  for _, name in ipairs(names) do
    if plugins[name] then
      table.insert(paths, vim.fs.joinpath(plugins[name].dir, "lua"))
    else
      vim.notify("Invalid plugin name: " .. name)
    end
  end
  return paths
end

--@param plugins string[]
--@return string[]
local function library(plugins)
  local paths = get_plugin_paths(plugins)
  table.insert(paths, vim.fs.joinpath(vim.fn.stdpath("config"), "lua"))
  table.insert(paths, vim.fs.joinpath(vim.env.VIMRUNTIME, "lua"))
  --table.insert(paths, "${3rd}/luv/library")
  --table.insert(paths, "${3rd}/busted/library")
  --table.insert(paths, "${3rd}/luassert/library")
  return paths
end

return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
        disable = { "different-requires" },
      },
      format = { enable = false },
      workspace = {
        -- library = {
        --   [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        --   [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        -- },
        library = library({ "lazy.nvim", "nvim-insx" }),
        checkThridParty = "Disable",
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      -- Do not override treesitter lua highlighting with lua_ls's highlighting
      semantic = { enable = false },
      telemetry = { enable = false },
    },
  },
}
