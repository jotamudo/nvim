local nnoremap = require('astronauta.keymap').nnoremap
local vnoremap = require('astronauta.keymap').vnoremap

nnoremap { '<F5>',        function () require('dap').continue() end,                                                   silent=true }
nnoremap { '<F10>',       function() require('dap').step_over() end,                                                   silent=true }
nnoremap { '<F11>',       function() require('dap').step_into() end,                                                   silent=true }
nnoremap { '<F12>',       function() require('dap').step_out() end,                                                    silent=true }
nnoremap { '<leader>db',  function() require('dap').toggle_breakpoint() end,                                           silent=true }
nnoremap { '<leader>dB',  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,        silent=true }
nnoremap { '<leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, silent=true }
nnoremap { '<leader>dr',  function() require('dap').repl.open() end,                                                   silent=true }
nnoremap { '<leader>dl',  function() require('dap').run_last() end,                                                    silent=true }
vnoremap { '<leader>dps', function() require('dap-python').debug_selection() end,                                      silent=true }
