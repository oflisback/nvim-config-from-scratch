-- autocmd! removes all autocommands
-- i.e. if entered under a group it will clear that group

--    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})

vim.cmd([[
  augroup _general_settings
    autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format { async = false }
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
]])
