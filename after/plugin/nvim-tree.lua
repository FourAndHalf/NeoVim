-- Recommended to disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Optional: better colors
vim.opt.termguicolors = true

-- Setup
 require("nvim-tree").setup({
   view = {
     side = "left",
     width = 30,
     preserve_window_proportions = true,
   },
   renderer = {
     highlight_git = true,
     icons = {
       show = {
         file = true,
         folder = true,
         folder_arrow = true,
         git = true,
       },
     },
   },
   git = {
     enable = true,
   },
 })

-- Keymap to toggle the tree
 vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

