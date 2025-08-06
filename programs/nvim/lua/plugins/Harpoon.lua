return {
    {
        "ThePrimeagen/harpoon",
        enabled = false,
        dependancies = "nvim-lua/plenary.nvim",
        config = function(_, opts)
            require("harpoon").setup()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            vim.keymap.set("n", "<leader>ha", function() mark.add_file() end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>hj", function() ui.nav_file(1) end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>hk", function() ui.nav_file(2) end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>hl", function() ui.nav_file(3) end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>hh", function() ui.nav_file(4) end, { desc = "Harpoon add file" })
            vim.keymap.set("n", "<leader>hm", function() ui.toggle_quick_menu() end, { desc = "Harpoon add file" })
        end
    }

}
