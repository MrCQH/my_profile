return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Disable default K (Hover) — we use K for line movement
            { "K", false },
            -- gh: LSP hover
            {
              "gh",
              function()
                return vim.lsp.buf.hover()
              end,
              desc = "Hover",
            },
          },
        },
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
            "--query-driver=/usr/bin/c++",
          },
        },
      },
    },
  },
}
