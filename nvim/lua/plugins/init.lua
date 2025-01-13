-- ~/.config/nvim/lua/plugins/init.lua

-- Ruta para lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clonar lazy.nvim si no está instalado
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- usar la versión estable
    lazypath,
  })
end

-- Prepend lazy.nvim al runtimepath
vim.opt.rtp:prepend(lazypath)

-- Configurar lazy.nvim
require("lazy").setup({
  -- Lista de plugins
  -- Importar especificaciones de plugins individuales
  require('plugins.catppuccin'),
  require("plugins.lualine"),
  require("plugins.nvim-tree"),
  require("plugins.nvim-treesitter"),
  require('plugins.telescope'),
  require("plugins.copilot"),
  require("plugins.lsp"),
  require("plugins.noice"), 
  -- Puedes añadir más plugins aquí siguiendo el mismo patrón
  -- Por ejemplo:
  -- require('plugins.nvim-tree'),
  -- require('plugins.lualine'),
  -- etc.
}, {
  -- Opciones de configuración de lazy.nvim
  defaults = {
    lazy = false, -- Cargar los plugins por defecto inmediatamente
  },
  install = {
    colorscheme = { "catppuccin" }, -- Establecer el esquema de colores predeterminado
  },
  checker = {
    enabled = true, -- Habilitar la comprobación automática de actualizaciones de plugins
    notify = true, -- Notificar cuando hay actualizaciones disponibles
  },
})

