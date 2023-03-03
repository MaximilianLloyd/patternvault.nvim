-- Define commands here
--
local command = {}

local subcommands = {
	add_latest = function()
		require("regexstore").add_latest()
	end,
	add = function()
		require("regexstore").add()
	end,
	remove = function()
		require("regexstore").remove()
	end,
	select = function()
		require("regexstore").select()
	end,
	edit_name = function()
		require("regexstore").edit_name()
	end,
	edit_regex = function()
		require("regexstore").edit_regex()
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
