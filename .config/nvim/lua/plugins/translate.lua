return {
  "uga-rosa/translate.nvim",
  cmd = { "Translate" },
  keys = {
    { "<leader>tz", "<cmd>Translate ZH<cr>", mode = "v", desc = "Translate to Chinese" },
    { "<leader>te", "<cmd>Translate EN<cr>", mode = "v", desc = "Translate to English" },
    { "<leader>tz", "viw<cmd>Translate ZH<cr>", mode = "n", desc = "Translate word to Chinese" },
    { "<leader>te", "viw<cmd>Translate EN<cr>", mode = "n", desc = "Translate word to English" },
    { "<leader>tZ", "<cmd>Translate ZH -output=replace<cr>", mode = "v", desc = "Translate & replace to Chinese" },
    { "<leader>tE", "<cmd>Translate EN -output=replace<cr>", mode = "v", desc = "Translate & replace to English" },
  },
  opts = {
    default = {
      command = "google",
    },
    preset = {
      output = {
        split = {
          append = true,
        },
      },
    },
  },
}
