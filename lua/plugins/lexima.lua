vim.cmd([[
    let g:lexima_enable_default_rules = 1
    let g:lexima_enable_newline_rules = 1
    call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
    call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
    call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})
]])
