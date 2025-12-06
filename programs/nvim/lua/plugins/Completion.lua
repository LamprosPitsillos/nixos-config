return {
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = {
            { 'L3MON4D3/LuaSnip',       version = 'v2.*' },
            'rafamadriz/friendly-snippets',
            "nvim-tree/nvim-web-devicons",
            "onsails/lspkind.nvim",
            {
                "mikavilpas/blink-ripgrep.nvim",
                version = "*", -- use the latest stable version
            },
            { 'ribru17/blink-cmp-spell' },
            -- lock compat to tagged versions, if you've also locked blink.cmp to tagged versions
            -- { 'saghen/blink.compat', version = '*',   opts = { impersonate_nvim_cmp = true } }
        },
        -- use a release tag to download pre-built binaries
        version = '*',
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
                ['<c-space>'] = { 'show' },
                ['<c-d>'] = { 'show_documentation', 'hide_documentation' },
                ['<c-k>'] = { 'select_prev', 'fallback' },
                ['<c-j>'] = { 'select_next', 'fallback' },
                ['<c-l>'] = { 'snippet_forward', 'fallback' },
                ['<c-h>'] = { 'snippet_backward', 'fallback' },
            },

            appearance = {
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },
            snippets = {
                preset = 'luasnip',
            },
            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                default =
                    function(ctx)
                        local success, node = pcall(vim.treesitter.get_node)
                        if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            return { 'spell', 'buffer', 'path', 'ripgrep' }
                        else
                            return { 'lsp', 'snippets' , 'path', 'buffer', 'ripgrep', 'lazydev' }
                        end
                    end,
                providers = {
                    spell = {
                        name = 'Spell',
                        module = 'blink-cmp-spell',
                        opts = {
                            use_cmp_spell_sorting = true,
                            -- EXAMPLE: Only enable source in `@spell` captures, and disable it
                            -- in `@nospell` captures.
                            enable_in_context = function()
                                local curpos = vim.api.nvim_win_get_cursor(0)
                                local captures = vim.treesitter.get_captures_at_pos(
                                    0,
                                    curpos[1] - 1,
                                    curpos[2] - 1
                                )
                                local in_spell_capture = false
                                for _, cap in ipairs(captures) do
                                    if cap.capture == 'spell' then
                                        in_spell_capture = true
                                    elseif cap.capture == 'nospell' then
                                        return false
                                    end
                                end
                                return in_spell_capture
                            end,
                        },
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    buffer = {
                        opts = {
                            get_bufnrs = function()
                                return vim.tbl_filter(function(bufnr)
                                    return vim.bo[bufnr].buftype == ''
                                end, vim.api.nvim_list_bufs())
                            end
                        }
                    },
                    ripgrep = {
                        module = "blink-ripgrep",
                        name = "Ripgrep",
                        -- see the full configuration below for all available options
                        ---@module "blink-ripgrep"
                        ---@type blink-ripgrep.Options
                        opts = {},
                    },
                    snippets = {
                        -- should_show_items = function(ctx)
                        --     return ctx.trigger.initial_kind == ';'
                        -- end
                    }
                }
            },

            -- fuzzy = {
            --
            -- },
            -- experimental auto-brackets support
            completion = {
                -- Show documentation when selecting a completion item
                --
                list = { selection = { preselect = false, auto_insert = true } },
                documentation = { auto_show = false },
                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                    end

                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            }
                        },
                        treesitter = { 'lsp' }
                    }
                }
            },

            -- experimental signature help support
            signature = { enabled = true }
        },
    },
}
