return {
    'lervag/vimtex',
    ft = { 'tex' },
    config = function()
        vim.cmd([[
  autocmd FileType tex let g:indentLine_enabled = 0
  let g:vimtex_compiler_latexmk = { 
    \ 'out_dir': 'out', 
    \ 'aux_dir': 'out', 
    \ 'executable' : 'latexmk', 
    \ 'options' : [ 
    \ '-file-line-error', 
    \ '-synctex=1', 
    \ '-interaction=nonstopmode', 
    \ '--shell-escape' 
    \ ], 
    \ }
  let g:vimtex_view_general_viewer = 'skim'
  let g:vimtex_view_method = 'skim'
]])
    end,
}
