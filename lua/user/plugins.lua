local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

local with_root_file = function(...)
  local files = { ... }
  return function(utils)
    return utils.root_has_file(files)
  end
end

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("lewis6991/impatient.nvim")

  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

  use("~/repos/projs/private/nvim-config-switcher")

  use("folke/tokyonight.nvim")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lsp-signature-help") -- function signatures
  use("hrsh7th/cmp-nvim-lua")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-media-files.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Lua file styling
  use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  require("null-ls").setup({
    sources = {
      require("null-ls").builtins.diagnostics.selene.with({
        condition = with_root_file("selene.toml"),
      }),
      require("null-ls").builtins.completion.spell,
      require("null-ls").builtins.diagnostics.eslint_d,
      require("null-ls").builtins.formatting.black,
      require("null-ls").builtins.formatting.prettierd,
      require("null-ls").builtins.formatting.stylua,
    },
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/playground")
  -- indent-blankline to indicate indentation level / scope
  use("lukas-reineke/indent-blankline.nvim")

  -- Git
  use("lewis6991/gitsigns.nvim")

  use({
    "lmburns/lf.nvim",
    config = function()
      -- This feature will not work if the plugin is lazy-loaded
      vim.g.lf_netrw = 1

      require("lf").setup({
        escape_quit = false,
        border = "rounded",
      })

      vim.keymap.set("n", "<leader>e", ":Lf<CR>")
    end,
    requires = { "plenary.nvim", "toggleterm.nvim" },
  })

  -- Bufferline
  use("akinsho/bufferline.nvim")

  -- lualine
  use("nvim-lualine/lualine.nvim")

  -- commenting
  use("numToStr/Comment.nvim")
  -- For files with mixed structures and comment styles eg ts+jsx
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- leap for quick movement in visible part of buffer
  -- <leader><Tab> for forward, <leader><S-Tab> for reverse.
  use("ggandor/leap.nvim")

  -- which-key!
  use("folke/which-key.nvim")

  -- remove trailing whitespace on modified lines on save
  use("axelf4/vim-strip-trailing-whitespace")

  -- navigate to github/gitlab url for source line with
  -- <leader>gh
  use("ruanyl/vim-gh-line")

  -- trouble, to direct telescope results to quickfix and more
  -- <leader>q to send telescope result to quickfix window
  use("folke/trouble.nvim")

  -- vim-fugitive teh awesomeness
  use("tpope/vim-fugitive")

  -- neoclip
  -- clipboard history browser, <leader>nc
  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      { "nvim-telescope/telescope.nvim" },
    },
  })

  -- undotree, <leader>u to toggle undo tree panel
  use("mbbill/undotree")

  -- telescope-repo, <leader>P for repo list + set current dir to
  -- repo root.
  use("cljoly/telescope-repo.nvim")
  use("airblade/vim-rooter")

  -- markdown-preview, required manual install bc of config switcher
  -- but is worth it! <leader>mp to toggle markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  -- toggleterm, awesome stuff, terminals with normal mode!
  -- toggle with <leader>§, node with <leader>tn etc.
  use("akinsho/toggleterm.nvim")

  use("ja-ford/delaytrain.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
