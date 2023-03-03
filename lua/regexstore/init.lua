local Config = require("regexstore.config")
local Utils = require("regexstore.utils")
local Store = require("regexstore.store")

local M = {}

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
	local keys = {}
	if Utils.table_length(Store.regexes) == 0 then
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
		else
			print("You cancelled")
		end
	end)
end

function M.add()
	vim.ui.input({
		prompt = "Enter a name for your Regex: ",
		completion = "file",
		highlight = function(input)
			if string.len(input) > 8 then
				return { { 0, 8, "Search" } }
			else
				return {}
			end
		end,
	}, function(name)
		if name then
			local last_search = Utils.get_last_regex_from_history()

			vim.ui.input({
				prompt = "Enter the pattern: ",
				default = last_search,
				highlight = Utils.highlight_search,
			}, function(regex)
				if regex then
					Store.add(name, regex)
					print(regex)
				end
			end)
		end
	end)
end

function M.add_latest()
	local last_search = Utils.get_last_regex_from_history()

	vim.ui.input({
		prompt = "Enter a name for your Regex: ",
	}, function(name)
		if name then
			Store.add(name, last_search)
		end
	end)
end

function M.edit_name()
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
		prompt = "Select a Name to edit",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.regexes, item)
		end,
	}, function(prev_name, idx)
		if prev_name then
			vim.notify("Regex name edited", vim.log.levels.INFO)

			vim.ui.input({
				prompt = "Enter a new name",
				default = prev_name,
				completion = "file",
			}, function(new_name)
				if new_name then
					Store.edit_name(prev_name, new_name)
					vim.notify("Regex name", vim.log.levels.INFO)
				end
			end)
		end
	end)
end

function M.edit_regex()
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
		prompt = "Select a Regex to edit",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.regexes, item)
		end,
	}, function(prev_regex, idx)
		if prev_regex then
			vim.notify("Regex name edited", vim.log.levels.INFO)

			vim.ui.input({
				prompt = "Enter a new regex",
				default = Utils.find_value(Store.regexes, prev_regex),
				completion = "file",
			}, function(new_regex)
				if new_regex then
					-- Store.edit_name(prev_regex, new_name)
					Store.edit_regex(prev_regex, new_regex)
					vim.notify("Regex edited", vim.log.levels.INFO)
				end
			end)
		end
	end)
end

M.setup()
M.add()

return M
