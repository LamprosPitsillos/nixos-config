return {
    {
        dir = "~/docs/Programming/NEOVIM/Plugins/zografos.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function(_, opts)
            require("zografos").setup()
        end
    }
}
