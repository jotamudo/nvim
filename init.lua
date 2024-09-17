-- Ensures packer gets installed
local opt = vim.opt

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath
    }
  )
end

vim.opt.rtp:prepend(lazypath)
require("mappings")
require("extras")


-- Think about using lbr (:h lbr)

-- Table for global variables
vim.g.vimsyn_embed = "l"
local o_options = {
  mouse = "a",
  inccommand = "split",
  termguicolors = true,
  wildmenu = true,
  colorcolumn = "80",
  number = true,
  -- 7 lines up and down of limit to the cursor
  so = 7,
  cursorcolumn = true,
  cursorline = true,
  ruler = true,
  cmdheight = 0,
  backspace = "eol,start,indent",
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
  clipboard = "unnamedplus",
  -- formatprg = "par\\ -rjw79",
  listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:↵,precedes:«,extends:»",
  hidden = true,
  guifont = "Iosevka Nerd Font Mono:h14",
  exrc = true, -- allow local config files
  -- lazyredraw = true, -- don't update screen when doing macros
  conceallevel = 2 -- needed for obsidian
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
vim.cmd(
  [[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=2
  set foldopen=block,hor,mark,percent,quickfix,tag
]]
)
-- Undofiles
vim.cmd([[
  set undodir=~/.config/nvim/undodir
  set undofile
]])
-- TODO: consider using the following
-- NOTE: probably won't support windows kek
-- if has('win32') || has ('win64')
--     let $VIMHOME = $VIM."/vimfiles"
-- else
--     let $VIMHOME = $HOME."/.vim"
-- endif

-- Exception for Makefiles
vim.cmd([[autocmd FileType make set nosmarttab]])

-- Relative number doings
-- vim.cmd([[set number relativenumber]])
-- map_toggle_settings("number", "relativenumber")
-- completion helper
vim.cmd([[
  set shortmess+=c
]])

local relnums = vim.api.nvim_create_augroup("RelativeNumbers", {clear = true})
vim.api.nvim_create_autocmd("BufEnter", {pattern = "*", command = "set relativenumber", group = relnums})
vim.api.nvim_create_autocmd("FocusGained", {pattern = "*", command = "set relativenumber", group = relnums})
vim.api.nvim_create_autocmd("InsertLeave", {pattern = "*", command = "set relativenumber", group = relnums})
vim.api.nvim_create_autocmd("BufLeave", {pattern = "*", command = "set norelativenumber", group = relnums})
vim.api.nvim_create_autocmd("FocusLost", {pattern = "*", command = "set norelativenumber", group = relnums})
vim.api.nvim_create_autocmd("InsertEnter", {pattern = "*", command = "set norelativenumber", group = relnums})

local backtofile = vim.api.nvim_create_augroup("Back2File", {clear = true})
vim.api.nvim_create_autocmd(
  "BufReadPost",
  {
    pattern = "*",
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
    group = backtofile
  }
)
require("packages")

-- ftplugin for zk
vim.cmd("filetype plugin on")

-- require('plugins')
-- require("statusline")
-- require("lsp")
