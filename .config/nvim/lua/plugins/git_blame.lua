return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
    keys = {
      {
        "<leader>gy",
        function()
          local file = vim.fn.expand("%:p")
          local line = vim.api.nvim_win_get_cursor(0)[1]
          local root = vim.fs.root(0, ".git")

          if not root then
            vim.notify("Not a Git repository", vim.log.levels.WARN)
            return
          end

          local relfile = vim.fs.relpath(root, file)

          local output = vim.fn.system({
            "git",
            "-C",
            root,
            "blame",
            "-L",
            line .. "," .. line,
            "--porcelain",
            "--",
            relfile,
          })

          local sha = output:match("^(%x+)")
          if vim.v.shell_error ~= 0 or not sha or sha:match("^0+$") then
            vim.notify("Cannot get commit SHA", vim.log.levels.WARN)
            return
          end

          sha = sha:sub(1, 7)
          vim.fn.setreg("+", sha)
          vim.fn.setreg('"', sha)

          vim.notify("Copied commit SHA: " .. sha)
        end,
        desc = "Copy current line Git SHA",
      },
    },
  },
}
