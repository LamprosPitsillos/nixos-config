return {

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI",
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
            enable_autosnippets = false,
            ext_opts = {
                [require("luasnip.util.types").choiceNode] = {
                    active = {
                        virt_text = { { "<-", "Error" } },
                    },
                },
            },
        },
        keys = {
            {
                "<C-l>",
                function()
                    if require("luasnip").expand_or_jumpable() then
                        require("luasnip").expand_or_jump()
                    end
                end,
                mode = { "i", "s" },
                silent = true
            },
            {
                "<C-h>",
                function()
                    if require("luasnip").jumpable(-1) then
                        require("luasnip").jump(-1)
                    end
                end,
                mode = { "i", "s" },
                silent = true

            }, {
            "<C-j>",
            function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end,
            mode = "i"
        }
            ,{
            "<C-k>",
            function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(-1)
                end
            end,
            mode = "i"
        }

        }
    },
}
