local packer = require("packer")

packer.startup{
  function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}

    -- Improve startup time
    use 'lewis6991/impatient.nvim'
    -- Utils for configs
    use "norcalli/nvim_utils"

    -- Formatter
    use "mhartington/formatter.nvim"

    -- Override default vim.ui.select
    use {
      "hood/popui.nvim",
      requires= "RishabhRD/popfix",
      config = function()
        vim.ui.select = require"popui.ui-overrider"
      end
    }

    -- Lsp and autocompletion stuff
    use "neovim/nvim-lspconfig"
    use "anott03/nvim-lspinstall"
    use "nvim-lua/lsp-status.nvim"
    use "j-hui/fidget.nvim"
    use "tami5/lspsaga.nvim"
    use {"RishabhRD/nvim-lsputils", requires = "RishabhRD/popfix"}
    use "onsails/lspkind-nvim"
    use "jubnzv/virtual-types.nvim"
    -- signature hint when typing
    use "ray-x/lsp_signature.nvim"
    -- autocompletion
    use "hrsh7th/nvim-cmp"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-emoji'
    use 'hrsh7th/cmp-nvim-lua'
    -- use 'quangnguyen30192/cmp-nvim-ultisnips'

    -- language specific plugins
    use 'p00f/clangd_extensions.nvim'
    use 'simrat39/rust-tools.nvim'

    -- code refactoring
    use {
      "ThePrimeagen/refactoring.nvim", requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
      }
    }

    -- spell checking
    use {
      'f3fora/cmp-nuspell',
      rocks={'lua-nuspell'}
    }



    -- Lua helpers
    use "folke/lua-dev.nvim"

    -- Snippets and engines
    -- use "norcalli/snippets.nvim"
    -- use "hrsh7th/vim-vsnip"
    -- use "hrsh7th/vim-vsnip-integ"
    -- Extra snippets for vsnip
    -- use "rafamadriz/friendly-snippets"

    -- use {"SirVer/ultisnips", requires = "honza/vim-snippets"}
    use { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets', 'honza/vim-snippets' } }

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter"
    -- super useful to make own targets like ip (inner paragraph)
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Fuzzy Finder
    use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"},
    -- {"nvim-lua/plenary.nvim"}
  }}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Playing with registers
    -- use "gennaro-tedesco/nvim-peekup"

    -- Markdown
    -- use "davidgranstrom/nvim-markdown-preview"
    use {'iamcco/markdown-preview.nvim', run={'cd app && yarn install'}}
    use "gabrielelana/vim-markdown"
    use "vim-pandoc/vim-pandoc"
    use "vim-pandoc/vim-pandoc-syntax"
    -- use {"shime/vim-livedown", run = {"npm install -g livedown"}}

    -- Latex
    use "lervag/vimtex"
    use {"KeitaNakamura/tex-conceal.vim", ft = "tex"}

    -- Notes with neuron
    use {"oberblastmeister/neuron.nvim", requires = "nvim-lua/popup.nvim"}

    -- Colorscheme
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- Debugging :TODO: consider vimspector
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "mfussenegger/nvim-dap-python"
    use "szw/vim-maximizer" -- Maximizing windows

    -- Lua
    -- use "bfredl/nvim-luadev"
    -- use "tjdevries/vlog.nvim"
    -- use "tjdevries/manillua.nvim"
    -- lua scratchpads
    use "rafcamlet/nvim-luapad"

    -- Buffer Line
    use "romgrk/barbar.nvim"

    -- TODO: Status Line
    use "SmiteshP/nvim-gps"
    use "feline-nvim/feline.nvim"
    -- just in case
    use "ryanoasis/vim-devicons"

    -- Indentation
    -- use 'glepnir/indent-guides.nvim'
    use "lukas-reineke/indent-blankline.nvim"

    -- File Tree
    use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}}
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }

    use 'nvim-lua/plenary.nvim'

    -- Git integration
    -- test these
    use {
      "TimUntersberger/neogit",
      requires = {
        --"nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim"
      },
    }
    use "f-person/git-blame.nvim"
    -- use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}}
    -- safe fallback
    -- use 'airblade/vim-gitgutter'
    -- use 'tpope/vim-fugitive'
    -- maybe using this?
    -- use 'f-person/git-blame.nvim'

    -- Json cool integration
    use "gennaro-tedesco/nvim-jqx"

    -- Comments
    use 'numToStr/Comment.nvim'

    -- use 'gennaro-tedesco/nvim-commaround'

    -- Dot repeater
    use "tpope/vim-repeat"

    -- Surround
    use "tpope/vim-surround"

    -- Collaborative editing
    -- use "jbyuki/instant.nvim"

    -- Playing with motion
    -- use "tjdevries/train.nvim"

    -- Github Issues and PRs
    use "pwntester/octo.nvim"

    -- Auto Pairs
    -- use "cohama/lexima.vim"
    use "windwp/nvim-autopairs"
    use "andymass/vim-matchup"

    -- Scratchpads
    use "metakirby5/codi.vim"

    -- code runners
    use {
      "michaelb/sniprun",
      run = { 'bash install.sh' }
    }
    use "jubnzv/mdeval.nvim"
    use "scott-astatine/Executer.nvim"

    -- Making modes
    use "Iron-E/nvim-libmodal"

    --web stuff
    use "mattn/emmet-vim"

    -- Project Management, consider nvpm
    -- use 'windwp/nvim-projectconfig'
    -- TODO and such for exploring
    use {
      "folke/todo-comments.nvim",
      -- requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end
    }
    use "rmagatti/auto-session" -- session management
    use "rmagatti/session-lens" -- searching sessions with telescope

    -- Colorizer
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }

    -- ASCII diagrams
    -- use "jbyuki/venn.nvim"

    -- Life management
    -- use "vimwiki/vimwiki" -- zettelkasten
    use "mickael-menu/zk-nvim" -- zettelkasten
    use "dkarter/bullets.vim" -- markdown goodies
    use {
      "brymer-meneses/grammar-guard.nvim",
      requires = {
      "neovim/nvim-lspconfig",
      "williamboman/nvim-lsp-installer"
      }
    }
    use "jbyuki/nabla.nvim" -- view equations
    use 'ekickx/clipboard-image.nvim'
      -- Telekasten
    -- use "itchyny/calendar.vim" --scheduling
    use "renerocksai/calendar-vim" -- fork with fixed week calculations
    use "nvim-telescope/telescope-media-files.nvim"
    use "nvim-telescope/telescope-symbols.nvim"
    use "mzlogin/vim-markdown-toc"
    use {
      "renerocksai/telekasten.nvim",
      requires = {
        "nvim-telescope/telescope.nvim",
        -- "nvim-lua/plenary.nvim"
      },
    }
      -- org-mode
    --use "nvim-orgmode/orgmode"
    --use "akinsho/org-bullets.nvim"
    use "lukas-reineke/headlines.nvim" -- general highlighting of headlines
    --use "dhruvasagar/vim-table-mode" -- table support
      -- neorg
    --use "nvim-neorg/neorg"

    --notifications
    use "rcarriga/nvim-notify"

    -- quality of life improvements
    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

  end
,
config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
  }
}
