return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local select = require("nvim-treesitter-textobjects.select")
		local swap = require("nvim-treesitter-textobjects.swap")
		local move = require("nvim-treesitter-textobjects.move")
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local function sel(lhs, query, desc)
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(query, "textobjects")
			end, { desc = desc })
		end

		sel("a=", "@assignment.outer", "Select outer part of an assignment")
		sel("i=", "@assignment.inner", "Select inner part of an assignment")
		sel("l=", "@assignment.lhs", "Select left hand side of an assignment")
		sel("r=", "@assignment.rhs", "Select right hand side of an assignment")
		sel("a:", "@property.outer", "Select outer part of an object property")
		sel("i:", "@property.inner", "Select inner part of an object property")
		sel("l:", "@property.lhs", "Select left part of an object property")
		sel("r:", "@property.rhs", "Select right part of an object property")
		sel("aa", "@parameter.outer", "Select outer part of a parameter/argument")
		sel("ia", "@parameter.inner", "Select inner part of a parameter/argument")
		sel("ai", "@conditional.outer", "Select outer part of a conditional")
		sel("ii", "@conditional.inner", "Select inner part of a conditional")
		sel("al", "@loop.outer", "Select outer part of a loop")
		sel("il", "@loop.inner", "Select inner part of a loop")
		sel("af", "@call.outer", "Select outer part of a function call")
		sel("if", "@call.inner", "Select inner part of a function call")
		sel("am", "@function.outer", "Select outer part of a method/function definition")
		sel("im", "@function.inner", "Select inner part of a method/function definition")
		sel("ac", "@class.outer", "Select outer part of a class")
		sel("ic", "@class.inner", "Select inner part of a class")

		vim.keymap.set("n", "<leader>na", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap parameter with next" })
		vim.keymap.set("n", "<leader>n:", function()
			swap.swap_next("@property.outer")
		end, { desc = "Swap object property with next" })
		vim.keymap.set("n", "<leader>nm", function()
			swap.swap_next("@function.outer")
		end, { desc = "Swap function with next" })
		vim.keymap.set("n", "<leader>pa", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap parameter with previous" })
		vim.keymap.set("n", "<leader>p:", function()
			swap.swap_previous("@property.outer")
		end, { desc = "Swap object property with previous" })
		vim.keymap.set("n", "<leader>pm", function()
			swap.swap_previous("@function.outer")
		end, { desc = "Swap function with previous" })

		local function go(fn, lhs, query, desc)
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move[fn](query, "textobjects")
			end, { desc = desc })
		end

		go("goto_next_start", "]f", "@call.outer", "Next function call start")
		go("goto_next_start", "]m", "@function.outer", "Next method/function def start")
		go("goto_next_start", "]c", "@class.outer", "Next class start")
		go("goto_next_start", "]i", "@conditional.outer", "Next conditional start")
		go("goto_next_start", "]l", "@loop.outer", "Next loop start")
		vim.keymap.set({ "n", "x", "o" }, "]s", function()
			move.goto_next_start("@local.scope", "locals")
		end, { desc = "Next scope" })
		vim.keymap.set({ "n", "x", "o" }, "]z", function()
			move.goto_next_start("@fold", "folds")
		end, { desc = "Next fold" })
		go("goto_next_end", "]F", "@call.outer", "Next function call end")
		go("goto_next_end", "]M", "@function.outer", "Next method/function def end")
		go("goto_next_end", "]C", "@class.outer", "Next class end")
		go("goto_next_end", "]I", "@conditional.outer", "Next conditional end")
		go("goto_next_end", "]L", "@loop.outer", "Next loop end")
		go("goto_previous_start", "[f", "@call.outer", "Prev function call start")
		go("goto_previous_start", "[m", "@function.outer", "Prev method/function def start")
		go("goto_previous_start", "[c", "@class.outer", "Prev class start")
		go("goto_previous_start", "[i", "@conditional.outer", "Prev conditional start")
		go("goto_previous_start", "[l", "@loop.outer", "Prev loop start")
		go("goto_previous_end", "[F", "@call.outer", "Prev function call end")
		go("goto_previous_end", "[M", "@function.outer", "Prev method/function def end")
		go("goto_previous_end", "[C", "@class.outer", "Prev class end")
		go("goto_previous_end", "[I", "@conditional.outer", "Prev conditional end")
		go("goto_previous_end", "[L", "@loop.outer", "Prev loop end")

		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
