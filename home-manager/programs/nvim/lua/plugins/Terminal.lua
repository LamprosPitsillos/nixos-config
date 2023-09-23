return {
    { "akinsho/toggleterm.nvim",
        opts = {
            shading_factor = 0,
            hide_numbers = true,
        },
        cmd="Terminal",
        keys={
            { "<A-t>", function() vim.cmd(vim.v.count .. "ToggleTerm ") end, desc = "terminal",mode={"t","n"} }
        },
        config = function(_,opts)
        local function set_terminal_keymaps()
            map = vim.api.nvim_buf_set_keymap
            local map_opts = {
                noremap = true,
            }
            map(0, "t", "<esc>", [[<C-\><C-n>]], map_opts)
            map(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], map_opts)
            map(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], map_opts)
            map(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], map_opts)
            map(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], map_opts)
            map(0, "t", "<A-Right>", [[<C-\><C-n><C-W>2>]], map_opts)
            map(0, "t", "<A-Up>", [[<C-\><C-n><C-W>2+]], map_opts)
            map(0, "t", "<A-Down>", [[<C-\><C-n><C-W>2-]], map_opts)
            map(0, "t", "<A-Left>", [[<C-\><C-n><C-W>2<]], map_opts)
            map(0, "n", "<Tab>", "<Nop>", map_opts)
            map(0, "n", "<S-Tab>", "<Nop>", map_opts)
        end
        vim.api.nvim_create_autocmd("TermOpen", { pattern = "term://*", callback = set_terminal_keymaps })
        require("toggleterm").setup(opts)
    end
    }
}
