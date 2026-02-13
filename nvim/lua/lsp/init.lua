-- Configure LSP capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set default capabilities for all LSP servers
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Configure diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»"
    },
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "none", -- Changed from "rounded" to "none"
    source = "if_many",
    header = "",
    prefix = "",
  },
})


-- Load server configurations
require('lsp.servers.lua').setup()
require('lsp.servers.typescript').setup()
require('lsp.servers.python').setup()
require('lsp.servers.go').setup()
require('lsp.servers.web').setup()
require('lsp.servers.tex').setup()
require('lsp.servers.misc').setup()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "biome",
    "cssls",
    'ts_ls',
    'eslint',
    'gopls',
    'jsonls',
    'html',
    'clangd',
    'dockerls',
    'ansiblels',
    'terraformls',
    'texlab',
    'pyright',
    'yamlls',
    'tailwindcss',
    'taplo',
    "prismals",
  },
  automatic_enable = true,
})

-- Format on save
local format_on_save_filetypes = {
  json = true,
  go = true,
  lua = true,
  html = true,
  css = true,
  javascript = true,
  typescript = true,
  typescriptreact = true,
  c = true,
  cpp = true,
  objc = true,
  objcpp = true,
  dockerfile = true,
  terraform = false,
  tex = true,
  toml = true,
  prisma = true,
}
