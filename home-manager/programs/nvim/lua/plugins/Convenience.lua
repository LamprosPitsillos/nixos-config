return {

    {
        "ethanholz/nvim-lastplace",
        opts = {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help", "prompt" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "TelescopePrompt" },
            lastplace_open_folds = true,
        }
    },
    {

        "echasnovski/mini.bufremove",
        version = "*",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
        },
    },
    {
        "monaqa/dial.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            local dial_map = require("dial.map")
            vim.api.nvim_set_keymap("n", "<C-a>", dial_map.inc_normal(), { noremap = true })
            vim.api.nvim_set_keymap("n", "<C-x>", dial_map.dec_normal(), { noremap = true })
            vim.api.nvim_set_keymap("v", "<C-a>", dial_map.inc_visual(), { noremap = true })
            vim.api.nvim_set_keymap("v", "<C-x>", dial_map.dec_visual(), { noremap = true })
            vim.api.nvim_set_keymap("v", "g<C-a>", dial_map.inc_gvisual(), { noremap = true })
            vim.api.nvim_set_keymap("v", "g<C-x>", dial_map.dec_gvisual(), { noremap = true })

            local augend = require("dial.augend")

            require("dial.config").augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    -- augend.date.alias["%Y/%m/%d"],
                    augend.constant.alias.bool,
                    augend.constant.new {
                        elements = { "and", "or" },
                        word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    },
                    augend.constant.new {
                        elements = { "get", "set" },
                        word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    },
                    augend.date.new {
                        pattern = "%B",
                        default_kind = "day",
                        -- if true, it does not match dates which does not exist, such as 2022/05/32
                        only_valid = true,
                        -- if true, it only matches dates with word boundary
                        word = false,
                    },
                    augend.constant.new {
                        elements = { "&&", "||" },
                        word = false,
                        cyclic = true,
                    },
                },
            }
        end
    },
    -- { dir = "/home/inferno/docs/Programming/Projects/NEOVIM_PLUGS/ouroboros.nvim" },
    {
        "mcauley-penney/tidy.nvim",
        config = true,
    },
    {
        'stevearc/overseer.nvim',
        opts = {},
    }
}
