return {
    {
        'Sam-programs/cmdline-hl.nvim',
        event = 'VimEnter',
        config = function()
            local cmdline_hl = require('cmdline-hl')
            cmdline_hl.setup({
                -- custom prefixes for builtin-commands
                --
                type_signs = {
                    [":"] = { ":", "Title" },
                    ["/"] = { "/", "Title" },
                    ["?"] = { "?", "Title" },
                    ["="] = { "=", "Title" },
                },
                -- custom formatting/highlight for commands
                custom_types = {
                    -- ["command-name"] = {
                    -- [icon],[icon_hl], default to `:` icon and highlight
                    -- [lang], defaults to vim
                    -- [showcmd], defaults to false
                    -- [pat], defaults to "%w*%s*(.*)"
                    -- [code], defaults to nil
                    -- }
                    -- lang is the treesitter language to use for the commands
                    -- showcmd is true if the command should be displayed or to only show the icon
                    -- pat is used to extract the part of the command that needs highlighting
                    -- the part is matched against the raw command you don't need to worry about ranges
                    -- e.g. in '<,>'s/foo/bar/
                    -- pat is checked against s/foo/bar
                    -- you could also use the 'code' function to extract the part that needs highlighting
                    ["lua"] = {
                        pat = "lua[%s=](.*)",
                        icon = " ",
                        lang = "lua",
                    },
                    ["Exec"] = {
                        icon = "!",
                        lang = "bash",
                        show_cmd = false,
                    },
                    ["="] = { pat = "=(.*)", lang = "lua", show_cmd = true },
                    ["help"] = { icon = "? " },
                    ["substitute"] = { pat = "%w(.*)", lang = "regex", show_cmd = true },
                    --["lua"] = false, -- set an option  to false to disable it
                },
                aliases = {
                    -- str is unmapped keys do with that knowledge what you will
                    -- read aliases.md for examples
                    -- ["cd"] = { str = "Cd" },
                },
                -- vim.ui.input() vim.fn.input etc
                input_hl = "Title",
                -- you can use this to format input like the type_signs table
                input_format = function(input) return input end,
                -- used to highlight the range in the command e.g. '<,>' in '<,>'s
                range_hl = "Constant",
                ghost_text = true,
                ghost_text_hl = "Comment",
                inline_ghost_text = false,
                -- history works like zsh-autosuggest you can complete it by pressing <up>
                ghost_text_provider = require("cmdline-hl.ghost_text").history,
                -- you can also use this to get the wildmenu(default completion)'s suggestion
                -- ghost_text_provider = require("cmdline-hl.ghost_text").history,
            })
        end
    }
    ,
    {
        "stevearc/dressing.nvim",
        enabled = true,
        opts = {
            input = {
                -- Set to false to disable the vim.ui.input implementation
                enabled = true,

                -- Default prompt string
                default_prompt = "Input:",

                -- Can be 'left', 'right', or 'center'
                title_pos = "left",

                -- When true, <Esc> will close the modal
                insert_only = false,

                -- When true, input will start in insert mode.
                start_in_insert = true,

                -- These are passed to nvim_open_win
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "cursor",

                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                prefer_width = 40,
                width = nil,
                -- min_width and max_width can be a list of mixed types.
                -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },

                buf_options = {},
                win_options = {
                    -- Disable line wrapping
                    wrap = false,
                    -- Indicator for when text exceeds window
                    list = true,
                    listchars = "precedes:…,extends:…",
                    -- Increase this for more context when text scrolls off the window
                    sidescrolloff = 0,
                },

                -- Set to `false` to disable
                mappings = {
                    n = {
                        ["<Esc>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },
                    i = {
                        ["<C-c>"] = "Close",
                        ["<CR>"] = "Confirm",
                        ["<Up>"] = "HistoryPrev",
                        ["<Down>"] = "HistoryNext",
                    },
                },

                override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                end,

                -- see :help dressing_get_config
                get_config = nil,
            },
            select = {
                -- Set to false to disable the vim.ui.select implementation
                enabled = true,

                -- Priority list of preferred vim.select implementations
                backend = { "telescope", "builtin" },

                -- Trim trailing `:` from prompt
                trim_prompt = true,

                -- Options for telescope selector
                -- These are passed into the telescope picker directly. Can be used like:
                -- telescope = require('telescope.themes').get_ivy({...})
                telescope = nil,

                -- Options for built-in selector
                builtin = {
                    -- Display numbers for options and set up keymaps
                    show_numbers = true,
                    -- These are passed to nvim_open_win
                    border = "rounded",
                    -- 'editor' and 'win' will default to being centered
                    relative = "editor",

                    buf_options = {},
                    win_options = {
                        cursorline = true,
                        cursorlineopt = "both",
                    },

                    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- the min_ and max_ options can be a list of mixed types.
                    -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                    width = nil,
                    max_width = { 140, 0.8 },
                    min_width = { 40, 0.2 },
                    height = nil,
                    max_height = 0.9,
                    min_height = { 10, 0.2 },

                    -- Set to `false` to disable
                    mappings = {
                        ["<Esc>"] = "Close",
                        ["<C-c>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },

                    override = function(conf)
                        -- This is the config that will be passed to nvim_open_win.
                        -- Change values here to customize the layout
                        return conf
                    end,
                },

                -- Used to override format_item. See :help dressing-format
                format_item_override = {},

                -- see :help dressing_get_config
                get_config = nil,
            },
        }
    }
}
