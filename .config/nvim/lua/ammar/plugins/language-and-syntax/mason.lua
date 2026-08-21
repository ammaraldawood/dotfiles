return {
  "mason-org/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  config = function()
    -- Mason setup
    require("mason").setup({})
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua",     -- Lua formatter
        "flake8",     -- Python linter
        "shellcheck", -- Bash linter
      },
    })
  end,
}
