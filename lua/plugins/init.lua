return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },
    {
        "nvim-tree/nvim-web-devicons",
        -- opts = function()
        --     return { override = require "nvchad.icons.devicons" }
        -- end,
        config = function(_, opts) dofile(vim.g.base46_cache .. "devicons")
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
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        cmd = "WhichKey",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    -- {
    --     "nvim-lua/plenary.nvim",
    -- },
    -- formatting!
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                yaml = { "yamlfmt" }  -- 使用 yamlfmt 格式化
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
        end,
    },

    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        -- event = "User FilePost",
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

            -- vim.api.nvim_create_user_command("MasonInstallAll", function()
            --     require("nvchad.mason").install_all(opts.ensure_installed)
            -- end, {})
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
                "nvim-lua/plenary.nvim",
		"tzachar/cmp-ai",
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require "configs.luasnip"
                end,
            },

            -- autopairing of (){}[] etc
            -- {
            --     "windwp/nvim-autopairs",
            --     opts = {
            --         fast_wrap = {},
            --         disable_filetype = { "TelescopePrompt", "vim" },
            --     },
            --     config = function(_, opts)
            --         require("nvim-autopairs").setup(opts)
            --
            --         -- setup cmp for autopairs
            --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            --         require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
            --     end,
            -- },

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
        branch = "main",
        config = function()
            -- require("lspsaga").setup()
            require "configs.lspsaga"
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
        config = function()
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
    {
        -- 高亮当前变量
        'RRethy/vim-illuminate',
        lazy = false,
    },
    {
        'ldelossa/litee.nvim',
        event = "VeryLazy",
        opts = {
            notify = { enabled = false },
            panel = {
                orientation = "bottom",
                panel_size = 10,
            },
        },
        config = function(_, opts) require('litee.lib').setup(opts) end
    },

    {
        'ldelossa/litee-calltree.nvim',
        dependencies = 'ldelossa/litee.nvim',
        event = "VeryLazy",
        opts = {
            on_open = "panel",
            map_resize_keys = false,
        },
        config = function(_, opts) require('litee.calltree').setup(opts) end
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
    },
    {
        -- 显示git diff差异
        "sindrets/diffview.nvim",
        lazy = false,
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    -- {
    --     "Dan7h3x/chatter.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         "ibhagwan/fzf-lua",
    --     },
    --     keys = { {
    --         "<leader>cs", "<Cmd>ChatterStart<CR>", desc = "Chatter Start"
    --     }, },
    --     config = function()
    --         require('chatter').setup({
    --             offline_api_url = os.getenv("OLLAMA_HOST") or "http://localhost:11434",
    --             sidebar_width = 60,
    --             sidebar_height = vim.o.lines - 12,
    --             models = {},
    --             highlight = {
    --                 title = "Title",
    --                 user = "Comment",
    --                 assistant = "String",
    --                 system = "Type",
    --                 error = "ErrorMsg",
    --                 loading = "WarningMsg",
    --             }
    --         })
    --     end,
    -- },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("configs.ai.codecompanion.codecompanion")
        end,
        lazy = false,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
    },
    -- fidget.nvim
    {
        "j-hui/fidget.nvim",
        -- tag = "legacy",
        config = function()
            require("fidget").setup()
        end,
    },
-- Custom configuration (defaults shown)
    {
      'jacob411/Ollama-Copilot',
      opts = {
        -- model_name = "gemma3:12b",
        model_name = "gemma3:latest",
        ollama_url = "http://localhost:11434", -- URL for Ollama server, Leave blank to use default local instance.
        stream_suggestion = false,
        python_command = "python3",
        filetypes = {'c', 'cpp', 'asm', 's', 'python', 'lua','vim', "markdown"},
        -- filetypes = {'python', 'lua','vim', "markdown"},
        ollama_model_opts = {
            num_predict = 40,
           temperature = 0.1,
        },
        keymaps = {
            suggestion = '<leader>a',
            reject = '<leader>q',
            insert_accept = '<Tab>',
        },
      },

      --lazy = false,
    },
    {
        'dhruvasagar/vim-table-mode',
        lazy = false,
    },
    {
	    'tzachar/cmp-ai',
	    config = function()
            local cmp_ai = require('cmp_ai.config')
            cmp_ai:setup({
              max_lines = 100,
              provider = 'Ollama',
              provider_options = {
                model = 'deepseek-coder:6.7b',
                -- model = 'starcoder2:7b',
                -- model = 'dagbs/qwen2.5-coder-7b-instruct-abliterated:latest',
                auto_unload = false, -- Set to true to automatically unload the model when
                                    -- exiting nvim.
              },
              notify = true,
              notify_callback = function(msg)
                vim.notify(msg)
              end,
              run_on_every_keystroke = true,
              ignored_file_types = {
                -- default is not to ignore
                -- uncomment to ignore in lua:
                -- lua = true
              },
            })
	    end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
                ensure_installed = { "lua_ls", "vimls", "rust_analyzer", "pylsp", "lemminx", "clangd", "pylsp", "yamlls" },
        },
        dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
        },
    }
}
