return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-media-files.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            local telescope = require('telescope')

            -- Setup telescope to use media_files extension
            telescope.setup({
                defaults = {
                    path_display = { "truncate " },
                    mappings = {
                        i = {
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
                        },
                    },
                },
                extensions = {
                    media_files = {
                        -- filetypes whitelist
                        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                        filetypes = {"png", "webp", "jpg", "jpeg", "pdf", "mkv", "mp4", "webm"},
                        find_cmd = "rg" -- find command (defaults to `fd`)
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })

            -- Load extensions
            telescope.load_extension('media_files')
            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')
            telescope.load_extension('notify')
            telescope.load_extension('harpoon')

            local builtin = require('telescope.builtin')
            local utils = require('telescope.utils')

            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                local git_root = vim.fs.root(0, ".git") or vim.loop.cwd()

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
            vim.keymap.set('n', '<leader>pn', telescope.extensions.notify.notify, { desc = "Search Notifications" })


        end
    }
}
