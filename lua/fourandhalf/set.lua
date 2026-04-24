vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.autoread = true

vim.opt.colorcolumn = "80"

local external_change_reload_group = vim.api.nvim_create_augroup("ExternalFileChangeReload", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = external_change_reload_group,
  pattern = "*",
  command = "checktime",
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = external_change_reload_group,
  pattern = "*",
  callback = function()
    vim.notify("File reloaded: changed outside Neovim", vim.log.levels.INFO)
  end,
})


-- Diagnostics Config
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },

  virtual_text = {
    prefix = "● ",
    source = "if_many",
  },

  float = {
    border = "rounded",
  },

  update_in_insert = false,
  severity_sort = true,
})
