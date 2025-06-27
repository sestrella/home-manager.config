local function is_gitignored(filepath)
	local handle = io.popen("git check-ignore '" .. filepath .. "' 2>/dev/null")
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result and result ~= ""
	end
	return false
end

require("oil").setup({
	view_options = {
		is_hidden_file = function(name, bufnr)
			local oil = require("oil")
			local dir = oil.get_current_dir(bufnr)
			if dir then
				local filepath = dir .. "/" .. name
				return is_gitignored(filepath)
			end
			return false
		end,
	},
})
