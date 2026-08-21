return {

	"nvim-mini/mini.base16",
	version = false,
	config = function()
		local blue = "#142435"
		local darkestblue = "#070c12"
		local darkerblue = "#0d1823"
		local lighterblue = "#3a689a"
		local lightestblue = "#93b3d6"

		local orange = "#ff8c00"
		local darkestorange = "#573000"
		local darkerorange = "#ab5e00"
		local lighterorange = "#ffb254"
		local lightestorange = "#ffd8a8"

		local white = "#ffffff"
		local black = "#000000"
		local darkergrey = "#333333"
		local darkgrey = "#666666"
		local lightergrey = "#cccccc"
		local lightgrey = "#999999"

		require("mini.base16").setup({
			palette = {
				base00 = blue, -- Background
				base01 = black, -- Lighter Background (status bars)
				base02 = black, -- Selection Background
				base03 = lightergrey, -- Comments
				base04 = lightgrey, -- Dark Foreground
				base05 = white, -- Default Foreground
				base06 = lightergrey, -- Light Foreground
				base07 = white, -- Lightest Foreground
				base08 = orange, -- Variables
				base09 = lightestorange, -- Integers, Boolean
				base0A = orange, -- Classes, Types
				base0B = lightestorange, -- Strings
				base0C = orange, -- Support, Regular Expressions
				base0D = orange, -- Functions
				base0E = orange, -- Keywords
				base0F = lightestblue, -- Deprecated
			},
		})
	end,
}
