-- Define commands here
local command = {}

local subcommands = {
	add_latest = function(arg)
		require("patternvault").add_latest(arg)
	end,
	add = function()
		require("patternvault").add()
	end,
	remove = function()
		require("patternvault").remove()
	end,
	select = function()
		require("patternvault").select()
	end,
	edit_name = function()
		require("patternvault").edit_name()
	end,
	edit_pattern = function()
		require("patternvault").edit_pattern()
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
