
local status_ok, gen = pcall(require, 'gen')
if not status_ok then
  return
end

-- Configure Gen.nvim for Ollama
gen.setup({
  model = 'http://localhost:11434/api/generate', -- Ollama endpoint
  display_mode = 'float', -- split | float | replace
  show_prompt = true,
  show_model = true,
})

-- Visual Mode Keybindings for Gen.nvim Actions
vim.keymap.set('v', '<leader>ge', ":lua require('gen').select_action()<CR>", { desc = "Gen: Select AI Action" })
vim.keymap.set('v', '<leader>gg', ":lua require('gen').run_action('Complete Code')<CR>", { desc = "Gen: Complete Code" })
vim.keymap.set('v', '<leader>gr', ":lua require('gen').run_action('Refactor')<CR>", { desc = "Gen: Refactor" })
vim.keymap.set('v', '<leader>gd', ":lua require('gen').run_action('Document')<CR>", { desc = "Gen: Document" })
vim.keymap.set('v', '<leader>gf', ":lua require('gen').run_action('Fix Code')<CR>", { desc = "Gen: Fix Code" })
vim.keymap.set('v', '<leader>gt', ":lua require('gen').run_action('Add Tests')<CR>", { desc = "Gen: Add Tests" })

-- Insert Mode Keybindings for inline AI completions
vim.keymap.set('i', '<C-g>c', "<Esc>:lua require('gen').run_action('Complete Code')<CR>i", { desc = "Gen: Inline Complete Code" })
vim.keymap.set('i', '<C-g>f', "<Esc>:lua require('gen').run_action('Fix Code')<CR>i", { desc = "Gen: Inline Fix Code" })


-- Normal Mode Keybinding to prompt Gen.nvim with custom input
vim.keymap.set('n', '<leader>gp', function()
  vim.ui.input({ prompt = 'Ask Codellama: ' }, function(prompt)
    if prompt and #prompt > 0 then
      require('gen').request(prompt)
    end
  end)
end, { desc = "Gen: Prompt Custom Question" })


