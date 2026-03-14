
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    local git_root = utils.get_git_root and utils.get_git_root() or vim.loop.cwd()

    builtin.live_grep({
        additional_args = function()
            return {"--hidden", "--no-ignore", "--smart-case"}
        end,
        cwd = git_root,
        prompt_title = "Grep (Project)"
    })
end)
vim.keymap.set('n', '<leader>pc', function()
  builtin.current_buffer_fuzzy_find({
    prompt_title = "Search Current File",
    previewer = false,
  })
end)

-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
