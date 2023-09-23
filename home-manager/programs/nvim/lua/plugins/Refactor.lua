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
}
