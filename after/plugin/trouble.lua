-- Basic setup
require("trouble").setup({
  position = "bottom", -- or "top", "left", "right"
  height = 10,
  icons = true,
  mode = "workspace_diagnostics", -- "document_diagnostics", "quickfix", "lsp_references", etc
  fold_open = "",
  fold_closed = "",
  group = true,
  padding = true,
  action_keys = {
    close = "q",
    cancel = "<esc>",
    refresh = "r",
    jump = { "<cr>", "<tab>" },
    toggle_mode = "m",
    toggle_preview = "P",
    hover = "K",
    preview = "p",
    close_folds = "zM",
    open_folds = "zR",
    toggle_fold = "za",
  },
  auto_open = false,
  auto_close = true,
  auto_preview = true,
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
  use_diagnostic_signs = true,
})

