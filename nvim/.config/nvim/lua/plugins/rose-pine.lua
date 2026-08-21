return {
  "rose-pine/neovim",  -- Esto es importante: indica el repositorio de GitHub a clonar
  name = "rose-pine",
  priority = 1000,
  config = function()
    require('rose-pine').setup({
      variant = 'main',
      --dark_variant = 'main',
      bold_vert_split = false,
      dim_inactive_windows = false,
      disable_background = false,
      disable_italics = false,
      groups = {
        -- You can customize specific groups here
      },
      palette = {}, -- You can customize the color palette here
      highlight_groups = {
        -- You can customize specific highlight groups here
      }
    })
    vim.cmd.colorscheme "rose-pine"
  end
}
