return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    vim.g.VM_default_mappings = 1
    vim.g.VM_mouse_mappings = 1
  end,
  keys = {
    { "<C-n>", desc = "VM: 选中当前单词/下一个" },
    { "<C-down>", desc = "VM: 向下创建光标" },
    { "<C-up>", desc = "VM: 向上创建光标" },
  },
}
