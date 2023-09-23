return {
    { "folke/zen-mode.nvim",opts={
        window = {
            backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            -- height and width can be:
            -- * an absolute number of cells when > 1
            -- * a percentage of the width / height of the editor when <= 1
            -- * a function that returns the width or the height
            width = 120, -- width of the Zen window
            height = 1, -- height of the Zen window
            -- by default, no options are changed for the Zen window
            -- uncomment any of the options below, or add other vim.wo options you want to apply
            options = {
                -- signcolumn = "no", -- disable signcolumn
                -- number = false, -- disable number column
                -- relativenumber = false, -- disable relative numbers
                -- cursorline = false, -- disable cursorline
                -- cursorcolumn = false, -- disable cursor column
                -- foldcolumn = "0", -- disable fold column
                -- list = false, -- disable whitespace characters
            },
        },
        plugins = {
            -- disable some global vim options (vim.o...)
            -- comment the lines to not apply the options
            options = {
                enabled = true,
                ruler = false, -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
            },
            twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
            gitsigns = { enabled = false }, -- disables git signs
            tmux = { enabled = false }, -- disables the tmux statusline
            -- this will change the font size on kitty when in zen mode
            -- to make this work, you need to set the following kitty options:
            -- - allow_remote_control socket-only
            -- - listen_on unix:/tmp/kitty
            kitty = {
                enabled = true,
                font = "+4", -- font size increment
            },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win)
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
        end,
    },
        enabled=false
    },
    { "Pocco81/true-zen.nvim",opts={
        modes = {
            ataraxis = {
                callbacks = {
                    open_pre = function()
                        require("lualine").hide()
                    end,
                    close_pre = function()
                        require("lualine").hide({ unhide = true })
                    end,
                },
            },
        },
    } 
    },
    { 'karb94/neoscroll.nvim',
        event = "VeryLazy",
        enabled=false,
        opts={
            hide_cursor = true,          -- Hide cursor while scrolling
            stop_eof = true,             -- Stop at <EOF> when scrolling downwards
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil,       -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,             -- Function to run after the scrolling animation ends
            performance_mode = false,    -- Disable "Performance Mode" on all buffers.
        }
        ,config = function (_,opts)
            require('neoscroll').setup(opts)
            local t = {}
            -- Syntax: t[keys] = {function, {function arguments}}
            t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}}
            t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '150'}}
            t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '250'}}
            t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '250'}}
            t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
            t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
            t['zt']    = {'zt', {'150'}}
            t['zz']    = {'zz', {'150'}}
            t['zb']    = {'zb', {'150'}}

            require('neoscroll.config').set_mappings(t)
        end

    },
 {
    "stevearc/dressing.nvim",
    lazy = true,
        enabled = false, 
    init = function()
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}
