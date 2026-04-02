return {
  -- 如果你还想使用 copilot.lua (一个 Lsp 客户端的 Copilot 插件)
  -- 并且你已经配置了 lspconfig，可以添加以下内容
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = false, -- 禁用默认 Tab，在 keymaps.lua 中手动处理优先级
            next = "<C-n>",
            prev = "<C-p>",
            dismiss = "<C-g>",
          },
        },
        panel = {
          enabled = false,
        },
      })
    end,
  },
}
