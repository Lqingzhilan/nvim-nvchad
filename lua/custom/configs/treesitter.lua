    -- nvim-treesitter config
require 'nvim-treesitter.configs'.setup {
    -- ensure_installed = "maintained", -- for installing all maintained parsers
    ensure_installed = { "c", "cmake", "make", "lua", "python", "bash", "json" }, -- for installing specific parsers
    sync_install = true, -- install synchronously
    ignore_install = {}, -- parsers to not install
    -- highlight = {
    --     enable = true,
    --     -- disable = { "cpp" },
    --     additional_vim_regex_highlighting = false, -- disable standard vim highlighting
    -- },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false, -- disable standard vim highlighting
    },

    indent = { enable = true },
}
-- local npairs = require("nvim-autopairs")
-- local Rule = require('nvim-autopairs.rule')

-- npairs.setup({
--     check_ts = true,
--     ts_config = {
--         lua = {'string'},-- it will not add a pair on that treesitter node
--         javascript = {'template_string'},
--         java = false,-- don't check treesitter on java
--     }
-- })

-- local ts_conds = require('nvim-autopairs.ts-conds')


-- -- press % => %% only while inside a comment or string
-- npairs.add_rules({
--     Rule("%", "%", "lua")
--     :with_pair(ts_conds.is_ts_node({'string','comment'})),
--     Rule("$", "$", "lua")
--     :with_pair(ts_conds.is_not_ts_node({'function'}))
-- })

