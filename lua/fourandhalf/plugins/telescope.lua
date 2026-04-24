return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-media-files.nvim"
        },
        config = function()
            local telescope = require('telescope')

            -- Setup telescope to use media_files extension
            telescope.setup({
                extensions = {
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        filetypes = {"png", "webp", "jpg", "jpeg", "pdf", "mkv", "mp4", "webm"},
                        find_cmd = "rg" -- find command (defaults to `fd`)
                    }
                }
            })

            -- Load the extension
            telescope.load_extension('media_files')

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

            -- Keymap to search specifically for media files
            vim.keymap.set('n', '<leader>pm', telescope.extensions.media_files.media_files, { desc = "Find media files" })

        end
    }
}
