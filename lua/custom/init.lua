require "custom.basic"
-- require "custom.keymaps"
local g = vim.g
local config = require("core.utils").load_config()

g.mapleader = ";"

-------------------------------------- globals -----------------------------------------
g.nvchad_theme = config.ui.theme
g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
g.toggle_theme_icon = "   "
g.transparency = config.ui.transparency

-- session manager
vim.keymap.set("n", "<leader>sl", ":SessionManager load_session<cr>")
vim.keymap.set("n", "<leader>sd", ":SessionManager delete_session<cr>")
vim.keymap.set("n", "<F4>", '/<C-R>=expand("<cword>")<CR><CR>')

-- h: git
vim.keymap.set("n", "<leader>hu", ":Gitsigns undo_stage_hunk<cr>")
vim.keymap.set("n", "<leader>hn", ":Gitsigns next_hunk<cr>")
vim.keymap.set("n", "<leader>hc", ":Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>hR", ":Gitsigns reset_buffer")
vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<cr>")
vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>")
vim.keymap.set("n", "<leader>hs", ":<C-U>Gitsigns select_hunk<CR>")

-- jump to function declaration
vim.keymap.set("n", "<F5>", vim.lsp.buf.declaration)

