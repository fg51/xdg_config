return function()
  require("better_escape").setup({
    --  mapping = { "jk", "jj" }, -- a table with mappings to use
    --  timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    --  clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    --  keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    --  -- example(recommended)
    --  -- keys = function()
    --  --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<Esc>l' or '<Esc>'
    --  -- end,
    k = function()
      vim.api.nvim_input("<esc>")
      local current_line = vim.api.nvim_get_current_line()
      if current_line:match("^%s+j$") then
        vim.schedule(function()
          vim.api.nvim_set_current_line("")
        end)
      end
    end,
  })
end

