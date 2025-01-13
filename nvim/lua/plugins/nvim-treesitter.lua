-- ~/.config/nvim/lua/plugins/nvim-treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Ejecuta :TSUpdate después de instalar para actualizar los parsers
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Asegura que se instalen todos los parsers mantenidos o una lista específica
      ensure_installed = "all", -- O usa una lista como se muestra abajo

      -- highlight
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- indent
      indent = {
        enable = true,
      },

      -- incremental_selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },

      -- playground
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
      },

      -- refactor
      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
      },

      -- textobjects
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },

      -- auto_install
      auto_install = true,

      -- ignore_install
      ignore_install = { "hoon" }, -- Opcional
    })
  end,
}

