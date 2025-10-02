local lsp = require("lsp-zero")

-- Optional: recommended LSP settings
lsp.extend_lspconfig()

-- Initialize mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'rust_analyzer', 'cssls', 'html', 'lua_ls', 'gopls' },
  handlers = {
    lsp.default_setup,
  }
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
        },
    },
})

-- (Optional) Setup preferences
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = '✘',
    warn  = '▲',
    hint  = '⚑',
    info  = '»'
  }
})

lsp.setup()

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
end

lsp.on_attach(on_attach)

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

