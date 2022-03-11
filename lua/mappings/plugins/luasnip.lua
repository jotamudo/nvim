local set = vim.keymap.set
local ls = require('luasnip')

-- change tipe of choice nodes
set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- go back to last snippet or last position on snippet
set("i", "<c-k>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)


set("i", "<c-j>", function ()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end)

