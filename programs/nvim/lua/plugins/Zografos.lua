return {
    {
        dir = "~/docs/Programming/NEOVIM/Plugins/zografos.nvim",
        enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function(_, opts)
            require("zografos").setup()
        end
    }
}
