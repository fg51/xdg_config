local wezterm = require 'wezterm'

-- local wsl_domains = wezterm.default_wsl_domains()

-- wezterm.on("SplitVerticalCurrentWorkingDirectory", function(window, pane)
--   local current_directory = pane:get_current_working_dir():gsub("file://", "")
--   window:perform_action(wezterm.action{SplitVertical={
--     domain="CurrentPaneDomain",
--     --args={ default_prog, "--cd", current_directory, "--exec", "fish" }
--   }}, pane)
-- end)

return {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = 'nordfox',
  -- default_prog = { "wsl.exe", "--distribution", "arch", "--exec", "/bin/bash", "-l"},
  disable_default_key_bindings = false,
  font = wezterm.font {
    family = 'Sarasa Mono J',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
  font_size = 11,
  -- leader = { key="t", mods="CTRL", timeout_milliseconds = 2000 },
  -- launch_menu = {
  --   {
  --     label = 'cmd',
  --     args = { 'cmd.exe' },
  --   },
  -- },
  hide_tab_bar_if_only_one_tab = true,
  --keys = {
  --   {
  --     -- send "CTRL-T" to the terminal when pressing CTRL-t, CTRL-t
  --     key = 't',
  --     mods = 'LEADER|CTRL',
  --     action = wezterm.action.SendString '\x14',
  --   },
  --   {
  --     key = 'k',
  --     mods = 'LEADER',
  --     action = wezterm.action.ActivatePaneDirection 'Up',
  --   },
  --   {
  --     key = 'j',
  --     mods = 'LEADER',
  --     action = wezterm.action.ActivatePaneDirection 'Down',
  --   },
  --   {
  --     key = 'h',
  --     mods = 'LEADER',
  --     action = wezterm.action.ActivatePaneDirection 'Left',
  --   },
  --   {
  --     key = 'l',
  --     mods = 'LEADER',
  --     action = wezterm.action.ActivatePaneDirection 'Right',
  --   },
  --   {
  --     key = 'n',
  --     mods = 'LEADER',
  --     action = wezterm.action.ActivateTabRelative(1),
  --   },
  --   {
  --     key = 'n',
  --     mods = 'LEADER|SHIFT',
  --     action = wezterm.action.ShowTabNavigator,
  --   },
  --   {
  --     key = 'c',
  --     mods = 'LEADER',
  --     action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  --   },
  --   {
  --     key = '|',
  --     mods = 'LEADER|SHIFT',
  --     action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain' },
  --   },
  --   {
  --     key = '-',
  --     mods = 'LEADER',
  --     action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain' },
  --   },
  --  {
  --    key = '-',
  --    mods = 'LEADER',
  --    action = wezterm.action {EmitEvent='SplitVerticalCurrentWorkingDirectory' },
  --  },
  -- },
  tab_bar_at_bottom = false,
  window_background_opacity = 0.8,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
