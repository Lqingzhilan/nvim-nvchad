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

    require("lspconfig")["lua_ls"].setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        on_init = M.on_init,

        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
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
    local servers = { "vimls", "rust_analyzer", "pylsp" }
    for _, lsp in pairs(servers) do
        require("lspconfig")[lsp].setup {
            on_attach = M.on_attach,
            capabilities = M.capabilities,
            offset_encoding = "utf-8",
        }
    end

    require("lspconfig")["clangd"].setup {
        -- on_attach = M.on_attach,
        capabilities = M.capabilities,
        cmd = {
            "clangd",
            "--background-index",
            "-j=16",
            "--clang-tidy",
            -- 全局补全（会自动补充头文件）
            "--all-scopes-completion",
            -- 更详细的补全内容
            "--completion-style=detailed",
            -- 补充头文件的形式
            -- "--header-insertion=iwyu",
            "--pretty",
            -- "--header-insertion=never",
            "--header-insertion-decorators=0",
            -- pch优化的位置
            "--pch-storage=memory",
            "--cross-file-rename",
            "--enable-config",
            -- "--fallback-style=none",
            -- "--style=file:/home/Allen/.clang-format",
            -- "--offset-encoding=utf-16",
            -- "--rename-file-limit=0",
            -- "--log=verbose",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "asm", "s" }, -- 添加对汇编的支持
        handlers = {
            ['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover, { border = 'rounded' }
            ),
        },
    }
end

return M
