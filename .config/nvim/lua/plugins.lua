return {
  -- カラースキーム:
  -- 現在は nvim 組み込みの `pablo` を使用（options.lua で設定）。
  -- プラグイン不要で、どのマシンでも追加インストールなしに動く。
  --
  -- 過去に試した代替候補を以下にコメントアウトで残す。上の pablo を
  -- 無効化（options.lua の colorscheme 行を外す）し、下のどれかのブロックを
  -- 有効化して使う。
  --
  -- iceberg（寒色系、ターミナル前提設計、Normal fg/bg も完備）:
  -- {
  --   "cocopon/iceberg.vim",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd.colorscheme("iceberg")
  --   end,
  -- },
  --
  -- gruvbox（暖色系・長時間コーディング向き）:
  -- {
  --   "morhetz/gruvbox",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.g.gruvbox_contrast_dark = "medium"
  --     vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },
  --
  -- Solarized Dark（古典・色彩工学的に設計された寒色）:
  -- {
  --   "altercation/vim-colors-solarized",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd.colorscheme("solarized")
  --   end,
  -- },
  --
  -- Hybrid（地味な寒色系、iceberg と Solarized の中間くらいの暗さ）:
  -- {
  --   "w0ng/vim-hybrid",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd.colorscheme("hybrid")
  --   end,
  -- },
  --
  -- Nord（nordtheme.com の美しい見た目を出すには、Terminal.app の
  --   プロファイルを Nord 公式パレットに差し替える必要あり。そのまま
  --   使うと Normal 色が設定されず背景・本文色は現プロファイル依存）:
  -- {
  --   "nordtheme/vim",
  --   name = "nord",
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd.colorscheme("nord")
  --   end,
  -- },

  -- Treesitter (modern syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- classic API; `main` branch has a different module layout
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "php",
          "python",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Mason: auto-install LSP servers, formatters, etc.
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "intelephense", -- PHP
        "pyright",      -- Python
        "ts_ls",        -- TypeScript / JavaScript
        "bashls",       -- Bash
        "vimls",        -- Vim
      },
    },
  },

  -- LSP (uses the nvim 0.11+ vim.lsp.config / vim.lsp.enable API;
  -- the older require("lspconfig") "framework" is deprecated).
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "intelephense", "pyright", "ts_ls", "bashls", "vimls" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = caps })
      end
      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = cmp.config.sources({ { name = "nvim_lsp" } }),
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
    },
  },

  -- Editing helpers
  { "numToStr/Comment.nvim",  opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "mattn/emmet-vim" },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = false, -- Nerd Font がなくても化けないように
          section_separators = "",
          component_separators = "|",
        },
      })
    end,
  },
}
