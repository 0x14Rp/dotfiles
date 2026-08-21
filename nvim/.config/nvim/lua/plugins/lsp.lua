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
          "lua_ls"
        },
      })

      -- Habilita cada servidor con la API nativa de Neovim 0.11+.
      -- nvim-lspconfig ya no expone require("lspconfig")[server].setup();
      -- ahora publica las definiciones en su carpeta lsp/ y se activan
      -- con vim.lsp.enable().
      vim.lsp.enable({
        "jdtls",         -- Java
        "gopls",         -- Go
        "rust_analyzer", -- Rust
        "ts_ls",         -- JavaScript y TypeScript
        "yamlls",        -- YAML
        "jsonls",        -- JSON
        "clangd",        -- C y C++
        "lua_ls",        -- Lua
      })
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
          { name = "luasnip"},
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

