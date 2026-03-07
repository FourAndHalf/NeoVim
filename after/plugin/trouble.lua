require("trouble").setup()

-- Keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble toggle<cr>",
  { silent = true, desc = "Toggle Trouble" }
)

vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>",
  { silent = true, desc = "Workspace Diagnostics" }
)

vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { silent = true, desc = "Document Diagnostics" }
)

vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",
  { silent = true, desc = "Location List" }
)

vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",
  { silent = true, desc = "Quickfix List" }
)

vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references toggle<cr>",
  { silent = true, desc = "LSP References" }
)
