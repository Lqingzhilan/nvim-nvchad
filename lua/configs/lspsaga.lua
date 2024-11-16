local saga = require('lspsaga')

saga.setup({
    hover_doc = {
        border = 'rounded', -- 边框样式
        max_height = 20,    -- 窗口最大高度
        max_width = 80,     -- 窗口最大宽度
        winblend = 80,      -- 透明度
        focusable = false,  -- 禁止聚焦窗口，防止光标跳进去
        keymaps = {
            hover = 'gh',    -- 将打开 hover_doc 的快捷键设置为 'gh'（可以自定义）
            close = 'q',    -- 设置关闭 hover 窗口为 'q'
            exec = '<CR>',       -- 在窗口中执行操作
        }
    },
})

-- 使用 CursorHold 自动显示 hover 文档
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.cmd("Lspsaga hover_doc")
    end,
})

