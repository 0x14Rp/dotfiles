-- ~/.config/nvim/lua/plugins/init.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

vim.opt.rtp:prepend(lazypath)

-- Configurar lazy.nvim
  require("lazy").setup({
  require("plugins.lualine"),
  require("plugins.nvim-tree"),
  require('plugins.telescope'),
  require("plugins.lsp"),
  require("plugins.noice"), 
  require("plugins.rose-pine"),
  require("plugins.treesitter"),
  require("plugins.colorizer"),
  require("plugins.toggleterm"),

}, {
  -- Opciones de configuración de lazy.nvim
  defaults = {
    lazy = false, -- Cargar los plugins por defecto inmediatamente
  },
  install = {
  --  colorscheme = { "catppuccin" }, -- Establecer el esquema de colores predeterminado
  },
  checker = {
    enabled = true, -- Habilitar la comprobación automática de actualizaciones de plugins
    notify = true, -- Notificar cuando hay actualizaciones disponibles
  },
})

