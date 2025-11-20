return {
    { 'szw/vim-maximizer' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    -- hangs on sshfs for some misterious reason?
    -- {
    --     'andymass/vim-matchup',
    --     lazy = false,
    --     opts = {
    --         treesitter = {
    --             stopline = 500,
    --         },
    --     },
    -- },
    { 'itchyny/calendar.vim' },
    {
        'samoshkin/vim-mergetool',
        config = function()
            vim.g.mergetool_layout = 'mr'
            vim.g.mergetool_prefer_revision = 'local'
        end,
    },
    { 'gennaro-tedesco/nvim-jqx' },
    { 'normen/vim-pio' },
}
