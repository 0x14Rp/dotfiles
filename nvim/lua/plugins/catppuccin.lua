-- ~/.config/nvim/lua/plugins/catppuccin.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Asegura que se cargue antes que otros plugins
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- Opciones: 'latte', 'frappe', 'macchiato', 'mocha'
      background = {
        light = "latte",
        dark = "mocha",
      },
      integrations = {
        treesitter = true,
        lsp_trouble = true,
        cmp = true,
        lsp_saga = true,
        gitsigns = true,
        telescope = true,
        nvimtree = true,
        bufferline = true,
        -- Añade más integraciones según tus necesidades
      },
    })
    vim.cmd("colorscheme catppuccin")
  end,
}

