" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/j_mudo/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/j_mudo/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/j_mudo/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/j_mudo/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/j_mudo/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["calendar.vim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/calendar.vim"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/codi.vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\1\2*\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\15statusline\frequire\0" },
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["git-blame.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/git-blame.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/gruvbox.nvim"
  },
  ["instant.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/instant.nvim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lexima.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  ["manillua.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/manillua.nvim"
  },
  neogit = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/neogit"
  },
  ["neuron.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/neuron.nvim"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-jqx"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-jqx"
  },
  ["nvim-libmodal"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-libmodal"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-lsputils"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-luadev"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-luapad"
  },
  ["nvim-markdown-preview"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-markdown-preview"
  },
  ["nvim-peekup"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-peekup"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  nvim_utils = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/nvim_utils"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  popfix = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/popfix"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tex-conceal.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/opt/tex-conceal.vim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\1\2?\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["train.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/train.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\1\0029\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["venn.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/venn.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-livedown"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-livedown"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-markdown"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-pandoc"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-pandoc"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  vimtex = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vimtex"
  },
  vimwiki = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["virtual-types.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/virtual-types.nvim"
  },
  ["vlog.nvim"] = {
    loaded = true,
    path = "/home/j_mudo/.local/share/nvim/site/pack/packer/start/vlog.nvim"
  }
}

time("Defining packer_plugins", false)
-- Config for: galaxyline.nvim
time("Config for galaxyline.nvim", true)
try_loadstring("\27LJ\1\2*\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\15statusline\frequire\0", "config", "galaxyline.nvim")
time("Config for galaxyline.nvim", false)
-- Config for: trouble.nvim
time("Config for trouble.nvim", true)
try_loadstring("\27LJ\1\0029\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time("Config for trouble.nvim", false)
-- Config for: todo-comments.nvim
time("Config for todo-comments.nvim", true)
try_loadstring("\27LJ\1\2?\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time("Config for todo-comments.nvim", false)
-- Config for: nvim-colorizer.lua
time("Config for nvim-colorizer.lua", true)
try_loadstring("\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time("Config for nvim-colorizer.lua", false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType tex ++once lua require("packer.load")({'tex-conceal.vim'}, { ft = "tex" }, _G.packer_plugins)]]
time("Defining lazy-load filetype autocommands", false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
