pcall(function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
end)

local options = {
    ensure_installed = { "c", "cpp", "lua", "luadoc", "python", "vim", "vimdoc", "asm", "bash" },

    highlight = {
        enable = true,
        use_languagetree = true,
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },

    indent = { enable = true },
}

require('nvim-treesitter.parsers').get_parser_configs().yaml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-yaml",
    files = { "src/parser.c" },
    branch = "master",
    custom_entries = {
      entry = "~/.tree-sitter/bin/tree-sitter-yaml.so"
    }
  },
  filetype = "yaml"
}
return options
