return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufReadPost',
  config = function()
    require('colorizer').setup({}) -- Sin opciones dentro del setup
  end,
}
