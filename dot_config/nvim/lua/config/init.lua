_G.JayVim = require("util")

---@class JayVimConfig: JayVimOptions
local M = {}

M.version = "0.0.1"
JayVim.config = M

---@class JayVimOptions
local defaults = {
	---@type string|fun()
	colorscheme = "rose-pine",
	defaults = {
		autocmds = true,
		keymaps = true,
	},
	news = {
		lazyvim = false,
		neovim = true,
	},
	icons = {
		misc = {
			dots = "󰇘",
		},
		ft = {
			octo = "",
		},
		dap = {
      Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint          = " ",
      BreakpointCondition = " ",
      BreakpointRejected  = { " ", "DiagnosticError" },
      LogPoint            = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    },
    git = {
      added    = " ",
      modified = " ",
      removed  = " ",
    },
    kinds = {
      Array         = " ",
      Boolean       = "󰨙 ",
      Class         = " ",
      Codeium       = "󰘦 ",
      Color         = " ",
      Control       = " ",
      Collapsed     = " ",
      Constant      = "󰏿 ",
      Constructor   = " ",
      Copilot       = " ",
      Enum          = " ",
      EnumMember    = " ",
      Event         = " ",
      Field         = " ",
      File          = " ",
      Folder        = " ",
      Function      = "󰊕 ",
      Interface     = " ",
      Key           = " ",
      Keyword       = " ",
      Method        = "󰊕 ",
      Module        = " ",
      Namespace     = "󰦮 ",
      Null          = " ",
      Number        = "󰎠 ",
      Object        = " ",
      Operator      = " ",
      Package       = " ",
      Property      = " ",
      Reference     = " ",
       Snippet       = " ",
      String        = " ",
      Struct        = "󰆼 ",
      TabNine       = "󰏚 ",
      Text          = " ",
      TypeParameter = " ",
      Unit          = " ",
      Value         = " ",
      Variable      = "󰀫 ",
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
	  default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    mardown = false,
    help = false,
    lua = {
	     "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
    }
    }

M.json = {
	version = 6,
	path = vim.g.jayvim_json or vim.fn.stdpath("config") .. "/jayvim.json",
	data = {
		version = nil, ---@type string?
		news = {}, ---@type table<string, string>
		extras = {}, ---@type string[]
	},
}

function M.json.load()
	local f = io.open(M.json.path, "r")
	if f then
		local data = f:read("*a")
		f:close()
		local ok, json = pcall(vim.json.decode, data, { luanil = {object = true, array = true }})
		if ok then
			M.json.data = vim.tbl_deep_extend("force", M.json.data, json or {})
			if M.json.data.version ~= M.json.version then
				JayVim.json.migrate()
			end
		end
	end
end

---@type JayVimOptions
local options

---@param opts? JayVimOptions
function M.setup(opts)
	options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

	-- autocmds con be loaded lazily when not opening a file
	local lazy_autocmds = vim.fn.argc(-1) == 0
	if not lazy_autocmds then
		M.load("autocmds")
	end

	local group = vim.api.nvim_create_augroup("JayVim", {clear = true})
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "VeryLazy",
		callback = function()
			if lazy_autocmds then
				M.load("autocmds")
			end
			M.load("keymaps")

			JayVim.format.setup()
			JayVim.news.setup()
			JayVim.root.setup()

			vim.api.nvim_create_user_command("JayExtras", function()
				JayVim.extras.show()
			end, { desc = "Manage JayVim extras"})

			vim.api.nvim_create_user_command("LazyHealth", function()
				vim.cmd([[Lazy! load all]])
				vim.cmd([[checkhealth]])
			end, { desc = "Load all plugins and run :checkhealth"})

			local health = require("health")
			vim.list_extend(health.valid, {
				"recommended",
				"desc",
				"vscode",
			})
		end,
	})

	JayVim.track("colorscheme")
	JayVim.try(function()
		if type(M.colorscheme) == "function" then
			M.colorscheme()
		else
			vim.cmd.colorscheme(M.colorscheme)
		end
	end, {
	msg = "Could not load your colorscheme",
	on_error = function(msg)
		JayVim.error(msg)
		vim.cmd.colorscheme("habamax")
	end,
})
JayVim.track()
end

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
	buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
	local ft = vim.bo[buf].filetype
	if M.kind_filter == false then
		return 
	end
	if M.kind_filter[ft] == false then
		return
	end
	if type(M.kind_filter[ft]) == "table" then
		return M.kind_filter[ft]
	end
	---@diagnostic disable-next-line: return-type-mismatch
	return type(M.kind_filter) == "table" and type(M.kind_filter,default) == "table" and M.kind_filter.default or nil
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
	local function _load(mod)
		if require("lazy.core.cache").find(mod)[1] then
			JayVim.try(function()
				require(mod)
			end, {msg = "Failed loading " .. mod })
		end
		end
		if M.defaults[name] or name == "options" then
			_load("config." .. name)
		end
		if vim.bo.filetype == "lazy" then
			vim.cmd([[fo VimResized]])
		end
		local pattern = "JayVim" .. name:sub(1, 1):upper() .. namem:sub(2)
		vim.api.nvim_exec_autocmd("User", {pattern = pattern, modeline = false})
	end

M.did_init = false
function M.init()
	if M.did_init then
		return 
	end
	M.did_init = true
	local plugin = require("lazy.core.config").spec.plugins.JayVim
	if plugin then
		vim.opt.rtp:append(plugin.dir)
	end

	package.preload["plugins.lsp.format"] = function()
		JayVim.deprecate([[require("plugins.lsp.format")]], [[JayVim.format]])
		return JayVim.format
	end

	JayVim.lazy_notify()

	M.load("options")

	if vim.g.deprecation_warnings == false then
		vim.deprecate = function() end
	end

	JayVim.plugin.setup()
	M.json.load()
end

setmetatable(M, {
	__index = function(_, key)
		if options == nil then
			return vim.deepcopy(defaults)[key]
		end
		---@case options JayVimConfig
		return options[key]
	end,
})

return M
