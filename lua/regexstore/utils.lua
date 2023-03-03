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

function M.get_last_regex_from_history()
	local latest = vim.fn.histget("search", -1)
	return latest
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
