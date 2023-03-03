-- File to handle writing and reading JSON
local Config = require("patternvault.config")
-- local Utils = require("PatternVault.utils")

local M = {
	patterns = {},
}

-- To handle regexs
function encode (to_encode)
	return to_encode:gsub("\\", "\\\\")
end

function decode (to_decode)
	return to_decode:gsub("\\\\", "\\")
end

function M.add(name, pattern)
	M.patterns[name] = pattern
	M.save()
end

function M.remove(name)
	M.patterns[name] = nil
	M.save()
end

function M.save()
	-- Read the file
	local file = io.open(Config.options.root .. "/patternvault.json", "w")

	local to_save = {}

	for k, v in pairs(M.patterns) do
		to_save[k] = encode(v)
	end

	local to_write = vim.fn.json_encode(to_save)
	local data = file:write(to_write)
	file:close()
end

function M.read()
	-- Read the file
	local file = io.open(Config.options.root .. "/patternvault.json", "r")

	if file == nil then
		return nil
	end

	local data = file:read("*all")
	local parsed = vim.fn.json_decode(data)

	for k, v in pairs(parsed) do
		parsed[k] = decode(v)
	end

	M.patterns = parsed
end

function M.edit_name(old_name, new_name)
	M.patterns[new_name] = M.patterns[old_name]
	M.patterns[old_name] = nil
	M.save()
end

function M.edit_pattern(name, pattern)
	M.patterns[name] = pattern
	M.save()
end

return M
