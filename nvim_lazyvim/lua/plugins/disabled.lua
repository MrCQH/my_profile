return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "yetone/avante.nvim",
    opts = {
      provider = "vtrix",
      providers = {
        vtrix = {
          __inherited_from = "openai",
          endpoint = "https://cloud.vtrix.ai/llm",
          model = "claude-opus-4-6",
          api_key_name = "AVANTE_OPENAI_API_KEY",
        },
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
