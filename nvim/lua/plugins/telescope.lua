-- 1. 插件声明与懒加载配置（以 lazy.nvim 为例）
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8', -- 强烈建议锁定稳定版本，避免滚动更新意外出错
  -- 或使用分支：branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Telescope 的核心依赖，必须
    -- 极速文件预览（强烈推荐）
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- 可选：更现代的预览器，支持更多文件类型
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- 可选：递归查找文件图标（需要先安装 nvim-web-devicons）
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- 2. 核心配置区：所有 setup 必须放在这里
    require('telescope').setup {
      -- -------------------- 全局默认设置 --------------------
      defaults = {
        -- ---------- 2.1 文件路径与展示优化 ----------
        file_ignore_patterns = {
          "node_modules",     -- 前端项目依赖
          ".git",            -- 版本控制目录
          "dist",            -- 构建输出
          "build",
          "target",          -- Rust 构建目录
          "%.o", "%.out",    -- 编译中间文件
          "%.class",         -- Java 字节码
          "%.pyc",           -- Python 字节码
          "__pycache__",
        },
        -- 路径缩短显示（/home/user/project/src/app.js → project/src/app.js）
        path_display = { 'truncate' }, 
        -- 同时显示绝对路径和相对路径？一般不需要，保持简洁
        -- 文件排列顺序：按最近修改时间倒序（方便快速找到刚编辑的文件）
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        -- ---------- 2.2 界面与交互优化 ----------
        layout_strategy = 'horizontal',    -- 可选：horizontal, vertical, flex
        layout_config = {
          horizontal = {
            preview_width = 0.55,          -- 预览窗口占比 prompt_position = 'top',
          },
          width = 0.85,                   -- 主窗口宽度
          height = 0.80,                 -- 主窗口高度
        },
        -- 滚动速度（单位：行）
        scroll_speed = 3,
        -- 搜索历史记录数量
        history_limit = 100,
        -- 每页显示的结果数（性能与流畅度平衡）
        results_per_page = 100,
        -- ---------- 2.3 映射与行为优化 ----------
        mappings = {
          i = {  -- insert 模式下的快捷键
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-n>"] = "cycle_history_next",
            ["<C-p>"] = "cycle_history_prev",
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-d>"] = "preview_scrolling_down",
            -- 常用：<Esc> 退出，但 insert 模式下按 <Esc> 会回到 normal，再按一次才退出
            -- 更快捷：<C-c> 直接退出
            ["<C-c>"] = "close",
            -- 在搜索结果中，使用 <C-y> 复制选中项到系统剪贴板
            -- ["<C-y>"] = require('telescope.actions').copy_to_qflist,
          },
          n = {  -- normal 模式下的快捷键
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["q"] = "close",
          },
        },
      },
      -- -------------------- 3. 扩展插件配置 --------------------
      extensions = {
        fzf = {
          fuzzy = true,                    -- 模糊搜索
          override_generic_sorter = true,  -- 覆盖默认排序器
          override_file_sorter = true,     -- 覆盖文件排序器
          case_mode = "smart_case",        -- 智能大小写
        },
        ["ui-select"] = {
          require('telescope.themes').get_dropdown {
            -- 让 vim.ui.select 使用 Telescope 风格的 UI
            -- 例如 nvim-notify, lazy.nvim 的提示等都会变得更漂亮
          }
        }
      },
    }

    -- 4. 加载扩展（必须在 setup 之后）
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- 5. 快捷键映射（建议统一放在这里，或单独 keymaps.lua）
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<Leader>ff', builtin.find_files, { desc = '查找项目文件' })
    vim.keymap.set('n', '<Leader>fg', builtin.live_grep, { desc = '全局文本搜索' })
    vim.keymap.set('n', '<Leader>fb', builtin.buffers, { desc = '切换缓冲区' })
    vim.keymap.set('n', '<Leader>fh', builtin.help_tags, { desc = '查找帮助文档' })
    vim.keymap.set('n', '<Leader>fo', builtin.oldfiles, { desc = '最近打开的文件' })
    vim.keymap.set('n', '<Leader>fk', builtin.keymaps, { desc = '查看快捷键映射' })
    vim.keymap.set('n', '<Leader>fc', builtin.commands, { desc = '查看可用命令' })
    -- Git 相关（如果使用 git）
    vim.keymap.set('n', '<Leader>gs', builtin.git_status, { desc = 'Git 修改文件' })
    vim.keymap.set('n', '<Leader>gb', builtin.git_branches, { desc = 'Git 分支' })
    -- LSP 相关（如果配置了 lspconfig）
    vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '查看引用' })
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = '跳转到定义' })
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = '跳转到实现' })
  end,
}
