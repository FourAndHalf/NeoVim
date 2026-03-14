return {
    "nvim-tree/nvim-web-devicons",
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function() vim.cmd("colorscheme catppuccin") end },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
                        function ColorMyPencil(color)
                            color = color or "rose-pine"
                            vim.cmd.colorscheme(color)
                            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                        end
                        ColorMyPencil()
        end
    },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("lualine").setup() end },
    { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", config = function() require("bufferline").setup{} end },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            { "rcarriga/nvim-notify", config = function() require("notify").setup({ timeout = 2000 }) end },
        }
    }
}
