local M = {}

M.setup = function()
  --require("modules.utils").load_plugin("mason-null-ls", {
  require("mason-null-ls").setup({
    ensure_installed = require("base.settings").null_ls_deps,
    automatic_installation = false,
    automatic_setup = true,
    handlers = {},
  })
end

return M
