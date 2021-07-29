-- Ensures packer gets installed
local execute = vim.api.nvim_command
local fn = vim.fn
local opt = vim.opt

vim.cmd [[packadd packer.nvim]]

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- Ensuring Packer will get acess to the plugin list
require('plugins/packer')

require('nvim_utils')
-- Think about using lbr (:h lbr)

-- Table for global variables
vim.g.vimsyn_embed = 'l'
local o_options = {
    mouse = 'a',
    inccommand = 'split',
    termguicolors = true,
    wildmenu = true,
    colorcolumn = '80',
    -- 7 lines up and down of limit to the cursor
    so = 7,
    cursorcolumn = true,
    cursorline = true,
    ruler = true,
    cmdheight = 1,
    backspace = 'eol,start,indent',
    whichwrap = "b,s,<,>,h,l",
    ai = true,
    si = true,
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    hlsearch = true,
    magic = true,
    showmatch = true,
    backup = false,
    wb = false,
    swapfile = false,
    expandtab = true,
    smarttab = true,
    shiftwidth = 2,
    tabstop = 2,
    clipboard = 'unnamedplus',
    formatprg = 'par\\ -rjw79',
    listchars = 'tab:→\\ ,space:·,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»',
}

for name, value in pairs(o_options) do
    vim.o[name] = value
    opt[name] = value
end
-- comands that didn't work with the above
vim.cmd([[
  set list
  set nowrap
  set noswapfile
  set cc=80
]])
-- Setting up tabs and keeping my sanity on Makefiles
vim.cmd([[
set expandtab
set shiftwidth=2
set tabstop=8
set smarttab
autocmd FileType make set nosmarttab
]])
-- Folding
vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=2
  set foldopen=block,hor,mark,percent,quickfix,tag
]])
-- Undofiles
vim.cmd([[
  set undodir=~/.config/nvim/undodir
  set undofile
]])
-- TODO: consider using the following
-- if has('win32') || has ('win64')
--     let $VIMHOME = $VIM."/vimfiles"
-- else
--     let $VIMHOME = $HOME."/.vim"
-- endif

-- Exception for Makefiles
vim.cmd([[autocmd FileType make set nosmarttab]])

-- Relative number doings
vim.cmd([[set number relativenumber]])
-- map_toggle_settings("number", "relativenumber")
-- completion helper
vim.cmd([[
  set shortmess+=c
]])

local autocmds = {
    relativenumbers = {
        {"BufEnter", "*", "set relativenumber"},
        {"FocusGained", "*", "set relativenumber"},
        {"InsertLeave", "*", "set relativenumber"},
        {"BufLeave", "*", "set norelativenumber"},
        {"FocusLost", "*", "set norelativenumber"},
        {"InsertEnter", "*", "set norelativenumber"},
    },
    files = {
        -- Going back to last line when opening file
        {"BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]}
    },
}

nvim_create_augroups(autocmds)

-- Colorscheme
vim.cmd([[
        syntax enable
        colorscheme gruvbox 
        set background=dark
        hi! Normal ctermbg=None guibg=None
]])

require('extras')
require('plugins')
require('mappings')
require('statusline')
require('lsp')
