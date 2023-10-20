return {
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     opts = {
    --         overrides = {
    --             texTabularChar = { link = "GruvboxYellow" }
    --         }
    --     }
    -- },
    -- { "sainnhe/gruvbox-material" },
    -- { "rebelot/kanagawa.nvim" },
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 998,
  opts = {},
},
    -- { "catppuccin/nvim", name = "catppuccin", priority = 997 },
    {
        "navarasu/onedark.nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {
            style = "warmer",                      -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false,                   -- Show/hide background
            term_colors = true,                    -- Change terminal color as per the selected theme style
            ending_tildes = false,                 -- Show the end-of-buffer tildes. By default they are hidden
            -- toggle theme style ---
            toggle_style_key = "<leader>nt",       -- Default keybinding to toggle
            toggle_style_list = { "light", "warmer" }, -- List of styles to toggle between

            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = "italic",
                keywords = "none",
                functions = "bold",
                strings = "italic",
                variables = "none",
            },

            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {
            },       -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true, -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
            config = function(_,opts)

            function ToggleTheme()
                if vim.o.background == "dark" then
                    vim.cmd.colorscheme("onelight")
                else
                    vim.cmd.colorscheme("onedark")
                end
            end

            vim.keymap.set("n", "<leader>nt", ToggleTheme, { desc = "Toggle Theme" })
                require("onedark").setup(opts)
            end
        }
    },
    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        enabled=false,
        priority = 1000,
        opts = {
            colors = {
                dark = {
                    var = "#ABB2BF"
                },
                light = {
                    var = "#282C34"
                }
            },             -- Override default colors. Can specify colors for "onelight" or "onedark" themes
            hlgroups = {}, -- Override default highlight groups
            highlights = {
                ["@variable"] = { fg = "${var}", style = "italic" },
                ["MatchParen"] = { bg = "gray", style = "bold" }
            },
            styles = {
                types = "NONE",
                methods = "NONE",
                numbers = "NONE",
                strings = "NONE",
                comments = "italic",
                keywords = "bold,italic",
                constants = "NONE",
                functions = "italic",
                operators = "NONE",
                variables = "NONE",
                parameters = "NONE",
                conditionals = "italic",
                virtual_text = "NONE",
            },
            options = {
                bold = true,                    -- Use the themes opinionated bold styles?
                italic = true,                  -- Use the themes opinionated italic styles?
                underline = false,              -- Use the themes opinionated underline styles?
                undercurl = true,               -- Use the themes opinionated undercurl styles?
                cursorline = true,              -- Use cursorline highlighting?
                transparency = false,           -- Use a transparent background?
                terminal_colors = false,        -- Use the theme's colors for Neovim's :terminal?
                window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
            },
        },
        config = function(_, opts)
            function ToggleTheme()
                if vim.o.background == "dark" then
                    vim.cmd.colorscheme("onelight")
                else
                    vim.cmd.colorscheme("onedark")
                end
            end

            vim.keymap.set("n", "<leader>nt", ToggleTheme, { desc = "Toggle Theme" })

            require("onedarkpro").setup(opts)
        end
    }
}
