local Config = require("patternvault.config")
local Utils = require("patternvault.utils")
local Store = require("patternvault.store")

local M = {}

-- Set config and read the file if any
M.setup = function(options)
	Config.setup(options)
	Store.read()
end

function M.select()
	-- Read keys from table
	local keys = {}

	if Utils.table_length(Store.patterns) == 0 then
		vim.notify("No patterns found. Add one with 'PatternVault Add'", vim.log.levels.ERROR)
		return
	end

	for k, v in pairs(Store.patterns) do
		table.insert(keys, k)
	end

	vim.ui.select(keys, {
		prompt = "Select a pattern",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.patterns, item)
		end,
	}, function(item, idx)
		if item then
			local pattern = Utils.find_value(Store.patterns, item)
			if (Config.options.auto_open) then
				vim.api.nvim_feedkeys(":" .. pattern, "n", true)
			end

			if (Config.options.should_yank) then
				vim.fn.setreg(Config.options.yank_register, pattern)
			end
		else
			print("You cancelled")
		end
	end)
end

function M.remove()
	-- Read keys from table
	local keys = {}
	if Utils.table_length(Store.patterns) == 0 then
		vim.notify("No patterns found in file. Add one with 'PatternVault Add'", vim.log.levels.ERROR)
		return
	end

	for k, v in pairs(Store.patterns) do
		table.insert(keys, k)
	end

	vim.ui.select(keys, {
		prompt = "Select a pattern to delete",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.patterns, item)
		end,
	}, function(item, idx)
		if item then
			Store.remove(item)
			vim.notify("Pattern removed", vim.log.levels.INFO)
		else
			print("You cancelled")
		end
	end)
end

function M.add()
	vim.ui.input({
		prompt = "Enter a name for your pattern: ",
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
			vim.ui.input({
				prompt = "Enter the pattern: ",
				highlight = Utils.highlight_search,
			}, function(pattern)
				if pattern then
					Store.add(name, pattern)
					print(pattern)
				end
			end)
		end
	end)
end

function M.add_latest(history)
	local history = history or Config.options.default_history
	local last_search = Utils.get_last_pattern_from_history(history)

	vim.ui.input({
		prompt = "Enter a name for " .. last_search .. "",
	}, function(name)
		if name then
			Store.add(name, last_search)
		end
	end)
end

function M.edit_name()
	-- Read keys from table
	local keys = {}
	if Utils.table_length(Store.patterns) == 0 then
		vim.notify("No patterns found. Add one with 'PatternVault Add'", vim.log.levels.ERROR)
		return
	end

	for k, v in pairs(Store.patterns) do
		table.insert(keys, k)
	end

	vim.ui.select(keys, {
		prompt = "Select a Name to edit",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.patterns, item)
		end,
	}, function(prev_name, idx)
		if prev_name then
			vim.notify("Pattern name edited", vim.log.levels.INFO)

			vim.ui.input({
				prompt = "Enter a new name",
				default = prev_name,
				completion = "file",
			}, function(new_name)
				if new_name then
					Store.edit_name(prev_name, new_name)
					vim.notify("Pattern name", vim.log.levels.INFO)
				end
			end)
		end
	end)
end

function M.edit_pattern()
	-- Read keys from table
	local keys = {}
	if Utils.table_length(Store.patterns) == 0 then
		vim.notify("No patterns found. Add one with 'PatternVault Add'", vim.log.levels.ERROR)
		return
	end

	for k, v in pairs(Store.patterns) do
		table.insert(keys, k)
	end

	vim.ui.select(keys, {
		prompt = "Select a pattern to edit",
		format_item = function(item)
			return item .. ": " .. Utils.find_value(Store.patterns, item)
		end,
	}, function(prev_pattern, idx)
		if prev_pattern then
			vim.notify("Pattern name edited", vim.log.levels.INFO)

			vim.ui.input({
				prompt = "Enter a new pattern",
				default = Utils.find_value(Store.patterns, prev_pattern),
				completion = "file",
			}, function(new_pattern)
				if new_pattern then
					Store.edit_pattern(prev_pattern, new_pattern)
					vim.notify("Pattern edited", vim.log.levels.INFO)
				end
			end)
		end
	end)
end

return M
