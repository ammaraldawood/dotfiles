require("ammar.core")
require("ammar.lazy")

local py = vim.fn.exepath("python3")
if py ~= "" then
	vim.g.python3_host_prog = py
end
