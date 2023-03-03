print("HGello")

-- vim.api.nvim_create_user_command("Regexstore","<cmd>echo 'hello'", { nargs = 0, complete = "customlist,Regexstore" })
vim.api.nvim_create_user_command("Regexstore", function(args)
	require("regexstore.command").load_command(unpack(args.fargs))
end, {
	range = true,
	nargs = "+",
	complete = function(arg)
		local list = require("regexstore.command").command_list()
		return vim.tbl_filter(function(s)
			return string.match(s, "^" .. arg)
		end, list)
	end,
})
