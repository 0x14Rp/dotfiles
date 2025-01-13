-- ~/.config/nvim/lua/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "catppuccin/nvim" }, -- Asegura que Catppuccin se cargue antes
  config = function()
    require("lualine").setup {
      options = {
        theme = 'catppuccin', -- Usa el tema Catppuccin
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        icons_enabled = true,
        -- Puedes personalizar más opciones aquí según tus preferencias
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}

