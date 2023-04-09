local fn = vim.fn
local isBolland = os.getenv("HOME"):match("bolland$") ~= nil

local function required(name)
  return function()
    require(name)
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local with_root_file = function(...)
	local files = { ... }
	return function(utils)
		return utils.root_has_file(files)
	end
end

require("lazy").setup({
	-- My plugins here
	"lewis6991/impatient.nvim",

	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

	"folke/tokyonight.nvim",

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-signature-help", -- function signatures
	"hrsh7th/cmp-nvim-lua",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/nvim-lsp-installer", -- simple to use language server installer


	-- Lua file styling
	{ "ckipp01/stylua-nvim", run = "cargo install stylua" },
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	"p00f/nvim-ts-rainbow",
	"nvim-treesitter/playground",
	-- indent-blankline to indicate indentation level / scope
	"lukas-reineke/indent-blankline.nvim",

  -- clipboard history browser, <leader>nc
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = required("user.telescope"),
  },

{
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
},

  -- trouble, to direct telescope results to quickfix and more
  -- <leader>q to send telescope result to quickfix window
  "folke/trouble.nvim",

	-- Git
	"lewis6991/gitsigns.nvim",

	{
		"lmburns/lf.nvim",
		config = function()
			-- This feature will not work if the plugin is lazy-loaded
			vim.g.lf_netrw = 1

			require("lf").setup({
			escape_quit = false,
			border = "rounded"
			})

		end,
		dependencies = { "plenary.nvim", "toggleterm.nvim" },
	},

	-- Bufferline
	"akinsho/bufferline.nvim",

	-- lualine
	"nvim-lualine/lualine.nvim",

	-- commenting
	"numToStr/Comment.nvim",
	-- For files with mixed structures and comment styles eg ts+jsx
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- leap for quick movement in visible part of buffer
	-- <leader><Tab> for forward, <leader><S-Tab> for reverse.
	"ggandor/leap.nvim",

	-- which-key!
	"folke/which-key.nvim",

	-- remove trailing whitespace on modified lines on save
	"axelf4/vim-strip-trailing-whitespace",

	-- navigate to github/gitlab url for source line with
	-- <leader>gh
	"ruanyl/vim-gh-line",

	-- vim-fugitive teh awesomeness
	"tpope/vim-fugitive",

	-- undotree, <leader>u to toggle undo tree panel
	"mbbill/undotree",

  "cljoly/telescope-repo.nvim",
	"airblade/vim-rooter",

  -- You may need to manually do yarn install in:
  -- ~/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim/
  -- to get it working.
	{
		"iamcco/markdown-preview.nvim",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_browser = 'firefox'
		end,
    build = "cd app && npm install",
		ft = { "markdown" },
	},

	-- toggleterm, awesome stuff, terminals with normal mode!
	-- toggle with <leader>§, node with <leader>tn etc.
	"akinsho/toggleterm.nvim",

	"ja-ford/delaytrain.nvim",

	-- debug adapter protocol implementation
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	{ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } },
	{ "eandrju/cellular-automaton.nvim" }
})
