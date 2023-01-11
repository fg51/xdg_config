return {
  {
    "nvim-lualine/lualine.nvim", -- statusline
    lazy = true,
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" }, -- file icons
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "nord",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = {
            { "encoding" },
            { "fileformat", icons_enabled = false },
            { "filetype", icons_enabled = false },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive" },
      })
    end,
  },
}
