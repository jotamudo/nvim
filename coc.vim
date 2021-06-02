source ~/.config/nvim/vimrcs/coc.vim

" nmap <silent> [e :call CocAction('diagnosticNext')<cr>
" nmap <silent> ]e :call CocAction('diagnosticPrevious')<cr>

let g:coc_node_path = '/usr/bin/node'
" use <tab> for trigger completion and navigate to the next complete item
 function! s:check_back_space() abort
   let col = col('.') - 1
     return !col || getline('.')[col - 1]  =~ '\s'
     endfunction

     inoremap <silent><expr> <Tab>
           \ pumvisible() ? "\<C-n>" :
                 \ <SID>check_back_space() ? "\<Tab>" :
                       \ coc#refresh()"
     inoremap <silent><expr> <c-space> coc#refresh()
     " Can use <c-n> and <c-p> for navigating autocompletion so no need to use j and k
     inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
     inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
     inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
     inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
     inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
     autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

" Use <C-l> for trigger snippet expand
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"coc-highlighting
" autocmd CursorHold * silent call CocActionsAsync('highlight')
" coc-explorer
:nnoremap <space>e :CocCommand explorer<CR>
