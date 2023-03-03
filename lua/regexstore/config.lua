local M = {}

function M.defaults()
	local defaults = {
		yank_register = '"',
		root = vim.fn.stdpath("config"),
		regexes = {},
	}
	return defaults
end

M.options = {}
M.namespace_id = vim.api.nvim_create_namespace("RegstoreNS")

function M.setup(options)
	options = options or {}
	M.options = vim.tbl_deep_extend("force", M.defaults(), options)
end

M.setup()

return M
