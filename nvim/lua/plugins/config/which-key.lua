return function()
  local icons = {
    ui = require("plugins.config.icons").get("ui"),
    misc = require("plugins.config.icons").get("misc"),
  }

  require("which-key").setup({
    -- preset = "classic", "modern", "helix"
    preset = "helix",
    delay = vim.o.timeoutlen,
    triggers = {
      { "<auto>", mode = "nixso" },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        motions = false,
        operators = false,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },

    --  icons = {
    --    breadcrumb = icons.ui.Separator,
    --    separator = icons.misc.Vbar,
    --    group = icons.misc.Add,
    --  },

    --  window = {
    win = {
      border = "none",
      --    position = "bottom",
      --    margin = { 1, 0, 1, 0 },
      --    padding = { 1, 1, 1, 1 },
      padding = { 1, 2 },
      --    winblend = 0,
      wo = { winblend = 0 },
    },
    expand = 1,
  })
end
