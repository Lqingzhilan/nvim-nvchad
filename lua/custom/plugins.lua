local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    config = function()
      require "custom.configs.treesitter"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    -- config = function()
    --     -- require "plugins.configs.nvimtree"
    --     require "custom.configs.nvim-tree"
    -- end,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    -- event = "InsertEnter",
    -- cmd = { "Lspsaga" },
    branch = "main",
    config = function()
      require("lspsaga").setup()
    end,
    lazy = false,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require "custom.configs.symbols-outline"
    end,

    lazy = false,
  },
  {
    "windwp/nvim-spectre",
    lazy = false,
  },

  {
    -- 文件自动保存
    "Pocco81/AutoSave.nvim",
    lazy = false,
  },
  {
    "djoshea/vim-autoread",
    lazy = false,
  },
  {
    -- 加载之前打开过的工程
    "Shatur/neovim-session-manager",
    cmd = { "SessionManager" },
    config = function()
      require "custom.configs.nvim-session-manager"
    end,
    lazy = false,
  },
  {
    -- 关键词高亮
    "dwrdx/mywords.nvim",
    lazy = false,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    -- opts = {},
    lazy = false,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local utils = require "core.utils"
      require("gitsigns").setup {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "│" },
        },
        on_attach = function(bufnr)
          utils.load_mappings("gitsigns", { buffer = bufnr })
        end,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 100,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
      }
    end,
  },

  {
    -- 函数参数提示
    "ray-x/lsp_signature.nvim",
    -- event = "VeryLazy",
    -- opts = {},
    -- config = function(_, opts)
    config = function()
      -- require("lsp_signature").setup(opts)
      require("lsp_signature").setup()
    end,
    lazy = false,
  },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  -- {
  --     "simrat39/rust-tools.nvim",
  --     lazy = false,
  -- },
  -- {
  --     "sainnhe/edge",
  --     config = function()
  --       require "custom.configs.theme"
  --     end,
  --     lazy = false,
  -- },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
