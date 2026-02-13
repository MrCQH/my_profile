-- ~/.config/nvim/lua/plugins.lua
return {
  -- Mason（包管理器）
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  -- Mason ↔ LSPconfig 桥梁（自动安装服务器）
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
    },
  },
  -- LSP 配置主体
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  config = function()
    -- 1. 补全能力（nvim-cmp 所需）
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 2. 通用 LSP 快捷键（on_attach）
    local on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, bufopts)
    end

    -- ============= 3. 使用 vim.lsp.config 注册语言服务器 =============
    vim.lsp.config["lua_ls"] = {
      cmd = { "lua-language-server" }, -- Mason 安装后自动在 PATH
      root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
      filetypes = { "lua" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    }
    -- 4. 启用该服务器
    vim.lsp.enable("lua_ls")
  end,
}
