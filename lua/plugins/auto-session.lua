return {
  "rmagatti/auto-session",
  enabled = false,
  dependencies = {"rmagatti/session-lens"},
  config = function()
    vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
    require('auto-session').setup()
  end
}
