return {
  "github/copilot.vim", -- El plugin oficial de Copilot
  config = function()
    -- Configuración opcional para Copilot
    vim.g.copilot_no_tab_map = false-- Deshabilita <Tab> para usar otra tecla
    vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.g.copilot_assume_mapped = true
  end,
}

