return {
  {
    "mfussenegger/nvim-dap",
    lazy = false, -- Load immediately
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      -- Auto-close REPL on terminate
      -- dap.listeners.after.event_terminated["close_repl"] = function()
      --   require("dap").repl.close()
      -- end
      -- dap.listeners.after.event_exited["close_repl"] = function()
      --   require("dap").repl.close()
      -- end

      -- Keybindings
      vim.keymap.set("n", "<S-F5>", function()
        require("dap").terminate() -- Then terminate
      end, { desc = "Debug: Terminate" })
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Conditional Breakpoint" })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-python").setup("python") -- or path to your python
    end,
  },
}
