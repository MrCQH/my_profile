return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "File History (project)" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
    },
  },
}
