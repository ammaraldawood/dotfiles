return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local langs = {
			"python",
			"r",
			"swift",
			"sql",
			"yaml",
			"html",
			"css",
			"c",
			"markdown",
			"markdown_inline",
			"cpp",
			"asm",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"pkl",
			"vimdoc",
			"json",
		}
		require("nvim-treesitter").install(langs)

		vim.treesitter.language.register("bash", "zsh")
		vim.treesitter.language.register("markdown", "quarto")

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local ok = pcall(vim.treesitter.start, ev.buf)
				if ok then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
