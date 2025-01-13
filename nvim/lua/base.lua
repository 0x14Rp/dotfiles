-- ~/.config/nvim/lua/base.lua

-- Asignar la tecla líder al espacio
vim.g.mapleader = ' '

-- Opciones Generales
local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  
  number = true,               -- Mostrar números de línea
  relativenumber = true,       -- Números relativos
  cursorline = true,           -- Resaltar la línea del cursor
  signcolumn = "yes",          -- Mostrar columna de signos
  
  ignorecase = true,           -- Ignorar mayúsculas en búsquedas
  smartcase = true,            -- Activar sensibilidad a mayúsculas si hay mayúsculas
  incsearch = true,            -- Búsqueda incremental
  
  expandtab = true,            -- Usar espacios en lugar de tabulaciones
  shiftwidth = 2,              -- Tamaño de indentación
  tabstop = 2,                 -- Tamaño de tabulación
  smartindent = true,          -- Indentación inteligente
  
  termguicolors = true,        -- Habilitar colores de 24 bits
  background = "dark",         -- Tema de fondo
  
  wrap = false,                -- No envolver líneas largas
  hidden = true,               -- Permitir buffers ocultos
  swapfile = false,            -- Deshabilitar swapfile
  backup = false,              -- Deshabilitar backup
  writebackup = false,         -- Deshabilitar writebackup
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Atajos de Teclado Básicos
local opts = { noremap = true, silent = true }

-- Guardar con <leader>w
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', opts)

-- Cerrar Neovim con <leader>q
vim.api.nvim_set_keymap('n', '<leader>q', ':qa<CR>', opts)

-- Navegar entre ventanas con Ctrl + h/j/k/l
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

-- Mapear '<leader>1' para salir del modo de inserción
vim.api.nvim_set_keymap('i', '<leader>1', '<ESC>', { noremap = true, silent = true })

-- Mapear '<leader>m' para mostrar un mensaje de prueba
vim.api.nvim_set_keymap('n', '<leader>m', ':echo "¡Mapeos funcionan correctamente!"<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
