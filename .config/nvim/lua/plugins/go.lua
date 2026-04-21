return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              -- 用 goimports 代替 gofumpt，自动处理 import 且更快
              gofumpt = false,
              -- 过滤不需要分析的目录，减少 gopls 工作量
              directoryFilters = { "-.git", "-.idea", "-node_modules", "-vendor" },
              -- 关闭 staticcheck（很耗时，如需要可用 golangci-lint 替代）
              staticcheck = false,
              -- 减少不必要的代码分析
              analyses = {
                unusedparams = true,
                shadow = false,
                nilness = false,
                unusedwrite = false,
                fieldalignment = false,
              },
              -- 补全优化
              completionBudget = "200ms",
              -- 关闭不常用的 codelens 减少开销
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = false,
                run_govulncheck = false,
                tidy = true,
                upgrade_dependency = false,
                vendor = false,
              },
            },
          },
        },
      },
    },
  },

  -- 用 goimports 替代 gopls 的 organizeImports（更快）
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
      },
    },
  },
}
