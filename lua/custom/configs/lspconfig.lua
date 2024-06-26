dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
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

-- nvim-lspconfig config
-- List of all pre-configured LSP servers:
-- github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- local servers = { 'clangd', 'rust_analyzer', 'pylsp', 'sumneko_lua', 'sourcekit' }
local servers = { "vimls", "rust_analyzer", "pylsp", "lua_ls" }
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
    "/usr/bin/clangd",
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
    "--header-insertion=never",
    -- "--header-insertion-decorators",
    -- pch优化的位置
    "--pch-storage=memory",
    "--cross-file-rename",
    "--enable-config",
    -- "--offset-encoding=utf-16",
    -- "--rename-file-limit=0",
    -- "--log=verbose",
  },
  -- filetypes = { "c", "cpp", "objc", "objcpp" },
}
-- require'lspconfig'.sumneko_lua.setup {
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {'vim'},
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file("", true),
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }

-- require('rust-tools').setup()
