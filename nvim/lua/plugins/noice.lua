return {
  "folke/noice.nvim",
  config = function()
    require("noice").setup({
      -- Configuración general
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      -- Configuración de la barra de estado
      statusline = {
        format = "{mode} | {filename}",
      },
      -- Configuración de las notificaciones
      notifications = {
        enabled = true,
        timeout = 3000,
      },
    })
  end,
}
