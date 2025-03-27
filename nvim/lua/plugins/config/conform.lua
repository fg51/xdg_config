return function()
  require("conform").setup({
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallbak" for languages that don't,
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 300,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      c = { "clang_format" },
      cpp = { "clang_format" },
      lua = { "stylua" },
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      -- rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      sh = { "shfmt" },
      -- use the "*" filetype to run formatters on all filetypes
      -- ["*"] = { "codespell" },
    },
    formatters = {
      clang_format = {
        -- prepend_args = { "--style=file", "--fallback-style={BasedOnStyle: LLVM, IndentWidth: 2}" },
        prepend_args = { "--style=file", "--fallback-style=LLVM" },
      },
      shfmt = {
        prepend_args = { "-i", "4" },
      },
    }
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf, async = true })
    end,
  })
end
