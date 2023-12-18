vim.g.mapleader = ';'

-- local function set_bg_light()
--     vim.cmd('set background=light')
--     local colors_name = vim.g.colors_name
--     vim.cmd('colorscheme shine')
--     vim.cmd('colorscheme ' .. colors_name)
-- end
-- 
-- local function set_bg_dark()
--     vim.cmd('set background=dark')
--     local colors_name = vim.g.colors_name
--     vim.cmd('colorscheme ron')
--     vim.cmd('colorscheme ' .. colors_name)
-- end

-- keymaps
-- vim.keymap.set('i', '<C-g>', '<esc>')
-- vim.keymap.set('i', '<C-;>', '::') -- for C++ and Rust
-- vim.keymap.set('n', '<leader>vl', set_bg_light)
-- vim.keymap.set('n', '<leader>vd', set_bg_dark)
-- vim.keymap.set('n', '<leader>', ':')
-- -- w: workspace
-- vim.keymap.set('n', '<leader>w8', ':Workspace LeftPanelToggle<cr>')
-- vim.keymap.set('n', '<leader>w9', ':Workspace RightPanelToggle<cr>')
-- vim.keymap.set('n', '<leader>w0', ':Workspace BottomPanelToggle<cr>')
-- y: telescope
-- vim.keymap.set('n', '<C-p>', function() require 'telescope.builtin'.find_files {layout_strategy='vertical',layout_config={width=0.9}} end)
-- setting preview_cutoff = 0, then preview window will be opened
vim.keymap.set('n', '<C-p>',
    function() require 'telescope.builtin'.find_files { layout_strategy = 'vertical',
            layout_config = { height = 0.9, preview_cutoff = 60, prompt_position = "bottom", width = 0.9 } }
    end)
vim.keymap.set('n', '<leader>lg', function() require 'telescope.builtin'.live_grep {} end)
vim.keymap.set('n', '<F6>',
    function() require 'telescope.builtin'.grep_string { layout_config = { height = 0.99, width = 0.99 },
            path_display = { "smart" }, fname_width = 70 }
    end)
-- vim.keymap.set('n', '<leader>c', function() require 'telescope.builtin'.lsp_references {layout_strategy='vertical',layout_config={height=0.9,preview_cutoff=0,prompt_position="bottom",width=0.9}} end)
-- vim.keymap.set('n', '<leader>c', function() require 'telescope.builtin'.lsp_references {layout_config={height=0.9,preview_cutoff=0,prompt_position="bottom",width=0.9}} end)
vim.keymap.set('n', '<F7>',
    function() require 'telescope.builtin'.lsp_references { layout_config = { height = 0.95, width = 0.99 },
            path_display = { "smart" }, fname_width = 70 }
    end)
-- function() require 'telescope.builtin'.lsp_references { path_display = { "shorten = 2" }, fname_width = 100 } end)
-- vim.keymap.set('n', '<F10>', function() require 'telescope.builtin'.git_files {} end)
vim.keymap.set('n', '<leader>tb', function() require 'telescope.builtin'.buffers {} end)
vim.keymap.set({ 'n', 'i' }, '<C-0>', function() require 'telescope.builtin'.registers {} end)
-- w: window
vim.keymap.set('n', '<leader>w1', '<c-w>o')
vim.keymap.set('n', '<leader>wx', ':x<cr>')
vim.keymap.set('n', '<leader>w2', ':sp<cr>')
vim.keymap.set('n', '<leader>w3', ':vs<cr>')
-- window resize
vim.keymap.set('n', '<m-9>', '<c-w><')
vim.keymap.set('n', '<m-0>', '<c-w>>')
vim.keymap.set('n', '<m-->', '<c-w>-')
vim.keymap.set('n', '<m-=>', '<c-w>+')
-- b: buffer
vim.keymap.set('n', '<leader>bn', ':bn<cr>')
vim.keymap.set('n', '<leader>bp', ':bp<cr>')
vim.keymap.set('n', '<leader>bd', ':Bdelete<cr>')
-- p: plugins
vim.keymap.set('n', '<leader>pi', ':PackerInstall<cr>')
vim.keymap.set('n', '<leader>pc', ':PackerClean<cr>')
-- s: search
-- vim.keymap.set('n', '<F4>', '/')
vim.keymap.set('n', '<leader>sw', '/\\<lt>\\><left><left>')
-- l/g/w: language
-- l: general
-- g: goto
-- w: workspace
-- c: inlay hints
vim.keymap.set('n', '<leader>le', ':Lspsaga show_line_diagnostics<cr>')
vim.keymap.set('n', '<leader>lE', ':Lspsaga show_cursor_diagnostics<cr>')
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>lk', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>ld', ':Lspsaga preview_definition<cr>')
vim.keymap.set('n', '<leader>lr', ':Lspsaga rename<cr>')
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
-- vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting)
vim.keymap.set('n', '<leader>lb', ':SymbolsOutline<cr>')
-- vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<cr>')
vim.keymap.set('n', '<leader>lc', ':Lspsaga lsp_finder<cr>')
-- Only jump to error
vim.keymap.set("n", "[e", function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "]e", function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
vim.keymap.set("n", "[w", function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN }) end)
vim.keymap.set("n", "]w", function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN }) end)
vim.keymap.set('n', '<F12>', ':Lspsaga code_action<cr>')
vim.keymap.set('n', '<leader>it', function() require('rust-tools.inlay_hints').toggle_inlay_hints() end)
vim.keymap.set('n', '<leader>is', function() require('rust-tools.inlay_hints').set_inlay_hints() end)
vim.keymap.set('n', '<leader>id', function() require('rust-tools.inlay_hints').diable_inlay_hints() end)
-- vim.keymap.set('n', '<f4>', ':SymbolsOutline<cr>')

vim.keymap.set('n', '<F5>', vim.lsp.buf.declaration)
-- vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration)
-- vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>p', ':Lspsaga diagnostic_jump_prev<cr>')
vim.keymap.set('n', '<leader>n', ':Lspsaga diagnostic_jump_next<cr>')
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references)

vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)

-- t: terminal
-- use <f5> to toggle terminal, this can be set in lua/configs/terminal.lua
-- the default position is also set in lua/configs/terminal.lua
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=tab<cr>')
vim.keymap.set('n', '<leader>tn', function() require('toggleterm.terminal').Terminal:new():toggle() end)
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<cr>')
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal size=10<cr>')
vim.keymap.set('n', '<leader>t', ':ToggleTerm direction=vertical size=90<cr>')

-- h: git
vim.keymap.set('n', '<leader>hu', ':Gitsigns undo_stage_hunk<cr>')
vim.keymap.set('n', '<leader>hn', ':Gitsigns next_hunk<cr>')
vim.keymap.set('n', '<leader>hc', ':Gitsigns preview_hunk<cr>')
vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<cr>')
vim.keymap.set('n', '<leader>hR', ':Gitsigns reset_buffer')
vim.keymap.set('n', '<leader>hb', ':Gitsigns blame_line<cr>')
vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<cr>')
vim.keymap.set('n', '<leader>hs', ':<C-U>Gitsigns select_hunk<CR>')

vim.keymap.set('n', '<leader>gs',
    function() require 'telescope.builtin'.git_status { layout_config = { height = 0.99, width = 0.99 },
            path_display = { "smart" }, fname_width = 80 }
    end)
vim.keymap.set('n', '<leader>gh', ':VGit buffer_history_preview<cr>')

-- session manager
vim.keymap.set('n', '<leader>sl', ':SessionManager load_session<cr>')
vim.keymap.set('n', '<leader>sd', ':SessionManager delete_session<cr>')
