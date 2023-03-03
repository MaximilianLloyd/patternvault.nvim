-- Define commands here
--
local command = {}

local subcommands = {
	add = function()
		require("regexstore").input()
	end,
	remove = function()
		require("regexstore").remove()
	end,
	select = function()
		require("regexstore").select()
	end,
	peek_definition = function()
		print("Hello")
	end,
}

function command.command_list()
	return vim.tbl_keys(subcommands)
end

function command.load_command(cmd, ...)
	local args = { ... }
	if next(args) ~= nil then
		subcommands[cmd](args[1])
	else
		subcommands[cmd]()
	end
end

return command
