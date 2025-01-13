-- ~/.config/nvim/lua/plugins/nvim-tree.lua

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" }, -- Opcional: iconos para archivos
  config = function()
    require("nvim-tree").setup({
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
          },
        },
      },
      diagnostics = {
        enable = true,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
  view = {

  },
    })
  end,
}

