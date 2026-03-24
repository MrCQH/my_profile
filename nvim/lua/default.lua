local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.undofile = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 窗口
opt.splitright = true
opt.splitbelow = true

-- 外观
opt.termguicolors = true
-- 左侧多一列
opt.signcolumn = "yes"

opt.scrolloff = 0
opt.sidescrolloff = 0
opt.smoothscroll = false
