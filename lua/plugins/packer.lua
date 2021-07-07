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
    use "hrsh7th/nvim-compe"
    use "nvim-lua/lsp-status.nvim"
    use "glepnir/lspsaga.nvim"
    use {"RishabhRD/nvim-lsputils", requires = "RishabhRD/popfix"}
    -- eye candy :3
    -- use 'kosayoda/nvim-lightbulb'
    use "onsails/lspkind-nvim"
    use "jubnzv/virtual-types.nvim"
    -- signature hint when typing
    use "ray-x/lsp_signature.nvim"

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
    use {"nvim-telescope/telescope.nvim", requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}}

    -- Playing with registers
    -- use "gennaro-tedesco/nvim-peekup"

    -- Markdown
    use "davidgranstrom/nvim-markdown-preview"
    use "gabrielelana/vim-markdown"
    use "vim-pandoc/vim-pandoc"
    use "vim-pandoc/vim-pandoc-syntax"
    use {"shime/vim-livedown", run = {"npm install -g livedonw"}}
    -- use {'iamcco/markdown-preview.nvim', run={'cd app && yarn install'}}

    -- Latex
    use "lervag/vimtex"
    use {"KeitaNakamura/tex-conceal.vim", ft = "tex"}

    -- Notes with neuron
    -- use "oberblastmeister/neuron.nvim"

    -- Colorscheme
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    -- Debugging :TODO: consider vimspector
    use "mfussenegger/nvim-dap"

    -- Lua
    -- use "bfredl/nvim-luadev"
    -- use "tjdevries/vlog.nvim"
    -- use "tjdevries/manillua.nvim"
    -- lua scratchpads
    use "rafcamlet/nvim-luapad"

    -- Buffer Line
    use "romgrk/barbar.nvim"

    -- Status Line
    -- lualine is easier to configure than galaxy-line, but the rice...
    -- use 'hoob3rt/lualine.nvim'
    use {
      "glepnir/galaxyline.nvim",
      branch = "main",
      -- your statusline
      config = function()
        require "statusline"
      end,
      -- some optional icons
      requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }
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

    -- Git integration
    -- test these
    use "TimUntersberger/neogit"
    use "f-person/git-blame.nvim"
    use {"lewis6991/gitsigns.nvim", requires = {"nvim-lua/plenary.nvim"}}
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
    use "tpope/vim-commentary"
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
    use "cohama/lexima.vim"
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
      requires = "nvim-lua/plenary.nvim",
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
