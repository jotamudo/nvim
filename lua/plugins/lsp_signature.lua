return {
  "ray-x/lsp_signature.nvim",
  config = function ()
    require('lsp_signature').setup({
      floating_window_above_cur_line = true
    })
  end
}
