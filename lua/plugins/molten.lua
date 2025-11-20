return {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    lazy = false,
    build = ':UpdateRemotePlugins',
    cmd = 'MoltenInit',
    init = function()
        vim.g.molten_image_provider = 'image.nvim'
        vim.g.molten_output_win_max_height = 12
        vim.g.molten_virt_text_output = true
        vim.g.molten_virt_lines_off_by_1 = true
        vim.g.molten_virt_text_max_lines = 1
        vim.keymap.set(
            'n',
            '<leader>mi',
            ':MoltenInit<CR>',
            { silent = true, desc = 'Molten Init Kernel' }
        )
        vim.keymap.set(
            'n',
            '<leader>ml',
            ':MoltenEvaluateLine<CR>',
            { silent = true, desc = 'Molten Evaluate Line' }
        )
        vim.keymap.set(
            'v',
            '<leader>mv',
            ':<C-u>MoltenEvaluateVisual<CR>gv<ESC>',
            { silent = true, desc = 'Molten Evaluate Visual' }
        )
        vim.keymap.set(
            'n',
            '<leader>mh',
            ':MoltenHideOutput<CR>',
            { silent = true, desc = 'Molten Hide Output' }
        )
        vim.keymap.set(
            'n',
            '<leader>mo',
            ':noautocmd MoltenEnterOutput<CR>',
            { silent = true, desc = 'Molten Enter Output' }
        )
        vim.keymap.set(
            'n',
            '<localleader>rr',
            ':MoltenReevaluateCell<CR>',
            { silent = true, desc = 're-evaluate cell' }
        )
        vim.keymap.set('n', '<localleader>ip', function()
            local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
            if venv ~= nil then
                -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
                venv = string.match(venv, '/.+/(.+)')
                vim.cmd(('MoltenInit %s'):format(venv))
            else
                vim.cmd('MoltenInit python3')
            end
        end, { desc = 'Initialize Molten for python3', silent = true })
    end,
}
