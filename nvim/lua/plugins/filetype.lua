return {
  { "sirtaj/vim-openscad", ft = "scad" },                                                -- filetype
  { "ron-rs/ron.vim",      ft = "ron" },                                                 -- filetype
  { "mattn/emmet-vim",     ft = { "css", "html", "javascript", "markdown", "typescript" } }, -- filetype
  {
    "iamcco/markdown-preview.nvim",
    ft = { "md", "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_echo_preview_url = 1
    end,
  }, -- filetype
}
