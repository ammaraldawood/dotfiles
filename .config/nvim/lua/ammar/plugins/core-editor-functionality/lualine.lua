return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {

			blue = "#142435",
			darkestblue = "#070c12",
			darkerblue = "#0d1823",
			lighterblue = "#3a689a",
			lightestblue = "#93b3d6",

			orange = "#ff8c00",
			darkestorange = "#573000",
			darkerorange = "#ab5e00",
			lighterorange = "#ffb254",
			lightestorange = "#ffd8a8",

			white = "#ffffff",
			black = "#000000",
			darkergrey = "#333333",
			darkgrey = "#666666",
			lightergrey = "#cccccc",
			lightgrey = "#999999",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.darkergrey, fg = colors.white, gui = "bold" },
				b = { bg = colors.black, fg = colors.white },
				c = { bg = colors.darkergrey, fg = colors.white },
			},
			insert = {
				a = { bg = colors.lightergrey, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.white },
				c = { bg = colors.lightergrey, fg = colors.black },
			},
			visual = {
				a = { bg = colors.lightestorange, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.white },
				c = { bg = colors.lightestorange, fg = colors.black },
			},
			command = {
				a = { bg = colors.lightestblue, fg = colors.black, gui = "bold" },
				b = { bg = colors.black, fg = colors.white },
				c = { bg = colors.lightestblue, fg = colors.black },
			},
			replace = {
				a = { bg = colors.lightergrey, fg = colors.black, gui = "bold" },
				b = { bg = colors.white, fg = colors.black },
				c = { bg = colors.lightergrey, fg = colors.black },
			},
			inactive = {
				a = { bg = colors.darkestorange, fg = colors.white, gui = "bold" },
				b = { bg = colors.white, fg = colors.black },
				c = { bg = colors.darkestorange, fg = colors.white },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ffffff" },
					},
					{ "encoding" },
					{ "fileformat", symbols = { unix = "" } },
					{ "filetype" },
				},
			},
		})
	end,
}
