return {
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = {
            { 'L3MON4D3/LuaSnip', version = 'v2.*' },
            'rafamadriz/friendly-snippets',
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
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
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
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    snippets = {
                        -- should_show_items = function(ctx)
                        --     return ctx.trigger.initial_kind == ';'
                        -- end
                    }
                }
            },

            -- experimental auto-brackets support
            completion = {
                -- Show documentation when selecting a completion item
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                menu = {
                    draw = {
                        treesitter = { 'lsp' } }
                }
            },

            -- experimental signature help support
            signature = { enabled = true }
        },
    },
}
