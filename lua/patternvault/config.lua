local M = {}

function M.defaults()
	local defaults = {
		yank_register = '+',
		root = vim.fn.stdpath("config"),
		default_history = 'cmd',
		auto_open = true, -- Feeds the pattern to the command line, so you can 
		should_yank = false, -- Should the pattern be yanked to the register
	}
	return defaults
end

M.options = {}
-- Not sure how to use this yet
-- M.namespace_id = vim.api.nvim_create_namespace("RegstoreNS")

function M.setup(options)
	options = options or {}
	M.options = vim.tbl_deep_extend("force", M.defaults(), options)
end

M.setup()

return M
