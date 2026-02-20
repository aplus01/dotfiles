return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      htmldjango = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      python = { "ruff_format" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
