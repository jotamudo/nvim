let s:pairs={
            \'<': '>',
            \'{': '}',
            \'[': ']',
            \'(': ')',
            \'«': '»',
            \'„': '“',
            \'“': '”',
            \'‘': '’',
        \}
call map(copy(s:pairs), 'extend(s:pairs, {v:val : v:key}, "keep")')
function! InsertPair(left, ...)
        let rlist=reverse(map(split(a:left, '\zs'), 'get(s:pairs, v:val, v:val)'))
        let opts=get(a:000, 0, {})
        let start   = get(opts, 'start',   '')
        let lmiddle = get(opts, 'lmiddle', '')
        let rmiddle = get(opts, 'rmiddle', '')
        let end     = get(opts, 'end',     '')
        let prefix  = get(opts, 'prefix',  '')
        let start.=prefix
        let rmiddle.=prefix
        let left=start.a:left.lmiddle
        let right=rmiddle.join(rlist, '').end
        let moves=repeat("\<Left>", len(split(right, '\zs')))
        return left.right.moves
        endfunction
        noremap! <expr> ,f   InsertPair('{')
        noremap! <expr> ,h   InsertPair('[')
        noremap! <expr> ,s   InsertPair('(')
        noremap! <expr> ,u   InsertPair('<')

        inoremap {<CR> {<C-o>o}<C-o>O
