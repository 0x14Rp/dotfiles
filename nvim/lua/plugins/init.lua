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

require("lazy").setup({
 
  require('plugins.catppuccin'),
  require("plugins.lualine"),
  require("plugins.nvim-tree"),
  require("plugins.nvim-treesitter"),
  require('plugins.telescope'),
  require("plugins.lsp"),
  require("plugins.noice"), 

}, {


  defaults = {
    lazy = false, 
  },
  install = {
    colorscheme = { "catppuccin" }, 
  },
  checker = {
    enabled = true, 
    notify = true,
  },
})

