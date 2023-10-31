vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })

---@class map_rhs
---@field cmd string
---@field options table
---@field options.noremap boolean
---@field options.silent boolean
---@field options.expr boolean
---@field options.nowait boolean
---@field options.callback function
---@field options.desc string
---@field buffer boolean|number
local rhs_options = {}

function rhs_options:new()
  local instance = {
    cmd = "",
    options = {
      noremap = false,
      silent = false,
      expr = false,
      nowait = false,
      callback = nil,
      desc = "",
    },
    buffer = false,
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

---@param cmd_string string
---@return map_rhs
function rhs_options:map_cmd(cmd_string)
  self.cmd = cmd_string
  return self
end

---@param callback fun():nil
--- Takes a callback that will be called when the key is pressed
---@return map_rhs
function rhs_options:map_callback(callback)
  self.cmd = ""
  self.options.callback = callback
  return self
end

---@return map_rhs
function rhs_options:with_silent()
  self.options.silent = true
  return self
end

---@param description_string string
---@return map_rhs
function rhs_options:with_desc(description_string)
  self.options.desc = description_string
  return self
end

---@return map_rhs
function rhs_options:with_noremap()
  self.options.noremap = true
  return self
end

local M = {
  base = {

    -- Plugin: hop
    ["nv|<leader>w"] = rhs_options:new():map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
    ["nv|<leader>j"] = rhs_options:new():map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
    ["nv|<leader>k"] = rhs_options:new():map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
    ["nv|<leader>c"] = rhs_options:new():map_cmd("<Cmd>HopChar1MW<CR>"):with_noremap():with_desc("jump: Goto one char"),
    ["nv|<leader>cc"] = rhs_options
      :new()
      :map_cmd("<Cmd>HopChar2MW<CR>")
      :with_noremap()
      :with_desc("jump: Goto two char"),
  },

  lsp = {
    -- lspsaga
    ["n|g["] = rhs_options
      :new()
      :map_cmd(":Lspsaga diagnostic_jump_prev<CR>")
      :with_silent()
      :with_desc("lsp: Prev diagnostic"),
    --      :with_buffer(buf)
    --["n|g["] = {
    --  cmd = ":Lspsaga diagnostic_jump_prev<CR>",
    --  options = { silent = true },
    --  desc = "lsp: Prev diagnostic",
    --},
    --    ["n|g]"] = map_cr("Lspsaga diagnostic_jump_next")
    --      :with_silent()
    --      :with_buffer(buf)
    --      :with_desc("lsp: Next diagnostic"),
    ["n|g]"] = rhs_options
      :new()
      :map_cmd(":Lspsaga diagnostic_jump_next<CR>")
      :with_silent()
      -- :with_buffer(buf)
      :with_desc("lsp: Next diagnostic"),

    ["n|<leader>ld"] = rhs_options
      :new()
      :map_cmd(":Lspsaga show_line_diagnostics ++unfocus<CR>")
      :with_silent()
      --:with_buffer(buf)
      :with_desc("lsp: Line diagnostic"),

    --    ["n|gs"] = map_callback(function()
    --      vim.lsp.buf.signature_help()
    --    end):with_desc("lsp: Signature help"),
    ["n|gr"] = rhs_options:new():map_cmd(":Lspsaga rename<CR>"):with_silent():with_desc("lsp: Rename in file range"),
    --:with_buffer(buf)
    --    ["n|gR"] = map_cr("Lspsaga rename ++project")
    --      :with_silent()
    --      :with_buffer(buf)
    --      :with_desc("lsp: Rename in project range"),
    ["n|K"] = rhs_options:new():map_cmd(":Lspsaga hover_doc<CR>"):with_silent():with_desc("lsp: Show doc"),
    --:with_buffer(buf)
    --    ["nv|ga"] = map_cr("Lspsaga code_action")
    --      :with_silent()
    --      :with_buffer(buf)
    --      :with_desc("lsp: Code action for cursor"),
    ["n|gd"] = rhs_options
      :new()
      :map_cmd(":Lspsaga peek_definition<CR>")
      :with_silent()
      --:with_buffer(buf)
      :with_desc("lsp: Preview definition"),
    ["n|gD"] = rhs_options
      :new()
      :map_cmd(":Lspsaga goto_definition<CR>")
      :with_silent()
      :with_desc("lsp: Goto definition"),
    --:with_buffer(buf)

    --    ["n|gh"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("lsp: Show reference"),
    --    ["n|<leader>ci"] = map_cr("Lspsaga incoming_calls")
    --      :with_silent()
    --      :with_buffer(buf)
    --      :with_desc("lsp: Show incoming calls"),
    --    ["n|<leader>co"] = map_cr("Lspsaga outgoing_calls")
    --      :with_silent()
    --      :with_buffer(buf)
    --      :with_desc("lsp: Show outgoing calls"),
    --
  },

  --  -- Plugin: diffview
  --  ["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
  --  ["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),
  --
  --  -- Plugin: vim-easy-align
  --  ["nx|gea"] = map_cr("EasyAlign"):with_desc("edit: Align with delimiter"),

  --  -- Plugin: dap
  --  ["n|<F6>"] = map_callback(function()
  --      require("dap").continue()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Run/Continue"),
  --  ["n|<F7>"] = map_callback(function()
  --      require("dap").terminate()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Stop"),
  --  ["n|<F8>"] = map_callback(function()
  --      require("dap").toggle_breakpoint()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Toggle breakpoint"),
  --  ["n|<F9>"] = map_callback(function()
  --      require("dap").step_into()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Step into"),
  --  ["n|<F10>"] = map_callback(function()
  --      require("dap").step_out()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Step out"),
  --  ["n|<F11>"] = map_callback(function()
  --      require("dap").step_over()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Step over"),
  --  ["n|<leader>db"] = map_callback(function()
  --      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Set breakpoint with condition"),
  --  ["n|<leader>dc"] = map_callback(function()
  --      require("dap").run_to_cursor()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Run to cursor"),
  --  ["n|<leader>dl"] = map_callback(function()
  --      require("dap").run_last()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Run last"),
  --  ["n|<leader>do"] = map_callback(function()
  --      require("dap").repl.open()
  --    end)
  --    :with_noremap()
  --    :with_silent()
  --    :with_desc("debug: Open REPL"),
}

function nvim_load_mapping(mapping)
  for key, value in pairs(mapping) do
    local modes, keymap = key:match("([^|]*)|?(.*)")
    --    if type(value) == "table" then
    for _, mode in ipairs(vim.split(modes, "")) do
      local rhs = value.cmd
      local options = value.options
      local buf = value.buffer
      if buf and type(buf) == "number" then
        vim.api.nvim_buf_set_keymap(buf, mode, keymap, rhs, options)
      else
        vim.api.nvim_set_keymap(mode, keymap, rhs, options)
      end
    end
    --    end
  end
end

function nvim_load_mapping_with_buf(buf, mapping)
  for key, value in pairs(mapping) do
    local modes, keymap = key:match("([^|]*)|?(.*)")
    --    if type(value) == "table" then
    for _, mode in ipairs(vim.split(modes, "")) do
      local rhs = value.cmd
      local options = value.options
      local buf = value.buffer
      if buf and type(buf) == "number" then
        vim.api.nvim_buf_set_keymap(buf, mode, keymap, rhs, options)
      else
        vim.api.nvim_set_keymap(mode, keymap, rhs, options)
      end
    end
    --    end
  end
end

nvim_load_mapping(M.base)

return M
