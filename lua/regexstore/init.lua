local Config = require("regexstore.config")
local Utils = require("regexstore.utils")
local Store = require("regexstore.store")

local M = {}

M.test = function ()
	-- Parse regex object
	local regex = vim.regex("hello world")
end

-- Set config and read the file if any
M.setup = function(options)
	Config.setup(options)
	Store.read()
end

function M.select()
	-- Read keys from table
	local keys = {}

	if Utils.table_length(Store.regexes) == 0 then
		vim.notify("No regexes found. Add one with 'Regexstore Add'", vim.log.levels.ERROR)
		return
	end

	for k, v in pairs(Store.regexes) do
		table.insert(keys, k)
	end

	vim.ui.select(keys, {
		prompt = "Select a Regex",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.regexes, item)
		end,
	}, function(item, idx)
		if item then
			vim.fn.setreg(Config.options.yank_register, Utils.find_value(Store.regexes, item))
		else
			print("You cancelled")
		end
	end)
end

function M.remove()
	-- Read keys from table
	local keys = {} if Utils.table_length(Store.regexes) == 0 then
		vim.notify("No regexes found. Add one with 'Regexstore Add'", vim.log.levels.ERROR)
		return
	end

	for k, v in pairs(Store.regexes) do
		table.insert(keys, k)
	end

	vim.ui.select(keys, {
		prompt = "Select a Regex to delete",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.regexes, item)
		end,
	}, function(item, idx)
		if item then
			Store.remove(item)
			vim.notify("Regex removed", vim.log.levels.INFO)
			-- vim.fn.setreg(Config.options.yank_register, Utils.find_value(Store.regexes, item))
		else
			print("You cancelled")
		end
	end)
end

function M.input()
	vim.ui.input({
		prompt = "Enter a name for your Regex: ",
		completion = "file",
	}, function(name)
		if name then
			vim.ui.input({
				prompt = "Enter the regex",
				completion = "file",
			}, function(regex)
				if regex then
					Store.add(name, regex)
					print(regex)
				end
			end)
		end
	end)
end

M.setup()

-- M.select()

return M
