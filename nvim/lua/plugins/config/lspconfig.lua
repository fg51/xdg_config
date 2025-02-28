return function()
  local nvim_lsp = require("lspconfig")
  -- require("plugins.config.mason").setup()
  -- require("plugins.config.mason-lspconfig").setup()
  --require("plugins.config.mason-lspconfig").setup("lua_ls")
  require("lspconfig.ui.windows").default_options.border = "rounded"
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = diagnostics_virtual_text
        and {
          -- severity_limit = diagnostics_level,
          severity = {
            min = vim.diagnostic.severity[diagnostics_level],
          },
        }
      or false,
    -- set update_in_insert to false bacause it was enabled by lspsaga
    update_in_insert = false,
  })


  local opts = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }
  -- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
  --if vim.fn.executable("dart") == 1 then
  --	local ok, _opts = pcall(require, "user.configs.lsp-servers.dartls")
  --	if not ok then
  --		_opts = require("completion.servers.dartls")
  --	end
  --	local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
  --	nvim_lsp.dartls.setup(final_opts)
  --end

  -- vim.api.nvim_command([[LspStart]]) -- Start LSPs
  pcall(vim.cmd.LspStart) -- Start LSPs
end

