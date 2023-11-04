return {
    {
        "nvim-neorg/neorg",
        enable = false,
        ft = "norg",
        cmd = "Neorg",
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.export"] = {},
                ["core.presenter"] = { config = { zen_mode = "truezen" } },
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
                ["core.concealer"] = {
                    config = {
                        icons = {
                            code_block = {
                                conceal = true
                            }
                        }
                    },
                },
                ["core.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            wiki = "~/docs/WIKI/",
                            pnotes = "~/docs/Programming/Notes/",
                        },
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
                    },
                },
                ["core.ui.calendar"] = {}
            },
        }
    },

}
