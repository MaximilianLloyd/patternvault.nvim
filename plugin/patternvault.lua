-- vim.api.nvim_create_user_command("PatternVault","<cmd>echo 'hello'", { nargs = 0, complete = "customlist,PatternVault" })
vim.api.nvim_create_user_command("PatternVault", function(args)
	require("patternvault.command").load_command(unpack(args.fargs))
end, {
	range = true,
	nargs = "+",
	complete = function(arg)
		local list = require("patternvault.command").command_list()
		return vim.tbl_filter(function(s)
			return string.match(s, "^" .. arg)
		end, list)
	end,
})
