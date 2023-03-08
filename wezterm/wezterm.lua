local wezterm = require 'wezterm'

return {
  tab_max_width = 16,
  text_background_opacity = 0.7,
  hide_tab_bar_if_only_one_tab = false,
  font_size = 16,
  window_background_opacity = 0.75,
  font = wezterm.font('Fira code'),
  color_scheme = "Catppuccin Mocha",
  animation_fps = 1,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  tab_bar_at_bottom = true,
}
