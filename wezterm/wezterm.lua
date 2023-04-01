local wezterm = require 'wezterm'

return {
  tab_max_width = 16,
  text_background_opacity = 0.7,
  hide_tab_bar_if_only_one_tab = false,
  font_size = 14,
  font = wezterm.font('Fira code'),
  color_scheme = "Catppuccin Mocha",
  animation_fps = 1,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  window_background_opacity = 0.3,
  macos_window_background_blur = 20,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }


}
