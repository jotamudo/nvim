vim.cmd([[
  let g:vimtex_fold_enabled = 1
  let g:vimtex_view_general_viewer = 'zathura'
  let g:vimtex_view_method = 'zathura'
  let g:vimtex_quickfix_mode=2
  let g:vimtex_indent_enabled=1
  let g:vimtex_indent_bib_enabled=1
  set conceallevel=2
  let g:tex_conceal='abdmg'
  let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
  let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
  let g:tex_conceal_frac=1
]])
