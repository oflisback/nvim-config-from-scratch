local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>bd!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = { "<cmd>lua require('user.telescope').find_files()<cr>", "Find files" },
	["r"] = { "<cmd>lua require('user.telescope').oldfiles()<cr>", "Recent files" },
	["F"] = { "<cmd>lua require('user.telescope').live_grep()<cr>", "Find text" },
	["u"] = { "<cmd>UndotreeToggle<cr>", "Undo tree" },
	["P"] = { "<cmd>Telescope repo list<cr>", "Repo list" },
	["p"] = { "<cmd>ChatGPT<cr>", "ChatGPT" },

	g = {
		name = "+Git",
		b = { "<cmd>Git blame<cr>", "Blame" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
		g = { "<cmd>:Git<CR>", "vim-fugitive status" },
		h = { "<cmd>:GHInteractive<CR>", "Open in browser" },
		j = { '<cmd>lua require"gitsigns".next_hunk()<CR>', "Next Hunk" },
		k = { '<cmd>lua require"gitsigns".prev_hunk()<CR>', "Prev Hunk" },
		f = { "<cmd>:0Gclog<CR>", "File log" },
		p = { '<cmd>lua require"gitsigns".preview_hunk()<CR>', "Preview Hunk" },
		r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
		s = { '<cmd>lua require"gitsigns".stage_hunk()<CR>', "Stage Hunk" },
		u = { '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', "Undo Stage Hunk" },
		c = {
			name = "+Conflict Resolution",
			s = { "<cmd>Gdiffsplit!<cr>", "Start" },
			-- Fugitive follows a consistent naming convention when creating
			-- buffers for the target and merge versions of a conflicted file.
			-- The parent file from the target branch always includes the
			-- string //2, while the parent from the merge branch always
			-- contains //3.
			h = { "<cmd>diffget //2<cr>", "Get hunk from left (target)" },
			l = { "<cmd>diffget //3<cr>", "Get hunk from right (merge)" },
			f = { "<cmd>Gwrite!<cr>", "Finish" },
		},
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>lua require('user.telescope').document_diagnostics()<cr>", "Document Diagnostics" },
		h = {
			"<cmd>lua vim.diagnostic.open_float()<cr>",
			"Diagnostic",
		},
		s = {
			"<cmd>lua vim.lsp.buf.hover()<cr>",
			"Symbol info",
		},
		w = { "<cmd>lua require('user.telescope').workspace_diagnostics()<cr>", "Workspace Diagnostics" },
		W = {
			"<cmd>StripTrailingWhitespace<cr>",
			"Strip trailing whitespace in file",
		},
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	},
	s = {
		name = "Search and symbols",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		d = {
			"<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
			"Document Symbols",
		},
		w = {
			"<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
			"Workspace Symbols",
		},
		f = { "<cmd>lua require('user.telescope').find_files()<cr>", "Find files" },
		t = { "<cmd>lua require('user.telescope').live_grep()<cr>", "Live grep" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>lua require('user.telescope').oldfiles()<cr>", "Recent files" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	m = {
		name = "Misc :O",
		g = { "<cmd>CellularAutomaton game_of_life<cr>", "Game of life" },
		m = { "<cmd>CellularAutomaton make_it_rain<cr>", "Make it rain" },
		k = { "<cmd>Telescope keymaps<cr>", "Telescope keymaps" },
		o = { "<cmd>only<cr>", "Only" },
		p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown preview" },
	},

	n = {
		name = "Misc :O",
		c = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Neoclip" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
	d = {
		name = "Debugger",
		b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
