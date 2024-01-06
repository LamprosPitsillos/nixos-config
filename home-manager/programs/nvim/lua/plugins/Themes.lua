return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 998,
        opts = {},
    },
    {
        "navarasu/onedark.nvim",
        dev = true,
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {
            style = "warmer",                          -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false,                       -- Show/hide background
            term_colors = true,                        -- Change terminal color as per the selected theme style
            ending_tildes = false,                     -- Show the end-of-buffer tildes. By default they are hidden
            -- toggle theme style ---
            toggle_style_key = "<leader>nt",           -- Default keybinding to toggle
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
                FloatBorder = { bg = "cleared" }
            }, -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true,     -- darker colors for diagnostic
                undercurl = true,  -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        }
    },
}
