local cmp_status_ok, delaytrain = pcall(require, "delaytrain")
if not cmp_status_ok then
	return
end

delaytrain.setup({
	keys = {
		["nv"] = { "h", "j", "k", "l", "w", "b" },
		["nvi"] = { "<Left>", "<Down>", "<Up>", "<Right>" },
	},
})
