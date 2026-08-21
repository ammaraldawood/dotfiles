return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["vim.lsp.buf.hover"] = false,
        ["vim.lsp.buf.signature_help"] = false,
        ["cmp.entry.get_documentation"] = false,
      },
      -- Keep signature help or hover popups if you like them
      signature = { enabled = true },
      hover = { enabled = true },
    },
    notify = {
      enabled = true, -- make sure notifications are routed through noice
      -- options to forward to nvim-notify
      background_colour = "#000000",
      timeout = 5000, -- show notifications for 5 seconds
      top_down = false, -- show newer notifications at the bottom
      level = 3,      -- log level threshold (lower = less verbose)
      max_width = function() return math.floor(vim.o.columns * 0.6) end,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    },
    messages = {
      enabled = true, -- Keep message history
    },
    popupmenu = {
      enabled = true, -- Keep enhanced command-line completion
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
