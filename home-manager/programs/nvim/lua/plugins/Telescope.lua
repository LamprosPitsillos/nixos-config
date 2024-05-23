return {

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        lazy = true,
        dev = false,
        event = "VeryLazy",
        dependencies = {
            -- { "nvim-telescope/telescope-ui-select.nvim" },
            { "jvgrootveld/telescope-zoxide" },
            { "nvim-telescope/telescope-file-browser.nvim" --[[ branch="feat/tree" ]] },
           { "benfowler/telescope-luasnip.nvim" },
            { "nvim-telescope/telescope-symbols.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim",                             build = "make" },
            { "Marskey/telescope-sg" },
            { "debugloop/telescope-undo.nvim", },
            { "catgoose/telescope-helpgrep.nvim" }

        },
        config = function()
            local layout = require("telescope.actions.layout")
            local previewers = require("telescope.previewers")
            local sorters = require("telescope.sorters")
            local actions = require("telescope.actions");

            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = ":: ",
                    selection_caret = "> ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        cursor = {
                            height = 0.4,
                            preview_cutoff = 40,
                            width = 0.3,
                            prompt_position = "top"
                        },
                        horizontal = {
                            mirror = false,
                            height = 20,
                        },
                        vertical = {
                            mirror = false,
                            width = 0.5
                        },
                    },
                    file_sorter = sorters.get_fuzzy_file,
                    file_ignore_patterns = {},
                    generic_sorter = sorters.get_generic_fuzzy_sorter,
                    winblend = 10,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    use_less = true,
                    path_display = { "tail" },
                    -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                    file_previewer = previewers.vim_buffer_cat.new,
                    grep_previewer = previewers.vim_buffer_vimgrep.new,
                    qflist_previewer = previewers.vim_buffer_qflist.new,
                    mappings = {
                        i = {
                            ["<C-]>"] = layout.toggle_preview,
                            -- ["<C-]>"] = layout.cycle_layout_next,
                        },
                    }
                    -- Developer configurations: Not meant for general override
                    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
                },
                extensions = {
                    undo = {
                        use_delta = true,
                        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                        side_by_side = true,
                        -- layout_strategy = "horizontal",
                        -- layout_config = {
                        --     preview_height = 0.8,
                        -- },
                        diff_context_lines = vim.o.scrolloff,
                        entry_format = "state #$ID, $STAT, $TIME",
                        time_format = "",
                        mappings = {
                            i = {
                                -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                                -- you want to replicate these defaults and use the following actions. This means
                                -- installing as a dependency of telescope in it's `requirements` and loading this
                                -- extension from there instead of having the separate plugin definition as outlined
                                -- above.
                                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                                ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                                ["<C-cr>"] = require("telescope-undo.actions").restore,
                            },
                        },
                    },
                    ast_grep = {
                        command = {
                            "ast-grep",
                            "--json=stream",
                        },                      -- must have --json=stream
                        grep_open_files = true, -- search in opened files
                        lang = nil,             -- string value, specify language for ast-grep `nil` for default
                    },
                    zoxide = {
                        mappings = {
                            default = {
                                after_action = function(selection)
                                    vim.notify("Update to (" .. selection.z_score .. ") " .. selection.path)
                                end
                            },
                            ["<CR>"] = {
                                action = function(selection)
                                    vim.api.nvim_set_current_dir(selection.path)
                                    require("telescope").extensions.file_browser.file_browser({ cwd = selection.path })
                                end
                            },
                        }
                    },
                    -- ["ui-select"] = {
                    --     require("telescope.themes").get_dropdown(),
                    -- },
                    file_browser = {
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                ["<bs>"] = function()
                                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<bs>", true, false, true), "tn",
                                        false)
                                end
                            }
                        },
                        -- grouped = true,
                        -- initial_browser = "tree",
                        -- -- auto switch to `telescope.builtin.find_files` style finder if there is a prompt
                        -- auto_depth = true,
                        -- depth = 4,

                    },
                    helpgrep = {
                        ignore_paths = {
                            vim.fn.stdpath("state") .. "/lazy/readme",
                        },
                    },
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                },
                pickers = {
                    colorscheme = { enable_preview = true },
                    lsp_references = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        }
                    },
                    find_files = {
                        find_command = {
                            "fd",
                            "--type",
                            "f",
                            "--strip-cwd-prefix",
                            "-E",
                            "*cache*"
                        },
                    },
                    command_history = {
                        mappings = {
                            i = {
                                ["<cr>"] = actions.edit_command_line
                            },
                            n = {
                                ["<cr>"] = actions.edit_command_line
                            },
                        }

                    },
                    spell_suggest = {
                        theme = "cursor",
                        mappings = {
                            -- i = {
                            --     ["<cr>"] = actions.edit_command_line
                            -- },
                        }

                    },

                },
            })

            -- require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("zoxide")
            require("telescope").load_extension("luasnip")
            require("telescope").load_extension("undo")
            require("telescope").load_extension("helpgrep")
            -- require("telescope._extensions.zoxide.config").setup({
            --     mappings = {
            --         default = {
            --             after_action = function(selection)
            --                 print("Update to (" .. selection.z_score .. ") " .. selection.path)
            --             end
            --         },
            --         ["<CR>"] = {
            --             action = function(selection)
            --                 vim.api.nvim_set_current_dir(selection.path)
            --                 require("telescope").extensions.file_browser.file_browser({ cwd = selection.path })
            --             end
            --         },
            --     }
            -- })

            local map_utils = require("Keymaps")
            local telescope = require("telescope.builtin")

            map_utils.nmap("<leader>nc", function()
                require("telescope").extensions.file_browser.file_browser(
                    {
                        prompt_title = "NEOVIM",
                        path = "/home/inferno/.nixos-config/home-manager/programs/nvim/lua/plugins",
                        hidden = true,
                        -- hide_parent_dir = true
                    }
                )
            end, { desc = "Config" })

            map_utils.nmap('<leader>ss', "<cmd>Telescope ast_grep grep_open_files=true<cr>",
                { desc = "[s]earch [s]tructural buffers" })
            map_utils.nmap('<leader>sS', "<cmd>Telescope ast_grep grep_open_files=false<cr>",
                { desc = "[s]earch [S]tructural project" })

            map_utils.nmap('<leader>"', "<cmd>Telescope registers theme=cursor<CR>", { desc = "[\"] registers" })
            -- map_utils.imap("<C-s>", telescope.symbols, { desc = "symbols" })
            map_utils.nmap("z=", "<cmd>Telescope spell_suggest<cr>", { desc = "spell" })
            map_utils.nmap("<leader>bs", "<cmd>Telescope buffers<cr>", { desc = "[b]uffer [s]elect" })
            map_utils.nmap("<leader>sf", function() telescope.current_buffer_fuzzy_find({ skip_empty_lines = true }) end,
                { desc = "[s]earch [f]uzzy" })
            map_utils.imap("<C-r>", "<cmd>Telescope registers theme=cursor<CR>", { desc = "registers" })
            map_utils.nmap("<leader>lr", function() telescope.lsp_references({ trim_text = true }) end,
                { desc = "[l]SP [r]eferences" })
            map_utils.nmap("<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "[l]SP [s]ymbols" })
            map_utils.nmap("<leader>le", telescope.diagnostics, { desc = "[l]SP [e]rrors" })
            map_utils.nmap("<leader>ld", "<cmd>Telescope lsp_definitions theme=cursor<CR>",
                { desc = "[l]SP [d]efinition" })
            map_utils.nmap("<leader>vld", "<cmd>vsplit | Telescope lsp_definitions theme=cursor<CR>",
                { desc = "[v]split [l]SP [d]efinition" })
            map_utils.nmap("<leader>hnt", telescope.help_tags, { desc = "[h]elp [n]eovim" })
            map_utils.nmap("<leader>hm", function() telescope.man_pages({ sections = { "ALL" } }) end,
                { desc = "[h]elp [m]an pages" })

            map_utils.nmap("<leader>hnl", "<cmd>Telescope helpgrep live_grep<cr>", { desc = "[h]elp [n]eovim [l]ive" })

            map_utils.nmap("<leader>sl",
                function()
                    telescope.live_grep({
                        cwd = vim.lsp.buf.list_workspace_folders()[1],
                        glob_pattern = "!ThirdParty"
                    })
                end, { desc = "[s]earch [l]ive" })
            map_utils.nmap("<leader>sw",
                function() telescope.grep_string({ cwd = vim.lsp.buf.list_workspace_folders()[1] }) end,
                { desc = "[s]earch [w]ord under cursor" })
            map_utils.nmap("<leader>fz", require("telescope").extensions.zoxide.list, { desc = "[f]ile [z]oxide" })
            map_utils.nmap("<leader>ff",
                function() telescope.find_files({ hidden = false, cwd = vim.lsp.buf.list_workspace_folders()[1] }) end,
                { desc = "[f]iles [f]ind" })
            map_utils.nmap("<leader>fb",
                function()
                    require("telescope").extensions.file_browser.file_browser({
                        cwd = require "telescope.utils".buffer_dir() })
                end, { desc = "[f]iles [b]rowser" })
            map_utils.nmap("<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "[f]iles [r]ecent" })
            map_utils.nmap("<space>to", "<cmd>Telescope builtin include_extensions=true<cr>", { desc = "Telescope Open" })
            map_utils.cmap("<C-f>", "<cmd>Telescope command_history<cr>", {})
        end
    } }
