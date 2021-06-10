vim.o.completeopt = 'menuone,noselect'
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    nvim_lsp = true,
    ultisnips = true,
    vsnip = true,
    path = true,
    buffer = true,
    spell = true,
    emoji = true,
    calc = true,
    nvim_lua = true,
    -- treesitter = true,
  },
}
