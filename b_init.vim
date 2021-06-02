let s:plug_dir = expand('/tmp/plugged/vim-plug')
if !isdirectory(s:plug_dir)
  execute printf('!curl -fLo %s/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', s:plug_dir)
end

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true

execute 'set runtimepath+=' . s:plug_dir
call plug#begin(s:plug_dir)
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
call plug#end()

"lua << EOF
"require'compe'.setup {
"	enabled = true;
"	autocomplete = true;
"	debug = false;
"	min_length = 1;
"	preselect = 'enable';
"	throttle_time = 80;
"	source_timeout = 200;
"	incomplete_delay = 400;
"	allow_prefix_unmatch = false;
"
"	source = {
"		path = true;
"		buffer = true;
"		calc = true;
"		vsnip = true;
"		nvim_lsp = true;
"		nvim_lua = true;
"		spell = true;
"		tags = true;
"		snippets_nvim = true;
"	};
"}
"EOF

