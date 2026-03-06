require("trouble").setup({
  icons = true,
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})

-- Keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble toggle<cr>",
  {silent = true, desc = "Toggle Trouble"}
)
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble toggle workspace_diagnostics<cr>",
  {ilent = true, desc = "Workspace Diagnostics"}
)
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble toggle document_diagnostics<cr>",
  {silent = true, desc = "Document Diagnostics"}
)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble toggle loclist<cr>",
  {silent = true, desc = "Loclist"}
)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble toggle quickfix<cr>",
  {silent = true, desc = "Quickfix"}
)
vim.keymap.set("n", "gR", "<cmd>Trouble toggle lsp_references<cr>",
  {silent = true, desc = "LSP References"}
)
