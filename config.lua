--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["<C-s>"] = "<esc>:w<cr>a"
lvim.keys.normal_mode["K"] = "<cmd>lua vim.lsp.buf.hover()<cr>"
lvim.keys.normal_mode["gd"] = "<cmd>lua vim.lsp.buf.definition()<cr>"
lvim.keys.normal_mode["gr"] = "<cmd>lua vim.lsp.buf.references()<cr>"
lvim.keys.normal_mode["gf"] = "<cmd>lua vim.lsp.buf.rename()<cr>"
lvim.keys.normal_mode["gi"] = "<cmd>lua vim.lsp.buf.implementation()<cr>"
lvim.keys.normal_mode["gi"] = "<cmd>lua vim.lsp.buf.implementation()<cr>"
lvim.keys.normal_mode["ga"] = "<cmd>lua require('lvim.core.telescope').code_actions()<cr>"
lvim.keys.normal_mode["gl"] = "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<CR>"
lvim.keys.normal_mode["gn"] =
	"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>"
lvim.keys.normal_mode["gp"] =
	"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>"

lvim.builtin.terminal.execs["2"] = ""
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
vim.o.timeoutlen = 200

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	-- for input mode
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
	},
	-- for normal mode
	n = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
	},
}
require("telescope").load_extension("sessions")
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}
-- lvim.builtin.which_key.mappings.e = {"<cmd>lua require'core.nvimtree'.focus_or_close()<CR>", "Explorer"}
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.project.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
vim.g.dashboard_enable_session = 0
lvim.builtin.snippets = false
-- lvim.builtin.which_key.mappings.e = {"<cmd>lua require'core.nvimtree'.focus_or_close()<CR>", "Explorer"}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"css",
	"rust",
	"java",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('session_manager').LoadCurrentDirSession<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('session_manager').LoadLastSession<cr>", "Restore last session" },
	t = { "<cmd>Telescope sessions<cr>", "Select session" },
}
-- generic LSP settings
-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		-- args = { "--print-with", "100" },
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "typescript", "typescriptreact" },
	},
	{
		exe = "stylua",
		filetypes = { "lua" },
	},
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	-- { exe = "flake8", filetypes = { "python" } },
	-- {
	--   exe = "shellcheck",
	--   ---@usage arguments to pass to the formatter
	--   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
	--   args = { "--severity", "warning" },
	-- },
	-- {
	--   exe = "codespell",
	--   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
	--   filetypes = { "javascript", "python" },
	-- },
	{
		exe = "eslint",
		filetypes = { "typescript", "typescriptreact" },
	},
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	-- { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
	-- { "VimEnter", "*", "lua require('persistence').load()" }
	{ "VimLeavePre", "*", "lua require('session_manager').save_current_session()" },
  { "TermOpen", "term://*", "lua set_terminal_keymaps()"}
}
vim.opt_global.shortmess:remove("F")
lvim.lsp.override = { "rust" }
lvim.plugins = {
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = false,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd = { vim.fn.stdpath("data") .. "/lsp_servers/rust/rust-analyzer" },
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			})
		end,
		ft = { "rust", "rs" },
	},
	{
		"scalameta/nvim-metals",
		config = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = function()
				require("lsp").common_on_attach()
			end
			metals_config.settings = {
				showImplicitArguments = false,
				showInferredType = true,
				excludedPackages = {},
				scalafmtConfigPath = "/home/oliver/.scalafmt.conf",
			}
			metals_config.init_options.statusBarProvider = false
			require("metals").initialize_or_attach({ metals_config })
		end,
		ft = { "scala", "sbt" },
	},
	-- {"folke/tokyonight.nvim"},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup({
				auto_open = true,
				-- auto_close = true,
			})
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		event = "BufRead",
		config = function()
			require("project").setup()
		end,
	},
	{
		"Shatur/neovim-session-manager",
		config = function()
			local Path = require("plenary.path")
			require("session_manager").setup({
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
				path_replacer = "__", -- The character to which the path separator will be replaced for session files.
				colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
				autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autosave_last_session = true, -- Automatically save last session on exit.
				autosave_ignore_not_normal = true, -- Plugin will not save a session when no writable and listed buffers are opened.
			})
		end,
	},
	{
		"ActivityWatch/aw-watcher-vim",
	},
	{
		"towolf/vim-helm",
		ft = { "yaml" },
	},
	{ "tpope/vim-unimpaired" },
	{ "GEverding/vim-hocon" },
	{ "mg979/vim-visual-multi" },
}
-- formatters
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
})
