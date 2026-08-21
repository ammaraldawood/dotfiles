-- Quarto and Otter
return {
	"quarto-dev/quarto-nvim",
	dependencies = {
		"jmbuhr/otter.nvim",
		"nvim-treesitter/nvim-treesitter",
		"benlubas/molten-nvim",
	},
	ft = { "quarto", "qmd" },
	config = function()
		require("quarto").setup({
			debug = false,
			lspFeatures = {
				enabled = true,
				languages = { "r", "python", "bash", "sql", "html", "css", "make", "dockerfile", "asm", "snakemake" },
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = {
					enabled = true,
				},
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
				ft_runners = {
					bash = "molten",
					python = "molten",
					r = "molten",
					html = "molten",
					css = "molten",
				},
			},
		})
		local runner = require("quarto.runner")
		vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
		vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
		vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
		vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
		vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
		vim.keymap.set("n", "<localleader>RA", function()
			runner.run_all(true)
		end, { desc = "run all cells of all languages", silent = true })
		require("otter").setup({
			lsp = {
				hover = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
			},
			buffers = {
				set_filetype = true,
				write_to_disk = true,
			},
			handle_leading_whitespace = true,
			strip_wrapping_quote_characters = { '"', "'", "`" },
			aliases = {
				["=html"] = "html", -- Map =html to html for LSP and formatting
			},
		})
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = { "*.qmd" },
			callback = function(ctx)
				vim.defer_fn(function()
					if vim.bo[ctx.buf].filetype == "quarto" then
						require("otter").activate(
							{ "r", "python", "bash", "sql", "html", "css", "make", "dockerfile", "asm", "snakemake" },
							true
						)
					end
				end, 100)
			end,
			group = vim.api.nvim_create_augroup("QuartoOtter", { clear = true }),
		})
	end,
}
