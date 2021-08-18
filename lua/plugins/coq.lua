vim.g.coq_settings = {
  ['autostart'] = true,
  ['keymap.recommended'] = false,
  ['keymap.jump_to_mark'] = "\<c-j>"
}
vim.cmd[[
  let g:coq_settings = {"keymap.jump_to_mark" = '<c-j>'}
]]
