return {
    {
        "windwp/nvim-autopairs",
        event = { 'InsertEnter' },
        enabled = true,
        config = function(_, opts)
            local npairs = require 'nvim-autopairs'
            local Rule = require 'nvim-autopairs.rule'
            local cond = require 'nvim-autopairs.conds'

            npairs.setup({
                disable_in_visualblock = true,
                enable_moveright = true
            })

            npairs.add_rule(Rule('*', '*', { 'markdown' }):with_pair(cond.not_inside_quote()))
        end
    }
}
