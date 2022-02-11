local set = vim.keymap.set

set('n', '<F5>',        function () require('dap').continue() end,                                                   { silent=true })
set('n', '<F10>',       function() require('dap').step_over() end,                                                   { silent=true })
set('n', '<F11>',       function() require('dap').step_into() end,                                                   { silent=true })
set('n', '<F12>',       function() require('dap').step_out() end,                                                    { silent=true })
set('n', '<leader>db',  function() require('dap').toggle_breakpoint() end,                                           { silent=true })
set('n', '<leader>dB',  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,        { silent=true })
set('n', '<leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { silent=true })
set('n', '<leader>dr',  function() require('dap').repl.open() end,                                                   { silent=true })
set('n', '<leader>dl',  function() require('dap').run_last() end,                                                    { silent=true })
set('v', '<leader>dps', function() require('dap-python').debug_selection() end,                                      { silent=true })
