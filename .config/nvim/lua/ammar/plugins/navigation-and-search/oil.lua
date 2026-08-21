return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	lazy = false,
	keys = {
		{ "<leader>ee", "<cmd>Oil<CR>", desc = "Open Oil file explorer" },
	},
}
