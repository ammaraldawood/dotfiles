-- Setup lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "ammar.plugins.core-editor-functionality" },
	{ import = "ammar.plugins.debug-adapter-protocol-core" },
	{ import = "ammar.plugins.general-utility-and-editing" },
	{ import = "ammar.plugins.git-and-version-control" },
	{ import = "ammar.plugins.language-and-syntax" },
	{ import = "ammar.plugins.navigation-and-search" },
	{ import = "ammar.plugins.specific-and-niche-tools" },
}, {
	checker = {
		enabled = true,
		notify = true,
	},
	change_detection = {
		notify = true,
	},
	rocks = {
		hererocks = false,
	},
})
