vim.uv = vim.uv or vim.loop

local M = {}

---@param opts? JayVimConfig
function M.setup(opts)
	require("config").setup(opts)
end

return M
