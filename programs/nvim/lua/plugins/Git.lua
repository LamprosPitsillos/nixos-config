return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            signs                   = {
                add          = { text = "" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
            signcolumn              = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl                   = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                  = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff               = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir            = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked     = true,
            current_line_blame      = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            -- current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority           = 6,
            update_debounce         = 100,
            status_formatter        = nil, -- Use default
            max_file_length         = 40000,
            preview_config          = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1
            },
            on_attach               = function(bufnr)
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
        diff_binaries = false,   -- Show diffs for binaries
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" },     -- The git executable followed by default args.
        use_icons = true,        -- Requires nvim-web-devicons
        show_help_hints = true,  -- Show hints for how to open the help panel
        watch_index = true,      -- Update views and index buffers when the git index changes.
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
            listing_style = "tree", -- One of 'list' or 'tree'
            tree_options = {
                -- Only applies when listing_style is 'tree'
                flatten_dirs = true,             -- Flatten dirs that only contain one single dir
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
    cmd = "Neogit",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim",        -- optional
    },
    opts = {
        -- Hides the hints at the top of the status buffer
        disable_hint = false,
        -- Disables changing the buffer highlights based on where the cursor is.
        disable_context_highlighting = false,
        -- Disables signs for sections/items/hunks
        disable_signs = false,
        -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
        -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
        -- normal mode.
        disable_insert_on_commit = "auto",
        -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
        -- events.
        filewatcher = {
            interval = 1000,
            enabled = true,
        },
        -- "ascii"   is the graph the git CLI generates
        -- "unicode" is the graph like https://github.com/rbong/vim-flog
        graph_style = "unicode",
        -- Used to generate URL's for branch popup action "pull request".
        git_services = {
            ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
            ["bitbucket.org"] =
            "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
            ["gitlab.com"] =
            "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        },
        -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
        -- sorter instead. By default, this function returns `nil`.
        telescope_sorter = function()
            return require("telescope").extensions.fzf.native_fzf_sorter()
        end,
        -- Persist the values of switches/options within and across sessions
        remember_settings = true,
        -- Scope persisted settings on a per-project basis
        use_per_project_settings = true,
        -- Table of settings to never persist. Uses format "Filetype--cli-value"
        ignored_settings = {
            "NeogitPushPopup--force-with-lease",
            "NeogitPushPopup--force",
            "NeogitPullPopup--rebase",
            "NeogitCommitPopup--allow-empty",
            "NeogitRevertPopup--no-edit",
        },
        -- Configure highlight group features
        highlight = {
            italic = true,
            bold = true,
            underline = true
        },
        -- Set to false if you want to be responsible for creating _ALL_ keymappings
        use_default_keymaps = true,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        -- Value used for `--sort` option for `git branch` command
        -- By default, branches will be sorted by commit date descending
        -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
        -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
        sort_branches = "-committerdate",
        -- Change the default way of opening neogit
        kind = "split",
        -- Disable line numbers and relative line numbers
        disable_line_numbers = true,
        -- The time after which an output console is shown for slow running commands
        console_timeout = 2000,
        -- Automatically show console if a command takes more than console_timeout milliseconds
        auto_show_console = true,
        status = {
            recent_commit_count = 10,
        },
        commit_editor = {
            kind = "auto",
        },
        commit_select_view = {
            kind = "tab",
        },
        commit_view = {
            kind = "vsplit",
            verify_commit = os.execute("which gpg") == 0, -- Can be set to true or false, otherwise we try to find the binary
        },
        log_view = {
            kind = "tab",
        },
        rebase_editor = {
            kind = "auto",
        },
        reflog_view = {
            kind = "tab",
        },
        merge_editor = {
            kind = "auto",
        },
        tag_editor = {
            kind = "auto",
        },
        preview_buffer = {
            kind = "split",
        },
        popup = {
            kind = "split",
        },
        signs = {
            -- { CLOSED, OPENED }
            hunk = { "", "" },
            item = { "󰅂", "󰅀" },
            section = { "", "" },
        },
        -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
        integrations = {
            -- If enabled, use telescope for menu selection rather than vim.ui.select.
            -- Allows multi-select and some things that vim.ui.select doesn't.
            telescope = true,
            -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
            -- The diffview integration enables the diff popup.
            --
            -- Requires you to have `sindrets/diffview.nvim` installed.
            diffview = true,

            -- If enabled, uses fzf-lua for menu selection. If the telescope integration
            -- is also selected then telescope is used instead
            -- Requires you to have `ibhagwan/fzf-lua` installed.
            fzf_lua = nil,
        },
        sections = {
            -- Reverting/Cherry Picking
            sequencer = {
                folded = false,
                hidden = false,
            },
            untracked = {
                folded = false,
                hidden = false,
            },
            unstaged = {
                folded = false,
                hidden = false,
            },
            staged = {
                folded = false,
                hidden = false,
            },
            stashes = {
                folded = true,
                hidden = false,
            },
            unpulled_upstream = {
                folded = true,
                hidden = false,
            },
            unmerged_upstream = {
                folded = false,
                hidden = false,
            },
            unpulled_pushRemote = {
                folded = true,
                hidden = false,
            },
            unmerged_pushRemote = {
                folded = false,
                hidden = false,
            },
            recent = {
                folded = true,
                hidden = false,
            },
            rebase = {
                folded = true,
                hidden = false,
            },
        },
        mappings = {
            commit_editor = {
                ["q"] = "Close",
                ["<c-c><c-c>"] = "Submit",
                ["<c-c><c-k>"] = "Abort",
            },
            rebase_editor = {
                ["p"] = "Pick",
                ["r"] = "Reword",
                ["e"] = "Edit",
                ["s"] = "Squash",
                ["f"] = "Fixup",
                ["x"] = "Execute",
                ["d"] = "Drop",
                ["b"] = "Break",
                ["q"] = "Close",
                ["<cr>"] = "OpenCommit",
                ["gk"] = "MoveUp",
                ["gj"] = "MoveDown",
                ["<c-c><c-c>"] = "Submit",
                ["<c-c><c-k>"] = "Abort",
            },
            finder = {
                ["<cr>"] = "Select",
                ["<c-c>"] = "Close",
                ["<esc>"] = "Close",
                ["<c-n>"] = "Next",
                ["<c-p>"] = "Previous",
                ["<down>"] = "Next",
                ["<up>"] = "Previous",
                ["<tab>"] = "MultiselectToggleNext",
                ["<s-tab>"] = "MultiselectTogglePrevious",
                ["<c-j>"] = "NOP",
            },
            -- Setting any of these to `false` will disable the mapping.
            popup = {
                ["?"] = "HelpPopup",
                ["A"] = "CherryPickPopup",
                ["D"] = "DiffPopup",
                ["M"] = "RemotePopup",
                ["P"] = "PushPopup",
                ["X"] = "ResetPopup",
                ["Z"] = "StashPopup",
                ["b"] = "BranchPopup",
                ["c"] = "CommitPopup",
                ["f"] = "FetchPopup",
                ["l"] = "LogPopup",
                ["m"] = "MergePopup",
                ["p"] = "PullPopup",
                ["r"] = "RebasePopup",
                ["v"] = "RevertPopup",
                ["w"] = "WorktreePopup",
            },
            status = {
                ["q"] = "Close",
                ["I"] = "InitRepo",
                ["1"] = "Depth1",
                ["2"] = "Depth2",
                ["3"] = "Depth3",
                ["4"] = "Depth4",
                ["<tab>"] = "Toggle",
                ["x"] = "Discard",
                ["s"] = "Stage",
                ["S"] = "StageUnstaged",
                ["<c-s>"] = "StageAll",
                ["u"] = "Unstage",
                ["U"] = "UnstageStaged",
                ["$"] = "CommandHistory",
                ["Y"] = "YankSelected",
                ["<c-r>"] = "RefreshBuffer",
                ["<enter>"] = "GoToFile",
                ["<c-v>"] = "VSplitOpen",
                ["<c-x>"] = "SplitOpen",
                ["<c-t>"] = "TabOpen",
                ["{"] = "GoToPreviousHunkHeader",
                ["}"] = "GoToNextHunkHeader",
            },
        },
    }
}

}
