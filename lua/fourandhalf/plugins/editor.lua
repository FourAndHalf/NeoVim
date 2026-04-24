return {
    {
        "theprimeagen/harpoon",
        config = function()

            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)


        end
    },
    {
        "mbbill/undotree",
        config = function()

            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{}


        end
    },
    { "kylechui/nvim-surround", version = "*", config = function() require("nvim-surround").setup({}) end },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = function() require("ibl").setup() end },
    { "mfussenegger/nvim-lint", config = function() require("lint").linters_by_ft = {} end },
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },
    { "akinsho/toggleterm.nvim", version = "*", config = function() require("toggleterm").setup() end },
    { "folke/which-key.nvim", config = function() vim.o.timeout = true; vim.o.timeoutlen = 300; require("which-key").setup() end }
}
