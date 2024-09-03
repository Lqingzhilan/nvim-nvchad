return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "NvChad/base46",
        branch = "v2.5",
        build = function()
            require("base46").load_all_highlights()
        end,
    },

    {
        "NvChad/ui",
        branch = "v2.5",
        lazy = false,
        config = function()
            require "nvchad"
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            return { override = require "nvchad.icons.devicons" }
        end,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "devicons")
            require("nvim-web-devicons").setup(opts)
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "User FilePost",
        opts = {
            indent = { char = "│", highlight = "IblChar" },
            scope = { char = "│", highlight = "IblScopeChar" },
        },
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "blankline")

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup(opts)

            dofile(vim.g.base46_cache .. "blankline")
        end,
    },

    {
        "NvChad/nvterm",
        config = function()
            require("nvterm").setup()
        end,
    },
    -- file managing , picker etc
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require "configs.nvimtree"
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end,
    },

    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "whichkey")
            require("which-key").setup(opts)
        end,
    },

    "nvim-lua/plenary.nvim",

    -- formatting!
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
        end,
    },

    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = function()
            return require "configs.gitsigns"
        end,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },

    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
            return require "configs.mason"
        end,
        config = function(_, opts)
            require("mason").setup(opts)

            vim.api.nvim_create_user_command("MasonInstallAll", function()
                require("nvchad.mason").install_all(opts.ensure_installed)
            end, {})
        end,
    },

    {
        "williamboman/nvim-lsp-installer",
        config = function()
            require("nvim-lsp-installer").setup()
        end,
        lazy = false,
    },

    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        -- dependencies = {
        --   -- format & linting
        --   {
        --     "jose-elias-alvarez/null-ls.nvim",
        --     config = function()
        --       require "configs.null-ls"
        --     end,
        --   },
        -- },

        config = function()
            require("configs.lspconfig").defaults()
        end,
    },

    -- load luasnips + cmp related in insert mode only
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require "configs.luasnip"
                end,
            },

            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        opts = function()
            return require "configs.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Telescope",
        opts = function()
            return require "configs.telescope"
        end,
        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)

            -- load extensions
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "User FilePost",
        opts = { user_default_options = { names = false } },
        config = function(_, opts)
            require("colorizer").setup(opts)

            -- execute colorizer as soon as possible
            vim.defer_fn(function()
                require("colorizer").attach_to_buffer(0)
            end, 0)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
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
            require "configs.symbols-outline"
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
            require "configs.nvim-session-manager"
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
    {
        -- 自动格式化
        "Chiel92/vim-autoformat",
    },
    {
        -- 16进制工具
        "RaafatTurki/hex.nvim",
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
    --       require "configs.theme"
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
