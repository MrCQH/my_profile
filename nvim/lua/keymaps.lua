vim.g.mapleader = " "

local keymap = vim.keymap

--- 插入模式
keymap.set("i", "jk", "<ESC>")

--- view模式
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 水平窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")
-- keymap.set("n", "<leader>gd", "<Plug>(coc-definition)")
-- keymap.set("n", "<leader>gr", "<Plug>(coc-references)")

-- 搜索
-- keymap.set("n", "<C-p>", ":GFiles<CR>", {noremap = true})
