return {
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            -- lock compat to tagged versions, if you've also locked blink.cmp to tagged versions
            { 'saghen/blink.compat', version = '*', opts = { impersonate_nvim_cmp = true } }
        },
        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = {
                preset = 'default',
                ['<c-k>'] = { 'select_prev', 'fallback' },
                ['<c-j>'] = { 'select_next', 'fallback' },
                ['<c-l>'] = { 'snippet_forward', 'fallback' },
                ['<c-h>'] = { 'snippet_backward', 'fallback' },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },
            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                completion = {
                    enabled_providers = { 'luasnip', 'lsp', 'path', 'snippets', 'buffer' },
                },
                providers = {
                    luasnip = {
                        name = 'luasnip',
                        module = 'blink.compat.source',

                        score_offset = -3,

                        opts = {
                            use_show_condition = false,
                            show_autosnippets = true,
                        },
                    },
                },
            },

            -- experimental auto-brackets support
            -- completion = { accept = { auto_brackets = { enabled = true } } }

            -- experimental signature help support
            signature = { enabled = true }
        },
        -- allows extending the enabled_providers array elsewhere in your config
        -- without having to redefine it
        -- opts_extend = { "sources.completion.enabled_providers" }
    },
    {
        "max397574/care.nvim",

        enabled = false,
        dependencies = {
            "max397574/care-cmp",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
        },
        opts = {
            ui = {
                ghost_text = {
                    enabled = false,
                    position = "overlay",
                },
            },
            snippet_expansion = function(body)
                require("luasnip").lsp_expand(body)
            end,
        },
        config = function(_, opts)
            require("care").setup(opts)
            require("luasnip.loaders.from_vscode").lazy_load()

            vim.keymap.set({ "i", "s" }, "<c-l>", function()
                vim.snippet.jump(1)
            end)
            vim.keymap.set({ "i", "s" }, "<c-h>", function()
                vim.snippet.jump(-1)
            end)
            vim.keymap.set({ "i", }, "<c-space>", function()
                require("care").api.complete()
            end)

            vim.keymap.set({ "i" }, "<c-y>", "<Plug>(CareConfirm)")


            vim.keymap.set({ "i" }, "<c-e>", "<Plug>(CareClose)")

            vim.keymap.set({ "i" }, "<c-j>", "<Plug>(CareSelectNext)")
            vim.keymap.set({ "i" }, "<c-k>", "<Plug>(CareSelectPrev)")
            vim.keymap.set({ "i" }, "<c-f>", function()
                if require("care").api.doc_is_open() then
                    require("care").api.scroll_docs(4)
                else
                    vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
                end
            end)

            vim.keymap.set({ "i" }, "<c-d>", function()
                if require("care").api.doc_is_open() then
                    require("care").api.scroll_docs(-4)
                else
                    vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
                end
            end)
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        -- "yioneko/nvim-cmp",
        -- branch = "perf",
        enabled = false,
        -- load cmp on InsertEnter
        event = { "InsertEnter", "CmdlineEnter" },
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "f3fora/cmp-spell",
            "amarakon/nvim-cmp-buffer-lines",
            "ray-x/cmp-treesitter",
            {
                "roobert/tailwindcss-colorizer-cmp.nvim",
                opts = { color_square_width = 2 }
            },
            "onsails/lspkind-nvim",
        },
        config = function()
            -- local types = require("cmp.types")
            -- local str = require("cmp.utils.str")
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            cmp.setup({
                -- sorting= {
                --
                -- },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 60,
                        ellipsis_char = "...",
                        -- menu = {
                        --     -- buffer = '',
                        --     -- nvim_lsp = ' ',
                        --     -- luasnip = ' 🐍',
                        --     treesitter = ' 󱘎 ',
                        --     -- nvim_lua = ' ',
                        --     -- spell = '󰓆',
                        --     -- emoji = '󰞅',
                        --     -- latex_symbols = '󰿉',
                        --     -- copilot = '🤖',
                        --     -- cmp_tabnine = '🤖',
                        --     -- look = '',
                        -- },
                        -- before = function(entry, vim_item)
                        -- local item = entry:get_completion_item()
                        --     log.debug(item)
                        -- if item.detail then vim_item.menu = item.detail end
                        -- return vim_item
                        -- end
                        before = function(entry, vim_item)
                            vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                            return vim_item
                        end
                    }),
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                },

                experimental = {
                    ghost_text = false -- this feature conflict with copilot.vim's preview.
                },
                sources = cmp.config.sources({
                        { name = 'nvim_lua',               max_item_count = 10 },
                        { name = "nvim_lsp",               max_item_count = 30 },
                        { name = "luasnip" }, -- For luasnip users.
                        { name = "nvim_lsp_signature_help" },
                        { name = "treesitter",             max_item_count = 10 },
                        {
                            name = "spell",
                            option = {
                                keep_all_entries = true,
                                enable_in_context = function()
                                    return require("cmp.config.context").in_treesitter_capture("spell")
                                end,
                            },
                        },

                        { name = "path", max_item_count = 10 },
                    },
                    {
                        {
                            name = "buffer",
                            option = {
                                get_bufnrs = function()
                                    return vim.api.nvim_list_bufs()
                                end
                            }
                        },
                        {
                            name = "buffer-lines",
                            option = {
                                line_numbers = false,
                                line_number_separator = ": ",
                            },
                            max_item_count = 3
                        },
                    })
            })

            cmp.setup.filetype("norg", {
                sources = cmp.config.sources({
                    { name = "neorg" }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = "buffer" },
                })
            })


            cmp.setup.cmdline({ "/", "?" }, {
                completion = {
                    autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
                },
                mapping = {

                    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "c" }),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "c" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = {
                    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "c" }),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                        { "c" }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                    { name = "buffer" },
                }),
            })
        end
    },


}
