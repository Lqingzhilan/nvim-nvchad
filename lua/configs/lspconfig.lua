local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

    map("n", "<leader>ra", function()
        require "nvchad.lsp.renamer" ()
    end, opts "NvRenamer")

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
M.on_init = function(client, _)
    if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

M.defaults = function()
    dofile(vim.g.base46_cache .. "lsp")
    require "nvchad.lsp"

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup {
        ensure_installed = {
            "lua_ls",
            "vimls",
            "rust_analyzer",
            "pylsp",
            "lemminx",
            "clangd",
            "yamlls",
        },

        handlers = {
            -- 默认 handler
            function(server_name)
                require("lspconfig")[server_name].setup {
                    on_attach = M.on_attach,
                    capabilities = M.capabilities,
                    on_init = M.on_init,
                }
            end,

            -- lua_ls 特殊配置
            ["lua_ls"] = function()
                require("lspconfig").lua_ls.setup {
                    on_attach = M.on_attach,
                    capabilities = M.capabilities,
                    on_init = M.on_init,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = {
                                    vim.fn.expand "$VIMRUNTIME/lua",
                                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                                },
                                maxPreload = 100000,
                                preloadFileSize = 10000,
                            },
                        },
                    },
                }
            end,

            -- clangd 特殊配置
            ["clangd"] = function()
                require("lspconfig").clangd.setup {
                    on_attach = M.on_attach,
                    capabilities = M.capabilities,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "-j=16",
                        "--clang-tidy",
                        "--all-scopes-completion",
                        "--completion-style=detailed",
                        "--pretty",
                        "--header-insertion-decorators=0",
                        "--pch-storage=memory",
                        "--cross-file-rename",
                        "--enable-config",
                    },
                    filetypes = { "c", "cpp", "objc", "objcpp", "asm", "s" },
                    handlers = {
                        ["textDocument/hover"] = vim.lsp.with(
                            vim.lsp.handlers.hover, { border = "rounded" }
                        ),
                    },
                }
            end,

            -- yamlls 特殊配置
            ["yamlls"] = function()
                require("lspconfig").yamlls.setup {
                    on_attach = function(client, bufnr)
                        M.on_attach(client, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format { async = false }
                            end,
                        })
                    end,
                    capabilities = M.capabilities,
                    settings = {
                        yaml = {
                            format = {
                                enable = true,
                                singleQuote = true,
                                bracketSpacing = true,
                                printWidth = 100,
                                proseWrap = "preserve",
                            },
                            validate = true,
                            schemas = {
                                kubernetes = "*.yaml",
                                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                            },
                            schemaStore = {
                                enable = true,
                                url = "https://www.schemastore.org/api/json/catalog.json",
                            },
                        },
                    },
                    filetypes = { "yaml", "yml" },
                }
            end,
        },
    }

    -- :LspInstall <server>
    vim.api.nvim_create_user_command("LspInstall", function(opts)
        local server = opts.args
        if server == "" then
            print("Usage: :LspInstall <server_name>")
            return
        end
        local registry = require("mason-registry")
        local ok, pkg = pcall(registry.get_package, server)
        if not ok then
            print("Server " .. server .. " not found in Mason registry")
            return
        end
        if not pkg:is_installed() then
            pkg:install()
            print("Installing " .. server .. " ...")
        else
            print(server .. " is already installed")
        end
    end, { nargs = 1, complete = "custom,v:lua.MasonComplete" })
end

return M
