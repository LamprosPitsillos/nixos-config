return {

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "jvgrootveld/telescope-zoxide" },
            { "nvim-telescope/telescope-file-browser.nvim" --[[ branch="feat/tree" ]] },
            { "benfowler/telescope-luasnip.nvim" },
            { "nvim-telescope/telescope-symbols.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim",                             build = "make" },

        },
        config = function()
            -- local actions = require("telescope.actions")
            local layout = require("telescope.actions.layout")
            local previewers = require("telescope.previewers")
            local sorters = require("telescope.sorters")

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
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
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
                },
            })

            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("zoxide")
            require("telescope").load_extension("luasnip")
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

            map_utils.nmap('<leader>"', "<cmd>Telescope registers theme=cursor<CR>", { desc = "definition" })
            map_utils.imap("<C-s>", telescope.symbols, { desc = "symbols" })
            map_utils.nmap("z=", telescope.spell_suggest, { desc = "spell" })
            map_utils.nmap("<leader>bs", telescope.buffers, { desc = "select buffer" })
            map_utils.nmap("<leader>sf",
                function() telescope.current_buffer_fuzzy_find({ skip_empty_lines = true }) end,
                { desc = "fuzzy search" })
            map_utils.imap("<C-r>", "<cmd>Telescope registers theme=cursor<CR>", { desc = "definition" })
            map_utils.nmap("<leader>cr", function() telescope.lsp_references({ trim_text = true }) end,
                { desc = "references" })
            map_utils.nmap("<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "symbols" })
            map_utils.nmap("<leader>le", telescope.diagnostics, { desc = "diagnostics" })
            map_utils.nmap("<leader>ld", "<cmd>Telescope lsp_definitions theme=cursor<CR>", { desc = "definition" })
            map_utils.nmap("<leader>vld", "<cmd>vsplit | Telescope lsp_definitions theme=cursor<CR>", { desc = "definition" })
            map_utils.nmap("<leader>hh", telescope.help_tags, { desc = "telescope" })
            map_utils.nmap("<leader>hm", function() telescope.man_pages({ sections = { "ALL" } }) end,
                { desc = "man pages" })
            map_utils.nmap("<leader>ft",
                function()
                    telescope.live_grep({
                        cwd = vim.lsp.buf.list_workspace_folders()[1],
                        glob_pattern = "!ThirdParty"
                    })
                end,
                { desc = "live grep" })
            map_utils.nmap("<leader>fg",
                function() telescope.grep_string({ cwd = vim.lsp.buf.list_workspace_folders()[1] }) end,
                { desc = "grep" })
            map_utils.nmap("<leader>fz", require("telescope").extensions.zoxide.list, { desc = "zoxide" })
            map_utils.nmap("<leader>ff",
                function() telescope.find_files({ hidden = false, cwd = vim.lsp.buf.list_workspace_folders()[1] }) end,
                { desc = "Find Files" })
            map_utils.nmap("<leader>fb",
                function()
                    require("telescope").extensions.file_browser.file_browser({
                        cwd = require "telescope.utils".buffer_dir() })
                end
                , { desc = "File Browser" })

            map_utils.nmap("<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
            map_utils.nmap("<space>tt", "<cmd>Telescope builtin include_extensions=true<cr>", { desc = "Open Telescope" })
            map_utils.cmap("<C-f>","<cmd>Telescope command_history<cr>",{}) end } }
