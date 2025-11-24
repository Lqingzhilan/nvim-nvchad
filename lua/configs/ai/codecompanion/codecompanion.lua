local code = require("codecompanion")

if not code then
    return
end

code.setup({
    adapters = {
        http = {
            opts = {
                -- show_defaults 会导致copilot不能正常工作
                show_defaults = true,
                -- log_level = "DEBUG",
            },

            deepseek = function()
                return require("codecompanion.adapters").extend("deepseek", {
                    name = "deepseek",
                    env = {
                        api_key = function()
                            return os.getenv("DEEPSEEK_API_KEY")
                        end,
                    },
                    schema = {
                        model = {
                            default = "deepseek-chat",
                        },
                    },
                })
            end,

            siliconflow_r1 = function()
                return require("codecompanion.adapters").extend("deepseek", {
                    name = "siliconflow_r1",
                    url = "https://api.siliconflow.cn/v1/chat/completions",
                    env = {
                        api_key = function()
                            return os.getenv("DEEPSEEK_API_KEY_S")
                        end,
                    },
                    schema = {
                        model = {
                            default = "deepseek-ai/DeepSeek-R1",
                            choices = {
                                ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
                                "deepseek-ai/DeepSeek-V3",
                            },
                        },
                    },
                })
            end,

            siliconflow_v3 = function()
                return require("codecompanion.adapters").extend("deepseek", {
                    name = "siliconflow_v3",
                    url = "https://api.siliconflow.cn/v1/chat/completions",
                    env = {
                        api_key = function()
                            return os.getenv("DEEPSEEK_API_KEY_S")
                        end,
                    },
                    schema = {
                        model = {
                            default = "deepseek-ai/DeepSeek-V3",
                            choices = {
                                "deepseek-ai/DeepSeek-V3",
                                ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
                            },
                        },
                    },
                })
            end,

            aliyun_deepseek = function()
                return require("codecompanion.adapters").extend("deepseek", {
                    name = "aliyun_deepseek",
                    url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
                    env = {
                        api_key = function()
                            return os.getenv("DEEPSEEK_API_ALIYUN")
                        end,
                    },
                    schema = {
                        model = {
                            default = "deepseek-r1",
                            choices = {
                                ["deepseek-r1"] = { opts = { can_reason = true } },
                            },
                        },
                    },
                })
            end,

            -- 阿里千问
            aliyun_qwen = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    name = "aliyun_qwen",
                    env = {
                        url = "https://dashscope.aliyuncs.com",
                        api_key = function()
                            return os.getenv("DEEPSEEK_API_ALIYUN")
                        end,
                        chat_url = "/compatible-mode/v1/chat/completions",
                    },
                    schema = {
                        model = {
                            default = "qwen-coder-plus-latest",
                        },
                    },
                })
            end,

            copilot_claude = function()
                return require("codecompanion.adapters").extend("copilot", {
                    name = "copilot_claude",
                    schema = {
                        model = {
                            default = "claude-3.7-sonnet",
                        },
                    },
                })
            end,

            ollama_deepseek = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "ollama_deepseek",
                    schema = {
                        model = {
                            default = "deepseek-coder:6.7b",
                        },
                    },
                })
            end,

            ollama_deepseek_r1 = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "ollama_deepseek_r1",
                    schema = {
                        model = {
                            default = "deepseek-r1:latest",
                        },
                    },
                })
            end,
            ollama_gemma3 = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "ollama_gemma3",
                    schema = {
                        model = {
                            default = "gemma3:12b",
                        },
                    },
                })
            end,
        },
    },

    strategies = {
        chat = { adapter = "ollama_gemma3" },
        inline = { adapter = "ollama_gemma3" },
    },

    opts = {
        language = "Chinese",
    },

    -------------------------------------------
    prompt_library = {
        ["DeepSeek Explain"] = require("configs.ai.codecompanion.prompts.deepseek-explain"),
        ["Nextjs Agant"] = require("configs.ai.codecompanion.prompts.nextjs-agant"),
    },

    -- codeCompanion 核心配置
    code_hints = {
        enable = true,       -- 启用代码提示
        auto_trigger = true, -- 输入时自动触发
        max_items = 10,      -- 最多显示10个建议项
        language_servers = { -- 指定启用的 LSP
            "pylsp",         -- Python
            "vimls",         -- Vim
            "rust_analyzer", -- Rust
            "clangd",        -- C/C++
            "lua_ls",        -- Lua
        },
    },

    -- 启用代码提示（根据插件文档调整参数）
    code_completion = {
        enable = true,
        trigger_characters = { ".", ":", ">", '"', "'", "(", "[", "{", "@" },
        max_suggestions = 5,
    },
})

require("configs.ai.codecompanion.fidget").init()

