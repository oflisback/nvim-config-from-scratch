local isBolland = os.getenv("HOME"):match("bolland$") ~= nil

require("user.options")
require("user.plugins")
require("user.impatient")
require("user.colorscheme")
require("user.completion")
if not isBolland then
	require("user.delaytrain")
end
require("user.dap")
require("user.lsp")
require("user.null-ls")
require("user.telescope")
require("user.treesitter")
require("user.gitsigns")
require("user.leap")
require("user.neoclip")
require("user.neovide")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.indent-blankline")
require("user.comment")
require("user.autocommands")
require("user.trouble")
if isBolland then
	require("user.copilot")
end
require("user.which-key")
require("user.keymaps")
