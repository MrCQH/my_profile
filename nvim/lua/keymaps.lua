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
--
-- cp pwd
vim.keymap.set("n", "<leader>cp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path" })

vim.keymap.set("n", "<leader>cP", function()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })

vim.keymap.set("n", "<leader>sg", LazyVim.pick("live_grep", { root = false }), { desc = "Grep (cwd)" })

-- Linewise paste: keep cursor at the same column
vim.keymap.set("n", "p", function()
	local col = vim.fn.col(".")
	vim.cmd("normal! p")
	vim.fn.cursor(vim.fn.line("."), col)
end, { noremap = true, desc = "Paste below, keep column" })

vim.keymap.set("n", "P", function()
	local col = vim.fn.col(".")
	vim.cmd("normal! P")
	vim.fn.cursor(vim.fn.line("."), col)
end, { noremap = true, desc = "Paste above, keep column" })
