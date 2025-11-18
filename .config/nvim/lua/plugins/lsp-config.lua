return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- capabilities from cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- keymaps (unchanged)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- servers you want to configure
      local servers = { "lua_ls" }

      for _, server in ipairs(servers) do
        local cfg = {
          capabilities = capabilities,
          -- you can add server-specific 'settings' here, e.g.:
          -- settings = { Lua = { diagnostics = { globals = { "vim" } } } }
        }

        -- register/extend the server config (replaces lspconfig.SERVER.setup)
        vim.lsp.config(server, cfg)

        -- enable the server so it will attach according to filetypes/root_dir
        vim.lsp.enable(server)
      end
    end,
  },
}

