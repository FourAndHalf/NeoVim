vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'nvim-tree/nvim-web-devicons'

    use({ 'rose-pine/neovim', as = 'rose-pine' })
    vim.cmd('colorscheme rose-pine')

    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('windwp/nvim-autopairs')

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "lua", "python", "javascript", "html", "css", "rust", "go" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
            }
        end,
    }

    use('nvim-treesitter/playground')
    use('onsails/lspkind.nvim')

    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons"
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- for file icons
        },
        config = function()
            require("nvim-tree").setup()
        end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use {
        'hrsh7th/nvim-cmp',     
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer', 
            'hrsh7th/cmp-path',  
            'hrsh7th/cmp-cmdline',       
            'saadparwaiz1/cmp_luasnip', 
        }
    }

end)

