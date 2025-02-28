return function()
  require("nvim-ts-autotag").setup({
    filetypes = {
      "html",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "xml",
    },
    opts = {
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
  })
end

