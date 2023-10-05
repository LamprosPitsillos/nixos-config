return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs                        = {
                add          = { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                change       = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn" },
                delete       = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn" },
                topdelete    = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr",
                    linehl = "GitSignsDeleteLn" },
                changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn" },
            },
            signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked          = true,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil, -- Use default
            max_file_length              = 40000,
            preview_config               = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },
            yadm                         = {
                enable = false
            },
            on_attach                    = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                map("n", "<leader>ghu", gs.undo_stage_hunk)
                map("n", "<leader>gR", gs.reset_buffer)
                map("n", "<leader>ghp", gs.preview_hunk)
                map("n", "<leader>gB", function() gs.blame_line { full = true } end)
                map("n", "<leader>gb", function() gs.blame_line() end)
                -- map('n', '<leader>gb', gs.toggle_current_line_blame)
                map("n", "<leader>ghd", gs.diffthis)
                map("n", "<leader>gD", function() gs.diffthis("~") end)
                map("n", "<leader>gd", gs.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end
        },
    }
    , {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = "DiffviewOpen",
    opts = {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" }, -- The git executable followed by default args.
        use_icons = true,    -- Requires nvim-web-devicons
        show_help_hints = true, -- Show hints for how to open the help panel
        watch_index = true,  -- Update views and index buffers when the git index changes.
        icons = {
                             -- Only applies when use_icons is true.
            folder_closed = "",
            folder_open = "",
        },
        signs = {
            fold_closed = "",
            fold_open = "",
            done = "✓",
        },
        view = {
            -- Configure the layout and behavior of different types of views.
            -- Available layouts:
            --  'diff1_plain'
            --    |'diff2_horizontal'
            --    |'diff2_vertical'
            --    |'diff3_horizontal'
            --    |'diff3_vertical'
            --    |'diff3_mixed'
            --    |'diff4_mixed'
            -- For more info, see ':h diffview-config-view.x.layout'.
            default = {
                -- Config for changed files, and staged files in diff views.
                layout = "diff2_horizontal",
            },
            merge_tool = {
                -- Config for conflicted files in diff views during a merge or rebase.
                layout = "diff3_horizontal",
                disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
            },
            file_history = {
                -- Config for changed files in file history views.
                layout = "diff2_horizontal",
            },
        },
        file_panel = {
            listing_style = "tree",          -- One of 'list' or 'tree'
            tree_options = {
                                             -- Only applies when listing_style is 'tree'
                flatten_dirs = true,         -- Flatten dirs that only contain one single dir
                folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
            },
            win_config = {
                                             -- See ':h diffview-config-win_config'
                position = "left",
                width = 35,
                win_opts = {}
            },
        },
        file_history_panel = {
            win_config = {
                       -- See ':h diffview-config-win_config'
                position = "bottom",
                height = 16,
                win_opts = {}
            },
        },
        commit_log_panel = {
            win_config = { -- See ':h diffview-config-win_config'
                win_opts = {},
            }
        },
        default_args = {
                     -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        hooks = {}, -- See ':h diffview-config-hooks'
    }
}, {
    "NeogitOrg/neogit",
 dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
  },
    opts = {
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        disable_builtin_notifications = false,
        use_magit_keybindings = false,
        -- Change the default way of opening neogit
        kind = "split",
        -- Change the default way of opening the commit popup
        commit_popup = {
            kind = "split",
        },
        -- Change the default way of opening popups
        popup = {
            kind = "split",
        },
        -- customize displayed signs
        signs = {
            -- { CLOSED, OPENED }
            section = { ">", "v" },
            item = { ">", "v" },
            hunk = { "", "" },
        },
        integrations = {
            diffview = true
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
            untracked = {
                folded = false
            },
            unstaged = {
                folded = false
            },
            staged = {
                folded = false
            },
            stashes = {
                folded = true
            },
            unpulled = {
                folded = true,
                    hidden = false
            },
            unmerged = {
                folded = false,
                    hidden=false
            },
            recent = {
                folded = true
            },

        },
        -- override/add mappings
        mappings = {
            -- modify status buffer mappings
            status = {
                -- Adds a mapping with "B" as key that does the "BranchPopup" command
                ["B"] = "BranchPopup",
                -- Removes the default mapping of "s"
            }
        }
    }
}

}
