return {
{
    "lewis6991/hover.nvim",
        enabled=false,
    config = function()
        require("hover").setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                -- require('hover.providers.gh')
                -- require('hover.providers.gh_user')
                -- require('hover.providers.jira')
                -- require('hover.providers.man')
                -- require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = nil
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true
        }

        -- Setup keymaps
        vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
        vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
    end
},
{
  "utilyre/sentiment.nvim",
  version = "*",
  event = "VeryLazy", -- keep for lazy loading
  opts = {
    -- config
  },
  init = function()
    -- `matchparen.vim` needs to be disabled manually in case of lazy loading
    vim.g.loaded_matchparen = 1
  end,
},
    { "echasnovski/mini.align",
        opts = {
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                start = "ga",
                start_with_preview = "gA",
            },

            -- Modifiers changing alignment steps and/or options
            -- modifiers = {
            -- -- Main option modifiers
            -- ['s'] = --<function: enter split pattern>,
            -- ['j'] = --<function: choose justify side>,
            -- ['m'] = --<function: enter merge delimiter>,
            --
            -- -- Modifiers adding pre-steps
            -- ['f'] = --<function: filter parts by entering Lua expression>,
            -- ['i'] = --<function: ignore some split matches>,
            -- ['p'] = --<function: pair parts>,
            -- ['t'] = --<function: trim parts>,
            --
            -- -- Delete some last pre-step
            -- ['<BS>'] = --<function: delete some last pre-step>,
            --
            -- -- Special configurations for common splits
            -- ['='] = --<function: enhanced setup for '='>,
            -- [','] = --<function: enhanced setup for ','>,
            -- [' '] = --<function: enhanced setup for ' '>,
            -- },
            --
            -- Default options controlling alignment process
            options = {
                split_pattern = "",
                justify_side = "left",
                merge_delimiter = "",
            },

            -- Default steps performing alignment (if `nil`, default is used)
            steps = {
                pre_split = {},
                split = nil,
                pre_justify = {},
                justify = nil,
                pre_merge = {},
                merge = nil,
            },
        }
        ,config=function (_,opts)
            require("mini.align").setup(opts)
        end
    },
    -- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --         require("lsp_lines").setup()
    --         vim.keymap.set(
    --             "n",
    --             "<Leader>lt",
    --             require("lsp_lines").toggle,
    --             { desc = "Toggle lsp_lines" }
    --         )
    --     end, },
    --
 {
    'laytan/tailwind-sorter.nvim',
        enabled=false,
        ft= {"javascriptreact"},
    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim'},
    build = 'cd formatter && npm i && npm run build',
    config = function() require('tailwind-sorter').setup() end,
  },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            draw = {
                animation = function ()
                    return 0
                end
            },
            -- symbol = "│",
            symbol = "▎",

            -- symbol = "║",
            -- symbol = "┃",
            -- symbol = "┇",
            -- symbol = "┋",
            -- symbol = "┊",

            -- symbol = "▌",
            -- symbol = "▎",
            -- symbol = "▏",
            -- symbol = "░",
            options = { try_as_border = true },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason","norg" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require("mini.indentscope").setup(opts)
        end,
    },
-- { "lukas-reineke/indent-blankline.nvim" },
{ "folke/todo-comments.nvim",
 cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    opts = {
        {
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = {
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "BOLD", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        }
    } },
{ "echasnovski/mini.trailspace", version = "*"},
{ "uga-rosa/ccc.nvim", event = { "BufReadPost", "BufNewFile", "BufWritePre" , "VeryLazy" },lazy=true},
{
  "luckasRanarison/nvim-devdocs",
        lazy=true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {}
}

}
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
-- table.insert(vim.g.indent_blankline_filetype_exclude,"txt")
-- C/C++ Ouroboros
-- vim.keymap.set("n", "<leader>lh", "<cmd>Ouroboros<cr>", {})
