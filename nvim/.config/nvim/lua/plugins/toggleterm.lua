return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })
    vim.keymap.set({ "n", "t", "i" }, "<F1>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
  end,
}
