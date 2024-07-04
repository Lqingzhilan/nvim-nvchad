local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
    -- 配置拷贝字符串（变量名、函数名等） 配置拷贝字符串（变量名、函数名等）
map("n", "<C-y>", "viwy", { desc = "Copy string" })
-- 选中全文
map("n", "<C-a>", "ggVG", { desc = "select whole file" })
-- 选中光标所在的字符串
map("n", "ff", "viw", { desc = "select current string" })
-- 重新映射C-V
map("n", "vv", "<C-V>", { desc = "vertical view mode" })
map("n", "<F1>", "<cmd> NvimTreeToggle <CR>", { desc = "list directory tree" })
map("n", "<F2>", "<cmd> SymbolsOutline <CR>", { desc = "list the symbols of functions, strcut and so on" })
map("n", "<leader>l", "<cmd> NvimTreeFindFiles <CR>", { desc = "find current file in directory tree" })
map("n", "<F3>", "<cmd> noh <CR>", { desc = "取消查找高亮" })
-- map("n", "<F4>", '<cmd> /<C-R>=expand("<cword>")<CR> <CR>', "查找光标下字符串")
map("n", "<F8>", "<cmd> lua require'mywords'.hl_toggle() <CR>", { desc = "高亮光标下字符串" })
map("n", "<F9>", "<cmd> bprevious <CR>", { desc = "vim前一个缓冲区文件" })
map("n", "<F10>", "<cmd> bnext <CR>", { desc = "vim后一个缓冲区文件" })
map("n", "<leader>S", "<cmd> lua require('spectre').open() <CR>", { desc = "open spectre" })
map("n", "<leader>sr", "<cmd> lua require('spectre').open_visual({select_word=true}) <CR>", { desc = "find current string" })
-- map("n", "<leader>s", "<esc>:lua require('spectre').open_visual() <CR>", { desc = "open visual spectre" })
map("n", "<leader>sf", "viw:lua require('spectre').open_file_search() <CR>", { desc = "find in current file" })
map("n", "<space>j", "g;", { desc = "跳转到前一个修改点" })
map("n", "<space>k", "g,", { desc = "跳转到后一个修改点" })
-- lspsaga
map("n", "[e",
  function()
    require("lspsaga.diagnostic"):goto_prev ({ severity = vim.diagnostic.severity.ERROR })
  end
)
map("n", "]e",
  function()
    require("lspsaga.diagnostic"):goto_next ({ severity = vim.diagnostic.severity.ERROR })
  end
)
map("n", "[w",
  function()
    require("lspsaga.diagnostic"):goto_prev ({ severity = vim.diagnostic.severity.WARN })
  end
)
map("n", "]w",
  function()
    require("lspsaga.diagnostic"):goto_next ({ severity = vim.diagnostic.severity.WARN })
  end
)
map("n", "<F12>", "<cmd> Lspsaga code_action <CR>", { desc = "lspsaga code action" })
map("n", "<leader>f",
  function()
    vim.lsp.buf.format ({ async = true })
  end,
  { desc = "LSP formatting" }
)
map("n", "<leader>r", "<esc>:bufdo e <CR>", { desc = "Reload all files opened for clangd" })

map("t", "<C-e>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

map("n", "<F5>",
   function()
     vim.lsp.buf.declaration()
   end,
   { desc = "LSP declaration" }
)

map("n", "<C-]>",
   function()
     vim.lsp.buf.definition()
   end,
   { desc = "LSP definition" }
)


map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
 map("n", "<space>v",
   function()
     require("nvim-tree.api").node.open.vertical()
   end
)

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "telescope nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)
map("n", "<C-p>",
  function()
    require("telescope.builtin").find_files {
      layout_strategy = "vertical",
      layout_config = { height = 0.9, preview_cutoff = 60, prompt_position = "bottom", width = 0.9 }
    }
  end
)
map("n", "<F6>",
  function()
    require("telescope.builtin").grep_string {
      layout_config = { height = 0.99, width = 0.99 },
      path_display = { "smart" },
      fname_width = 70,
      file_ignore_patterns = {
        "tags",
      }
    }
  end
)
map("n", "<F7>",
  function()
    require("telescope.builtin").lsp_references {
      layout_config = { height = 0.95, width = 0.99 },
      path_display = { "smart" },
      fname_width = 70,
    }
  end
)
-- map("n", "<leader>gs", "<cmd> Telescope git_status <CR>", "Git status" )
map("n", "<leader>gs",
  function()
    require("telescope.builtin").git_status {
      layout_config = { height = 0.99, width = 0.99 },
      path_display = { "smart" },
      fname_width = 80,
    }
  end
)

-- theme switcher
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "Nvchad themes" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

-- nvterm
map("n", "<leader>h",
  function()
    require("nvterm.terminal").toggle "horizontal"
  end,
  { desc = "Toggle horizontal term" }
)

map("n", "<leader>v",
  function()
    require("nvterm.terminal").toggle "vertical"
  end,
  { desc = "Toggle vertical term" }
)

map("n", "<leader>tt",
  function()
    require("nvterm.terminal").toggle "tab"
  end,
  { desc = "Toggle exit term" }
)

-- new
map("n", "<leader>hh",
  function()
    require("nvterm.terminal").new "horizontal"
  end,
  { desc = "New horizontal term" }
)

map("n", "<leader>vv",
  function()
    require("nvterm.terminal").new "vertical"
  end,
  { desc = "New vertical term" }
)

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal new horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })

-- gitsigns
map("n", "]c",
  function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      require("gitsigns").next_hunk()
    end)
    return "<Ignore>"
  end,
  { desc = "Jump to next hunk" }
)

map("n", "[c",
  function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      require("gitsigns").prev_hunk()
    end)
    return "<Ignore>"
  end,
  { desc = "Jump to prev hunk" }
)

-- Actions
map("n", "<leader>rh",
  function()
    require("gitsigns").reset_hunk()
  end,
  { desc = "Reset hunk" }
)

map("n", "<leader>ph",
  function()
    require("gitsigns").preview_hunk()
  end,
  { desc = "Preview hunk" }
)

map("n", "<leader>gb",
  function()
    package.loaded.gitsigns.blame_line()
  end,
  { desc = "Blame line" }
)

map("n", "<leader>td",
  function()
    require("gitsigns").toggle_deleted()
  end,
  { desc = "Toggle deleted" }
)

map("n", "<leader>gd",
  function()
    require("gitsigns").diffthis()
  end,
  { desc = "Toggle deleted" }
)

-- session manager
map("n", "<leader>sl", ":SessionManager load_session <CR>", { desc = "SessionManager load_session"})
map("n", "<leader>sd", ":SessionManager delete_session<cr>")
map("n", "<F4>", '/<C-R>=expand("<cword>")<CR><CR>')

-- h: git
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<cr>")
map("n", "<leader>hn", ":Gitsigns next_hunk<cr>")
map("n", "<leader>hc", ":Gitsigns preview_hunk<cr>")
map("n", "<leader>hr", ":Gitsigns reset_hunk<cr>")
map("n", "<leader>hR", ":Gitsigns reset_buffer")
map("n", "<leader>hb", ":Gitsigns blame_line<cr>")
map("n", "<leader>gd", ":Gitsigns diffthis<cr>")
map("n", "<leader>hs", ":<C-U>Gitsigns select_hunk<CR>")

-- jump to function declaration
map("n", "<F5>", vim.lsp.buf.declaration)

-- diff two files
map("n", "<space>d", ":windo diffthis<cr>", { desc = "diffthis files" })
map("n", "<leader>d", ":windo diffoff<cr>", { desc = "cancle diffthis files" })
