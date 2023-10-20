return {
    { "akinsho/toggleterm.nvim",
        opts = {
            shading_factor = 0,
            hide_numbers = true,
        },
        cmd="ToggleTerm",
        keys={
            { "<A-t>", "<cmd>"..vim.v.count.."ToggleTerm<cr>", desc = "terminal",mode={"i","n"} },
            { "<A-T>", "<cmd>"..vim.v.count.."ToggleTerm direction=vertical <cr>", desc = "terminal",mode={"i","n"} }
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
            map(0, "t", "<A-Right>", [[<cmd>wincmd 2> <cr>]], map_opts)
            map(0, "t", "<A-Up>", [[<cmd>wincmd 2+ <cr>]], map_opts)
            map(0, "t", "<A-Down>", [[<cmd>wincmd 2- <cr>]], map_opts)
            map(0, "t", "<A-Left>", [[<cmd>wincmd 2< <cr>]], map_opts)
            map(0, "n", "<Tab>", "<Nop>", map_opts)
            map(0, "n", "<S-Tab>", "<Nop>", map_opts)
        end
        vim.api.nvim_create_autocmd("TermOpen", { pattern = "term://*", callback = set_terminal_keymaps })
        require("toggleterm").setup(opts)
    end
    }
  --   , {
  --   'mikesmithgh/kitty-scrollback.nvim',
  --   enabled = true,
  --   lazy = true,
  --   cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
  --   -- version = '*', -- latest stable version, may have breaking changes if major version changed
  --   -- version = '^1.0.0', -- pin major version, include fixes and features that do not have breaking changes
  --   config = function()
  --     require('kitty-scrollback').setup()
  --   end,
  -- }
}
