return {
  -- Mason para gestionar servidores LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Integración de Mason con LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",        -- Java
          "gopls",        -- Go
          "rust_analyzer",-- Rust
          "ts_ls",     -- JavaScript y TypeScript
          "yamlls",       -- YAML
          "jsonls",       -- JSON
          "clangd",       -- C y C++
        },
      })

      -- Configuración básica para cada servidor
      local lspconfig = require("lspconfig")
      local servers = { "jdtls", "gopls", "rust_analyzer", "ts_ls", "yamlls", "jsonls", "clangd" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end
    end,
  },

  -- nvim-cmp para autocompletado
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
       "hrsh7th/nvim-cmp" , -- Required
      "hrsh7th/cmp-buffer",     -- Fuente de buffers para cmp
      "hrsh7th/cmp-nvim-lsp",   -- Fuente de LSP para cmp
      "hrsh7th/cmp-cmdline",    -- Autocompletado para la línea de comandos
      "hrsh7th/cmp-path" ,
    },
    config = function()
      
      vim.g.cmp_cmdline_enabled = true
      local cmp = require("cmp")
      -- Configuración general de cmp
      cmp.setup({
        mapping = {
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = "nvim_lsp" },
        },
      })

      -- Configuración para autocompletado en la línea de comandos
      
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
    end,
  },
}

