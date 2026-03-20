return {
    "ravitemer/mcphub.nvim",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("mcphub").setup({
        })
    end,
}
