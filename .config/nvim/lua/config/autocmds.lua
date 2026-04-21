-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local lazygit_group = vim.api.nvim_create_augroup("local_lazygit_terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = lazygit_group,
  callback = function(args)
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)
    if not name:match("lazygit") then
      return
    end

    local function send_esc()
      local job_id = vim.b[buf].terminal_job_id
      if job_id then
        vim.api.nvim_chan_send(job_id, "\x1b")
      end
    end

    -- Keep <Esc> inside lazygit so it closes its own UI layers
    -- instead of forcing Neovim to leave terminal mode.
    vim.keymap.set("t", "<Esc>", send_esc, { buffer = buf, silent = true, desc = "Send Esc to lazygit" })
    vim.keymap.set("n", "<Esc>", send_esc, { buffer = buf, silent = true, desc = "Send Esc to lazygit" })
  end,
})
