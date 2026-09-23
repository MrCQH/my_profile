return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      bigfile = {
        size = 10 * 1024 * 1024, -- 10MB，超过才禁用功能（默认 1.5MB）
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = {},
      },
    },
  },
}
