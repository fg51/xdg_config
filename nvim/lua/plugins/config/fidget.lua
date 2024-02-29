return function()
  require("fidget").setup({
    -- window = { blend = 0 },
    -- sources = {
    --   ["null-ls"] = { ignore = true },
    -- },
    -- fmt = {
    --   max_messages = 3,
    -- },

    progress = {
      suppress_on_insert = false,
      ignore_done_already = false,
      --ignore = { "null-ls" }, -- List of LSP servers to ignore
      display = {
        render_limit = 5,
        done_ttl = 2,
        -- done_icon = icons.ui.Accepted,
      },
    },
    notification = {
      override_vim_notify = false, -- Automatically override vim.notify() with Fidget
      window = {
        winblend = 0, -- Background color opacity in the notification window
        zindex = 75, -- Stacking priority of the notification window
      },
    },
  })
end
