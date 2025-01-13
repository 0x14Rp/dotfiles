-- ~/.config/nvim/lua/keymaps.lua

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Atajo para buscar archivos
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)

-- Atajo para buscar texto en los archivos
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)

-- Atajo para listar buffers abiertos
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)

-- Atajo para listar tags de ayuda
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- Atajo para buscar entre recientes archivos
map('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', opts)

-- Mapas para LSP
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)       -- Ir a definición
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)      -- Ir a declaración
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)        -- Ver referencias
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)    -- Ver implementación
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)             -- Ver documentación
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)   -- Renombrar símbolo
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- Acciones de código
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)     -- Formatear documento
-- Configuración de teclas globales
vim.keymap.set("n", "<F1>", ":", { noremap = true, silent = false })

