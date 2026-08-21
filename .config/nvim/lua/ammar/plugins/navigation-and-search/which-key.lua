return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    return opts
  end,
}

