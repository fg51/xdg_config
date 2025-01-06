return function()
  --  require("nvim-surround").setup({})
  vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(skkeleton-enable)", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(skkeleton-enable)", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>(skkeleton-disable)", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("c", "<C-l>", "<Plug>(skkeleton-disable)", { noremap = true, silent = true })
  vim.fn["skkeleton#config"]({
    globalDictionaries = {
      "~/.local/share/skk/SKK-JISYO.L",
      "~/.local/share/skk/SKK-JISYO.lisp",
    },
    userDictionary = "~/.local/share/skk/skkeleton",
    eggLikeNewline = true,
    registerConvertResult = true,
    -- sources = { "skk_server" },
    sources = { "google_japanese_input" },
  })

  vim.fn["skkeleton#register_kanatable"]("rom", {
    jj = "escape",
    ll = "disable",
  })
end
