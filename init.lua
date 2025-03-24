vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = ";"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
    require "mappings"
end)

vim.o.updatetime = 1000

-- Put anything you want to happen only in Neovide here
if vim.g.neovide then
    -- vim.g.neovide_fullscreen = true
    -- vim.g.neovide_window_width = 1920
    -- vim.g.neovide_window_height = 1080
    vim.opt.clipboard = 'unnamedplus'
    vim.g.neovide_remember_window_size = true
    -- Helper function for transparency formatting
    local alpha = function()
        return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
    end
    -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
    vim.g.neovide_transparency = 0.95
    vim.g.transparency = 0.8
    vim.g.neovide_background_color = "#0f1117" .. alpha()
    -- vim.g.neovide_cursor_vfx_mode = "railgun"
    -- 增大字体大小
    vim.api.nvim_set_keymap('n', '<C-=>',
        ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1<CR>',
        { noremap = true, silent = true })
    -- 缩小字体大小
    vim.api.nvim_set_keymap('n', '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1<CR>',
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true })
    vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true })
    vim.api.nvim_set_keymap('v', 'p', '"+p', { noremap = true })
    vim.api.nvim_set_keymap('i', '<C-v>', '<C-R>+', { noremap = true, silent = true })
    -- 在命令模式下使用 Ctrl+V 来粘贴
    vim.api.nvim_set_keymap('c', '<C-v>', '<C-R>+', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('t', '<C-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<C-v>', '<C-\\><C-n>"+Pi', { noremap = true })
end
