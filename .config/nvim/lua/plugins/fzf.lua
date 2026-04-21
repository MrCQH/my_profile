return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- 可选：显示图标，更美观
      -- "nvim-mini/mini.icons",       -- 或者用这个替代
    },
    config = function()
      require("fzf-lua").setup({
        -- 这里可以放自定义配置，暂时留空用默认即可
        winopts = {
          height = 0.85, -- 窗口高度
          width = 0.80, -- 窗口宽度
          preview = {
            horizontal = "right:45%", -- 预览窗口位置
          },
        },
      })

      -- 推荐常用快捷键（可自行修改）
      -- vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find files" })
      -- vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
      -- vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
    end,
  },
}
