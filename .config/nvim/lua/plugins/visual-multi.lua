return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    vim.g.VM_default_mappings = 1
    vim.g.VM_mouse_mappings = 1
    -- VM 默认会在进入多光标时把 <CR>/<Up>/<Down>/<C-u> 等键位以 buffer-local
    -- 映射覆盖到当前 buffer（覆盖掉 blink.cmp 的补全键位），退出多光标时直接
    -- unmap，不恢复原映射。blink.cmp 只在 InsertEnter 时按 desc 前缀判断
    -- "已应用过"就跳过重设，导致退出多光标后 Enter 确认补全永久失效。
    -- 这里清空 VM 的 insert 模式映射（官方支持空字符串 = 不映射），
    -- 使其完全不碰 insert 模式的 buffer-local 键位。normal 模式的多光标不受影响。
    -- 注意：先构造完整 table 再一次性赋值（空 table 会转成只读的 v:empty，
    -- 之后再逐个赋值会被静默丢弃）。
    local vm_maps = {}
    for _, name in ipairs({
      "I Arrow w", "I Arrow b", "I Arrow W", "I Arrow B",
      "I Arrow ge", "I Arrow e", "I Arrow gE", "I Arrow E",
      "I Left Arrow", "I Right Arrow", "I Up Arrow", "I Down Arrow",
      "I Return", "I BS", "I CtrlW", "I CtrlU", "I CtrlD",
      "I Ctrl^", "I Del", "I Home", "I End",
      "I CtrlB", "I CtrlF", "I CtrlC", "I CtrlO", "I Replace", "I Paste",
    }) do
      vm_maps[name] = ""
    end
    vim.g.VM_maps = vm_maps
  end,
  keys = {
    { "<C-n>", desc = "VM: 选中当前单词/下一个" },
    { "<C-down>", desc = "VM: 向下创建光标" },
    { "<C-up>", desc = "VM: 向上创建光标" },
  },
}
