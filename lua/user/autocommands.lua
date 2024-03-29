-- autocmd! removes all autocommands
-- i.e. if entered under a group it will clear that group

vim.cmd([[
  augroup _general_settings
    autocmd!
      autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup end

]])

vim.api.nvim_create_augroup("lsp_format_on_save", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "lsp_format_on_save",
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "yaml" then
			-- Don't format yaml files on save
			return
		end
		vim.lsp.buf.format({ async = false })
	end,
})

-- Add timestamp as extension for backup files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("timestamp_backupext", { clear = true }),
	desc = "Add timestamp to backup extension",
	pattern = "*",
	callback = function()
		vim.opt.backupext = "-" .. vim.fn.strftime("%Y%m%d%H%M")
	end,
})
