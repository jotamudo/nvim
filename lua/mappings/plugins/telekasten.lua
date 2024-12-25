return {
    -- On hesitation, bring up the command panel
    {
        '<leader>z',
        function()
            require('telekasten').panel()
        end,
    },

    -- Function mappings
    {
        '<leader>zf',
        function()
            require('telekasten').find_notes()
        end,
    },
    {
        '<leader>zd',
        function()
            require('telekasten').find_daily_notes()
        end,
    },
    {
        '<leader>zg',
        function()
            require('telekasten').search_notes()
        end,
    },
    {
        '<leader>zz',
        function()
            require('telekasten').follow_link()
        end,
    },
    {
        '<leader>zT',
        function()
            require('telekasten').goto_today()
        end,
    },
    {
        '<leader>zW',
        function()
            require('telekasten').goto_thisweek()
        end,
    },
    {
        '<leader>zw',
        function()
            require('telekasten').find_weekly_notes()
        end,
    },
    {
        '<leader>zn',
        function()
            require('telekasten').new_note()
        end,
    },
    {
        '<leader>zN',
        function()
            require('telekasten').new_templated_note()
        end,
    },
    {
        '<leader>zy',
        function()
            require('telekasten').yank_notelink()
        end,
    },
    {
        '<leader>zc',
        function()
            require('telekasten').show_calendar()
        end,
    },
    { '<leader>zC', '<cmd>:CalendarT<CR>' },
    {
        '<leader>zi',
        function()
            require('telekasten').paste_img_and_link()
        end,
    },
    {
        '<leader>zt',
        function()
            require('telekasten').toggle_todo()
        end,
    },
    {
        '<leader>zb',
        function()
            require('telekasten').show_backlinks()
        end,
    },
    {
        '<leader>zF',
        function()
            require('telekasten').find_friends()
        end,
    },
    {
        '<leader>zI',
        function()
            require('telekasten').insert_img_link({ i = true })
        end,
    },
    {
        '<leader>zp',
        function()
            require('telekasten').preview_img()
        end,
    },
    {
        '<leader>zm',
        function()
            require('telekasten').browse_media()
        end,
    },
    {
        '<leader>za',
        function()
            require('telekasten').show_tags()
        end,
    },
    {
        '<leader>#',
        function()
            require('telekasten').show_tags()
        end,
    },
    {
        '<leader>zr',
        function()
            require('telekasten').rename_note()
        end,
    },

    -- we could define [[ in **insert mode** to call insert link
    -- inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
    -- alternatively: leader [
    -- set('i', '<leader>[', require('telekasten').insert_link({ i=true }))
    -- set('i', '<leader>zt', require('telekasten').toggle_todo({ i=true }))
    -- set('i', '<leader>#', require('telekasten').show_tags({i = true}))

    -- Search for urgent tag notes
    {
        '<leader>zU',
        function()
            require('telekasten').follow_link({ follow_tag = '#urgent' })
        end,
    },
}
