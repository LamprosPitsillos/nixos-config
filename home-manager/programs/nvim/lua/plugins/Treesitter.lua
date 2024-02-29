return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        dependencies = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        opts = {
            -- @assignment.inner .lhs .outer .rhs
            -- @attribute.inner .outer
            -- @block.inner .outer
            -- @call.inner .outer
            -- @class.inner .outer
            -- @comment.inner .outer
            -- @conditional.inner .outer
            -- @frame.inner .outer
            -- @function.inner .outer
            -- @loop.inner .outer
            -- @number.inner
            -- @parameter.inner .outer
            -- @regex.inner .outer
            -- @return.inner .outer
            -- @scopename.inner .outer
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"]  = "@function.outer",
                        ["if"]  = "@function.inner",

                        ["ib"]  = "@block.inner",
                        ["ab"]  = "@block.outer",

                        ["acl"] = "@class.outer",
                        ["icl"] = "@class.inner",

                        ["al"]  = "@loop.outer",
                        ["il"]  = "@loop.inner",

                        ["icm"] = "@comment.outer",

                        ["ip"]  = "@parameter.inner",
                        ["ap"]  = "@parameter.outer",

                        ["ica"] = "@call.inner",
                        ["aca"] = "@call.outer",

                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>cn"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>cp"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        --
                        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                        -- ["]o"] = "@loop.*",
                        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                        --
                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                    -- Below will go to either the start or the end, whichever is closer.
                    -- Use if you want more granular movements
                    -- Make it even more gradual by adding multiple queries and regex.
                    goto_next = {
                        -- ["]d"] = "@conditional.outer",
                    },
                    goto_previous = {
                        -- ["[d"] = "@conditional.outer",
                    }
                },
            },
            rainbow = {
                enable = true,
                -- list of languages you want to disable the plugin for
                -- disable = { "jsx", "cpp" },
                -- Which query to use for finding delimiters
                query = 'rainbow-parens',
                -- Highlight the entire buffer all at once
                -- strategy = require 'ts-rainbow.strategy.global',
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "<Tab>",
                    node_decremental = "<S-Tab>",
                },
            },
            indent = {
                enable = true, disable = { "python" }
            },
            ensure_installed = {
                "norg","norg_meta",
                "hyprlang",
                "bash","tmux",
                "c",
                "cmake",
                "cpp",
                "css",
                "scss",
                "sql",
                "go",
                "javascript",
                "html",
                "jsdoc",
                "json",
                "lua",
                "markdown", "markdown_inline","typst",
                "nix",
                "prisma",
                "python",
                "rust",
                "tsx",
                "typescript",
                "yuck",
                "vim",
                "regex"
            },                              -- one of "all", "maintained" (parsers with maintainers), and a list of languages
            ignore_install = { "comment" }, -- List of parsers to ignore installing
            highlight = {
                enable = true,
                use_languagetree = true,
                disable = { "latex", "tex" },
                additional_vim_regex_highlighting = { "latex", "tex" },
            },
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_vents = { "BufWrite", "CursorHold" },
            },
            autotag = {
                enable = true
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    }
    , {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    dependencies = "nvim-treesitter",
    opts = {
        enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 2,        -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        patterns = {
            -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                "class",
                "function",
                "method",
                "for", -- These won't appear in the context
                "while",
                "if",
                -- 'switch',
                -- 'case',
            },
            -- Example for a specific filetype.
            -- If a pattern is missing, *open a PR* so everyone can benefit.
            --   rust = {
            --       'impl_item',
            --   },
        },
        exact_patterns = {
            -- Example for a specific filetype with Lua patterns
            -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
            -- exactly match "impl_item" only)
            -- rust = true,
        },
        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20,     -- The Z-index of the context window
        mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
        separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
    }
},
}
