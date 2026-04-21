return {
  {
    "sminrana/nvim-filediff",
    event = "VeryLazy", -- 延迟加载，加快启动速度
    dependencies = { "nvim-lua/plenary.nvim" }, -- 可能需要（看仓库要求）
    config = function()
      local filediff = require("filediff")

      -- 推荐快捷键绑定
      vim.keymap.set("n", "<leader>fd", "<cmd>FileDiff<CR>", { desc = "Diff two files" })
      vim.keymap.set("n", "<leader>fi", "<cmd>FileDiffInput<CR>", { desc = "Diff via input paths" })
      vim.keymap.set("n", "<leader>fo", "<cmd>FolderDiff<CR>", { desc = "Diff two folders" })
    end,
  },
}
