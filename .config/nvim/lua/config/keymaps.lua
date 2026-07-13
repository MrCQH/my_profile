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


-- Move line up/down with J/K
vim.keymap.set("n", "J", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "K", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected lines up" })

-- gh: LSP hover / keyword help (non-LSP buffer fallback)
vim.keymap.set("n", "gh", function()
  local ok, _ = pcall(vim.lsp.buf.hover)
  if not ok then
    vim.cmd("normal! K")
  end
end, { desc = "Show help / LSP hover" })

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
