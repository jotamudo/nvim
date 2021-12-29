local packer = require("packer")

packer.startup(
  function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}
    -- Utils for configs
    use "norcalli/nvim_utils"
    -- And quality of life inprovements :) 👌
    use "tjdevries/astronauta.nvim"

    -- Formatter
    use "mhartington/formatter.nvim"

    -- Lsp and autocompletion stuff
    use "neovim/nvim-lspconfig"
    use "anott03/nvim-lspinstall"
    use "nvim-lua/lsp-status.nvim"
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
    use 'hrsh7th/cmp-vsnip'
    use 'quangnguyen30192/cmp-nvim-ultisnips'


    -- Lua helpers
    use "folke/lua-dev.nvim"

    -- Snippets and engines
    use "norcalli/snippets.nvim"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    use {"SirVer/ultisnips", requires = "honza/vim-snippets"}
    -- Extra snippets for vsnip
    use "rafamadriz/friendly-snippets"

    -- Treesitter
    use "nvim-treesitter/nvim-treesitter"
    -- super useful to make own targets like ip (inner paragraph)
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Fuzzy Finder
    use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"}, 
    -- {"nvim-lua/plenary.nvim"}
  }}

    -- Playing with registers
    -- use "gennaro-tedesco/nvim-peekup"

    -- Markdown
    -- use "davidgranstrom/nvim-markdown-preview"
    use {'iamcco/markdown-preview.nvim', run={'cd app && yarn install'}}
    use "gabrielelana/vim-markdown"
    use "vim-pandoc/vim-pandoc"
    use "vim-pandoc/vim-pandoc-syntax"
    -- use {"shime/vim-livedown", run = {"npm install -g livedonw"}}

    -- Latex
    use "lervag/vimtex"
    use {"KeitaNakamura/tex-conceal.vim", ft = "tex"}

    -- Notes with neuron
    -- use "oberblastmeister/neuron.nvim"

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

    -- File Tree
    use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}}
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }

    use {'nvim-lua/plenary.nvim', commit = 'f1c783e133fcae77fd1a71fa9df95f991e2fa97a'}

    -- Git integration
    -- test these
    use {
      "TimUntersberger/neogit",
      requires = {
        --"nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim"
      },
      commit = '53772efc42263989d18d4a86c350b8b0e1f1b71b'
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
    -- TODO: Choose AAAAAAAAAAAAAAAAAAAA
    -- use 'b3nj5m1n/kommentary'
    -- use "tpope/vim-commentary"
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

    -- Making modes
    use "Iron-E/nvim-libmodal"

    --web stuff
    use "mattn/emmet-vim"

    -- Project Management consider nvpm
    -- use 'windwp/nvim-projectconfig'
    -- TODO and such for exploring
    use {
      "folke/todo-comments.nvim",
      -- requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end
    }

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
    use "itchyny/calendar.vim" --scheduling
    use "vimwiki/vimwiki" --notes

  end
)
