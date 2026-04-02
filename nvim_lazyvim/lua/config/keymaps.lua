-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
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
