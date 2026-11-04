return {

  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for better prompt input,
      -- and required to use `opencode.nvim`'s embedded terminal — otherwise optional
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    config = function()
      vim.opt.autoread = true
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        view = "cmdline_popup", -- This forces it into a centered popup box
      },
    },
  },

  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {}, -- This causes the plugin setup function to be called
    event = "VeryLazy",
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  { "Exafunction/windsurf.vim", event = "VeryLazy" },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- LSP servers (matches lua/configs/lspconfig.lua)
        "html-lsp",
        "css-lsp",
        "pyright",
        "texlab",
        -- Formatters (matches lua/configs/conform.lua)
        "stylua",
        "prettier",
        "black",
        "latexindent",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- "main" is a rewrite that requires Neovim 0.12+ and drops the
    -- `ensure_installed` opts API that NvChad's config relies on.
    -- Stay on "master" until upgrading Neovim / NvChad's treesitter config.
    branch = "master",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "python",
      },
    },
  },
}
