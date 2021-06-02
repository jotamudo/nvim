" Starting configs {
let &packpath = &runtimepath
set path +=~/.config/nvim/
set mouse=a
set inccommand=split
set termguicolors
set statusline^=%{coc#status()}
set lazyredraw
set path+=**
set wildmenu
set cursorcolumn
set cursorline
set clipboard=unnamedplus
" Mapping for justification 'gq'
set formatprg=par\ -rjw79
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»
set list
" Text shifting
vnoremap > >gv
vnoremap < <gv

" Relative number doings
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Organize the sourcing files to make it more pleasing to see and modify
source ~/.config/nvim/vimrcs/basic.vim
source ~/.config/nvim/vimrcs/filetypes.vim
source ~/.config/nvim/coc.vim
" }

"set foldmethod=syntax
"set foldlevel=2
"set foldclose=all
" Folds {
set foldenable
set foldmethod=expr
set foldlevel=10000
set foldexpr=nvim_treesitter#foldexpr()
set foldopen=block,hor,mark,percent,quickfix,tag

" Save folds
" augroup remember_folds
"     autocmd!
"     autocmd BufWinLeave * mkview
"     autocmd BufWinEnter * silent! loadview
" augroup END

"nmap <c-j>     zczjzo
"nmap <c-k>     zczkzo%0
"nmap <c-m>     zMggza
"nmap <c-l>     zjzo
"nmap <c-h>     zc
"nmap <c-space> za
" }

" Some lil configs {
set smartindent
set nu
set nowrap
set smartcase
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
" }

" CTRLP {
let g:ctrlp_map = '<c-p>'
" }

" IndentLine {
let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#7a7a7a'
let g:indentLine_char = '|'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char_color = '#7a7a7a'
"let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
" }

" vim-plug section {
call plug#begin('~/.config/nvim/plugged')

" File tree
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'PhilRunninger/nerdtree-buffer-ops'
" Language syntax compatibility
" Git integration
" TODO: Learn git
Plug 'tpope/vim-fugitive'
" Cool undo history
Plug 'mbbill/undotree'
" Nice indentation
" Plug 'Yggdroot/indentLine'
" let g:indentLine_defaultGroup = 'SpecialKey'
" let g:indentLine_setColors = 0
" File searching
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Easy comment handling
Plug 'tpope/vim-commentary'
" Completion, lintering and lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'voldikss/vim-floaterm'
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'kristijanhusak/completion-tags'
" Plug 'albertoCaroM/completion-tmux'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/completion-treesitter'
" let g:completion_enable_snippet = 'UltiSnips'
" Pretty airline and themes
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

" If you want to display icons, then use one of these plugins:
Plug 'kyazdani42/nvim-web-devicons' " lua
Plug 'ryanoasis/vim-devicons' " vimscript
" Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
" Latex integration
Plug 'lervag/vimtex'
autocmd FileType tex let g:indentLine_enabled = 0
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_method = 'latexmk'
" Nice conceal features
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
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

" Nice snippets
"TODO: consider using this snippet engine
"Plug 'norcalli/snippets.nvim'
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger="<c-f>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSpli="vertical"

Plug 'honza/vim-snippets'
"Plug 'rstacruz/vim-closer'
"Plug 'Raimondi/delimitMate'
Plug 'jiangmiao/auto-pairs'
" Training minigame
" TODO: Play the damm game
"Plug 'ThePrimeagen/vim-be-good'
" Code coloring
" TODO: Read docs and use it
Plug 'lpinilla/vim-codepainter'
Plug 'mg979/vim-visual-multi'
"Plug 'stevearc/vim-arduino'
Plug 'metakirby5/codi.vim'
" web
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-surround'
Plug 'szw/vim-maximizer'
Plug 'diepm/vim-rest-console'
call plug#end()
" }


" NerdTREE {
" Getting current buffer
"function! IsNERDTreeOpen()
"    return exists ("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction

"function SyncTree()
"    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"        NERDTreeFind
"        wincmd p
"    endif
"endfunction

""Highlight current open buffer on NERDTree
"autocmd BufEnter * call SyncTree()
" }

" Telescope
" lua require('tele')
" Find files using Telescope command-line sugar.
" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
lua << EOF
require('telescope').setup{
    file_ignore_patterns = {".git", "node_modules", "__pycache__"},
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
}
EOF

" Treesiter
lua require('personal/ts')

"" Sanity and cool stuff {
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>o :NERDTree<CR>
nnoremap <leader>ot :NERDTreeToggle<CR>
nnoremap <leader>oc :NERDTreeClose<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

" swapping ; and : to maintain sanity
" Commands won't work if done so
"nnoremap ; :
"vnoremap ; :
inoremap jk <esc>
inoremap kj <esc>
"inoremap jj <esc>
"inoremap kk <esc>
" }

" Statusline {
lua require('statusline')
" }

" Vanity :) {
colorscheme gruvbox
"solarized8 configs{
"let g:solarized_visibility = "high"
"let g:solarized_termtrans = 0
"let g:solarized_use16 = 0
"let g:solarized_extra_hi_groups = 1
"let g:solarized_diffmode = "high"
"set background=dark
"}
let g:airline_theme='base16_gruvbox_dark_hard'
set cc=80
set showcmd
hi! Normal ctermbg=None guibg=None
" }


" lsp {
"map <c-p> to manually trigger completion
" imap <silent> <c-h> <Plug>(completion_trigger)
"imap <tab> <Plug>(completion_smart_tab)
"imap <s-tab> <Plug>(completion_smart_s_tab)

" let g:completion_confirm_key = ""
" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"         \ "\<Plug>(completion_confirm_completion)"  :
"         \ "\<c-e>\<CR>" : "\<CR>"
" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Avoid showing message extra message when using completion
" set shortmess+=c

" lua require('personal/lsp')


" keybindings{
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gi  <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> gs  <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> gtd <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> KK :lua require'lsp-extensions'.inlay_hints{ only_current_line=true }<CR>

" lua require'completion'.addCompletionSource('vimtex', require'vimtex'.complete_item)
" let g:completion_chain_complete_list = {
"     \ 'default': [
"     \    {'complete_items': ['snippet', 'lsp', 'ts', 'path']},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \],
"     \
"     \ 'tex' : [
"     \    {'complete_items': ['snippet', 'vimtex', 'lsp', 'path']}, 
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \],
" \}
" }
