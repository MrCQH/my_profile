return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        -- 让 clangd 使用 C++17 标准
        cmd = {
          "clangd",
          "--std=c++17",  -- 关键：添加这一行
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=Google",
        },
      },
    },
  },
}
