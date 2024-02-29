return {
    {
        "nvim-neorg/neorg",
        enabled = true,
        ft = "norg",
        cmd = "Neorg",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.export"] = {},
                -- ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
                ["core.qol.toc"] = {},
                ["core.qol.todo_items"] = {},
                ["core.summary"] = {},
                ["core.export.markdown"] = {
                    config = { -- Note that this table is optional and doesn't need to be provided
                        extensions = "all"
                    }
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.unmap("norg", "n", "<M-j>")
                            keybinds.unmap("norg", "n", "<M-k>")
                        end,
                    },
                },
                ["core.concealer"] = { config = { icon_preset = "diamond" } },
                ["core.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            wiki = "~/docs/WIKI",
                            journal = "~/docs",
                        },
                    },
                },

                ["core.journal"] = {
                    config = {
                        workspace = "journal"
                    }
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
                        name = "[Norg]"
                    },
                },
                ["core.integrations.nvim-cmp"] = {},
                ["core.ui.calendar"] = {},
                ["core.looking-glass"] = {},
                ["core.tangle"] = {}
            },
        }
    },

}
