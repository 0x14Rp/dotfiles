
local wezterm = require("wezterm")

local config = {}
local mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
local username = os.getenv("USER") or os.getenv("USERNAME") or "unknown"

-- Your existing configuration
config.color_scheme = "Catppuccin Mocha"
config.colors = {
  cursor_border = "#74c7ec",
  cursor_bg = "#74c7ec",
  cursor_fg = "#11111b",
}
config.font = wezterm.font_with_fallback({
  { family = "CaskaydiaCove Nerd Font" },
  { family = "FantasqueSansM Nerd Font" },
})
config.font_size = 12.0
config.initial_cols = 120
config.initial_rows = 30
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5,
}
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = true

-- Add keybindings for split-screen functionality
config.keys = {
  -- Split pane horizontally (right)
  {
    key = "u",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  -- Split pane vertically (bottom)
  {
    key = "y",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- Navigate between panes
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  -- Close the current pane
  {
    key = "x",
    mods = "LEADER",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
}

-- Your existing status bar configuration
wezterm.on("update-right-status", function(window, pane)
  local date = username .. " "
  local bat = ""
  for _, b in ipairs(wezterm.battery_info()) do
    bat = "⚡" .. string.format("%.0f%%", b.state_of_charge * 100)
  end
  window:set_right_status(wezterm.format({
    { Text = bat .. "   " },
  }))
end)

return config
