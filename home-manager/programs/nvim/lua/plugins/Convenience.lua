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
        "windwp/nvim-autopairs",
        enabled=false,
        opts = {
            disable_in_visualblock = true,
            enable_moveright = true
        }
    },
{
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    opts={
        --Config goes here
    },
}
,
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function(_, opts)
            require("mini.indentscope").setup(opts)
        end,
    },
    {

        "echasnovski/mini.bufremove",
        version = "*",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
        },
    },
    { "s1n7ax/nvim-comment-frame",
        keys= {
            { "gcl", ":lua require('nvim-comment-frame').add_comment()<CR>",desc="[c]omment [l]ine" },
            { "gcf", ":lua require('nvim-comment-frame').add_multiline_comment()<CR>",desc="[c]omment [f]rame" }
        },
        dependencies = { "nvim-treesitter" }
    },
    { "numToStr/Comment.nvim",     config = true },
    {
        "monaqa/dial.nvim",
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
    { dir ="/home/inferno/docs/Programming/Projects/NEOVIM_PLUGS/ouroboros.nvim"},
    "mcauley-penney/tidy.nvim"
}
