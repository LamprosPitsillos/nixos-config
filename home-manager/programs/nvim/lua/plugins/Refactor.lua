return {
    {
        "napmn/react-extract.nvim",
        ft = "javascriptreact",
        config = function()
            require("react-extract").setup()
            vim.keymap.set({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file)
            vim.keymap.set({ "v" }, "<Leader>rc", require("react-extract").extract_to_current_file)
        end
    }
    ,
 {
        "cshuaimin/ssr.nvim",
        lazy =true,
        config = function()
            require("ssr").setup {
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                },
                vim.keymap.set({ "n", "x" }, "<leader>rs", function() require("ssr").open() end)
            }
        end,
    },
}
