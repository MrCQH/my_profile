return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<F5>",
        function()
          local dap = require("dap")
          if dap.session() then
            dap.continue()
            return
          end

          local function has_dap_config(ft)
            if not ft or ft == "" then
              return false
            end
            local cfg = dap.configurations[ft]
            return cfg and not vim.tbl_isempty(cfg)
          end

          local current_ft = vim.bo.filetype
          if not has_dap_config(current_ft) then
            local current_win = vim.api.nvim_get_current_win()
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              if win ~= current_win then
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.bo[buf].filetype
                if has_dap_config(ft) then
                  vim.api.nvim_set_current_win(win)
                  break
                end
              end
            end
          end

          if not has_dap_config(vim.bo.filetype) then
            vim.notify("未找到可调试的源码窗口，请打开源码文件后再按 F5", vim.log.levels.WARN)
            return
          end

          dap.continue()
        end,
        desc = "Debug Continue",
      },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug Toggle Breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug Conditional Breakpoint",
      },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug UI Toggle" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug Run Last" },
      { "<leader>dc", function() require("dap").clear_breakpoints() end, desc = "Debug Clear Breakpoints" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dlv_path = vim.fn.expand("~/.go/bin/dlv")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })

      dap.set_log_level("TRACE")
      require("dap-go").setup({
        delve = {
          path = dlv_path,
          initialize_timeout_sec = 30,
          port = "${port}",
          args = {},
        },
      })
    end,
  },
}
