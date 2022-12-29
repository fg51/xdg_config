local status, nightfox = pcall(require, "nightfox")
if (not status) then
  return
end

nightfox.setup({
  options = {
    transparent = true
  },
  on_attach = vim.cmd("colorscheme duskfox"),
})
