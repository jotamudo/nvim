return {
  "lervag/vimtex",
  ft = {"tex"},
  config = function ()
    vim.cmd([[
  autocmd FileType tex let g:indentLine_enabled = 0
  let g:tex_flavor = 'latex'
  let g:vimtex_compiler_progname = 'nvr'
  let g:vimtex_compiler_latexmk = { 'executable' : 'latexmk', 'options' : [ '-file-line-error', '-synctex=1', '-interaction=nonstopmode', '--shell-escape' ], }
]])

  end
}
