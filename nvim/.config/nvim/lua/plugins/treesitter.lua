-- lua/plugins/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSInstallSync lua javascript typescript html css json", -- Instala parsers comunes al principio
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Habilita el resaltado de sintaxis basado en Tree-sitter
      highlight = {
        enable = true,
      },
      -- Habilita la indentación basada en Tree-sitter (opcional pero recomendado)
      indent = {
        enable = true,
      },
      -- Puedes añadir otras funcionalidades aquí si las necesitas más adelante
      -- Por ejemplo: incremental_selection, playground, etc.
    })

    -- Puedes añadir más parsers aquí si quieres que se instalen automáticamente la primera vez
    -- require("nvim-treesitter.install").update({ with_sync = true }) -- Descomentar si quieres actualizar parsers existentes
  end,
}
