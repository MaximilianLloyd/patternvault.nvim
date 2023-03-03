-- File to handle writing and reading JSON
local Config = require("regexstore.config")
-- local Utils = require("regexstore.utils")

local M = {
	regexes = {},
}

-- To encode and decode the regexes
function encode (to_encode)
	return to_encode:gsub("\\", "\\\\")
end

function decode (to_decode)
	return to_decode:gsub("\\\\", "\\")
end

function M.add(name, regex)
	M.regexes[name] = encode(regex)
	M.save()
	vim.notify("Regex added", vim.log.levels.INFO)
end

function M.remove(name)
	M.regexes[name] = nil
	M.save()
end

function M.save()
	-- Read the file
	local file = io.open(Config.options.root .. "/regexstore.json", "w")
	local to_write = vim.fn.json_encode(M.regexes)
	local data = file:write(to_write)

	file:close()
end

function M.read()
	-- Read the file
	local file = io.open(Config.options.root .. "/regexstore.json", "r")

	if file == nil then
		return nil
	end

	local data = file:read("*all")
	local parsed = vim.fn.json_decode(data)

	for k, v in pairs(parsed) do
		parsed[k] = decode(v)
	end

	M.regexes = parsed
end

function M.edit_name(old_name, new_name)
	M.regexes[new_name] = M.regexes[old_name]
	M.regexes[old_name] = nil
	M.save()
end

function M.edit_regex(name, regex)
	M.regexes[name] = regex
	M.save()
end

return M
