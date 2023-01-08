return {
  { '<F5>', function() require('dap').continue() end },
  { '<F10>', function() require('dap').step_over() end },
  { '<F11>', function() require('dap').step_into() end },
  { '<F12>', function() require('dap').step_out() end },
  { '<leader>db', function() require('dap').toggle_breakpoint() end },
  { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, },
  { '<leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
  { '<leader>dr', function() require('dap').repl.open() end, },
  { '<leader>dl', function() require('dap').run_last() end },
  { '<leader>dps', function() require('dap-python').debug_selection() end, mode = "v" }
}
