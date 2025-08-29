return {
    {
        "s1n7ax/nvim-comment-frame",
        keys = {
            { "gcl", ":lua require('nvim-comment-frame').add_comment()<CR>",           desc = "[c]omment [l]ine" },
            { "gcf", ":lua require('nvim-comment-frame').add_multiline_comment()<CR>", desc = "[c]omment [f]rame" }
        },
        dependencies = { "nvim-treesitter" }
    },

    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = {
                enable_autocmd = false,
            },
        },
        config = function(_, opts)
            require("Comment").setup({
                    padding = true,
                    sticky = true,
                    ignore = nil,
                    toggler = {
                        line = 'gcc',
                        block = 'gbc',
                    },
                    opleader = {
                        line = 'gc',
                        block = 'gb',
                    },
                    extra = {
                        ---Add comment on the line above
                        above = 'gcO',
                        ---Add comment on the line below
                        below = 'gco',
                        ---Add comment at the end of line
                        eol = 'gcA',
                    },
                    mappings = {
                        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                        basic = true,
                        ---Extra mapping; `gco`, `gcO`, `gcA`
                        extra = true,
                    },
                    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                    post_hook = nil,
            })
        end
    },
}
