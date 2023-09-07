return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require('indent_blankline').setup({
      show_current_context = true,
      show_current_context_start = true
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
      pattern = "*",
      callback = function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
        if file_size > 256 * 1024 then
          require("indent_blankline.commands").disable()
        end
      end,
    })
  end,
}
