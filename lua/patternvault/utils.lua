local M = {}

function M.find_value(t, name)
	for k, v in pairs(t) do
		if k == name then
			return v
		end
	end
end

function M.find_index(t, name)
	for k, v in pairs(t) do
		if k == name then
			return k
		end
	end
end

function M.table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- search / cmd
function M.get_last_pattern_from_history(history)
	if (history == "cmd") then
		return M.get_last_pattern_from_cmd()
	end
	
	local latest = vim.fn.histget(history, -1)
	return latest
end

function M.get_last_pattern_from_cmd()
	local latest = vim.fn.histnr("cmd")
	local match = nil

	-- Search recursively for the last pattern
	for i = latest, 1, -1 do
		local cmd = vim.fn.histget("cmd", i)
		if string.match(cmd, "s/") then
			match = cmd
			break
		end
	end

	return match
end


function M.highlight_search(input) 
		local len = string.len(input)
		if (len > 0) then
			return { { 0, len, "Search" } }
		else
			return {}
		end
end

return M
