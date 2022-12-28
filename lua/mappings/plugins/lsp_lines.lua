local set = vim.keymap.set;

set(
  "",
  "<Leader>l",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)
