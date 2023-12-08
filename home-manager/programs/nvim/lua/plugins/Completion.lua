return {
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = { "InsertEnter", "CmdlineEnter" },
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "f3fora/cmp-spell",
            "saadparwaiz1/cmp_luasnip",
            "amarakon/nvim-cmp-buffer-lines",
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
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                },

                experimental = {
                    ghost_text = false -- this feature conflict with copilot.vim's preview.
                },
                sources = cmp.config.sources({
                        { name = 'nvim_lua' },
                        { name = "nvim_lsp" },
                        { name = "luasnip" }, -- For luasnip users.
                        { name = "nvim_lsp_signature_help" },
                        -- { name = "treesitter" },
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
