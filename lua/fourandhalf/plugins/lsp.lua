return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local lsp = require("lsp-zero")
            local uv = vim.uv or vim.loop

            local function path_exists(path)
              return path and uv.fs_stat(path) ~= nil
            end

            local function get_python_path(root_dir)
              local venv = os.getenv("VIRTUAL_ENV")
              if venv and path_exists(venv .. "/bin/python") then
                return venv .. "/bin/python"
              end

              local conda = os.getenv("CONDA_PREFIX")
              if conda and path_exists(conda .. "/bin/python") then
                return conda .. "/bin/python"
              end

              if root_dir then
                for _, dir in ipairs({ ".venv", "venv", "env" }) do
                  local python = root_dir .. "/" .. dir .. "/bin/python"
                  if path_exists(python) then
                    return python
                  end
                end
              end

              return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3")
                or vim.fn.exepath("python")
            end

            -- Optional: recommended LSP settings
            lsp.extend_lspconfig()

            vim.lsp.config("pyright", {
              before_init = function(_, config)
                config.settings = config.settings or {}
                config.settings.python = config.settings.python or {}
                config.settings.python.pythonPath = get_python_path(config.root_dir)
              end,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                  },
                },
              },
            })

            -- Initialize mason
            require('mason').setup({})
            require('mason-lspconfig').setup({
              ensure_installed = { 'rust_analyzer', 'cssls', 'html', 'lua_ls', 'gopls', 'pyright' },
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

        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            require("luasnip.loaders.from_vscode").lazy_load() -- load snippets if you have any

            cmp.setup({
              snippet = {
                expand = function(args)
                  luasnip.lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
              })
            })

            -- DAP completion
            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
              sources = {
                { name = "dap" },
              },
            })


        end
    },
    {
        "onsails/lspkind.nvim",
        config = function()
            require('lspkind').init({
              mode = 'symbol_text',
              preset = 'codicons',
              symbol_map = {
                Text = "", Method = "", Function = "", Constructor = "",
                Field = "", Variable = "", Class = "", Interface = "",
                Module = "", Property = "", Unit = "", Value = "",
                Enum = "", Keyword = "", Snippet = "", Color = "",
                File = "", Reference = "", Folder = "", EnumMember = "",
                Constant = "", Struct = "", Event = "", Operator = "",
                TypeParameter = ""
              },
            })


        end
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({
                modes = {
                    diagnostics = {
                        filter = {
                            severity = {
                                vim.diagnostic.severity.ERROR,
                                vim.diagnostic.severity.WARN,
                            },
                        },
                    },
                },
            })

            -- Keymaps
            vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              { silent = true, desc = "Document Diagnostics" }
            )

            vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>",
              { silent = true, desc = "Workspace Diagnostics" }
            )

            vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              { silent = true, desc = "Document Diagnostics" }
            )

            vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",
              { silent = true, desc = "Location List" }
            )

            vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",
              { silent = true, desc = "Quickfix List" }
            )

            vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references toggle<cr>",
              { silent = true, desc = "LSP References" }
            )

        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

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

             vim.keymap.set('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

        end
    },
    { "rafamadriz/friendly-snippets" }
}
