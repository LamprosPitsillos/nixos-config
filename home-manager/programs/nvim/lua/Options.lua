vim.opt.title = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamed"
vim.opt.cmdheight = 1
vim.opt.compatible = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 2
-- vim.opt.concealcursor = 'n'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.pumblend = 15
vim.opt.pumheight = 20
vim.opt.relativenumber = true
vim.opt.scroll = 5
vim.opt.iskeyword:remove('_')
vim.opt.showcmd = true
vim.opt.sidescroll = 8
vim.opt.sidescrolloff = 8
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undodir = "/home/inferno/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.diffopt:append("linematch:60")
vim.opt.virtualedit = "onemore"
vim.opt.linebreak = true

-- vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.cmd.iabbr({ args = { "cosnt", "const" } })
vim.cmd.iabbr({ args = { "csnt", "const" } })
vim.cmd.iabbr({ args = { "costn", "const" } })
vim.cmd.iabbr({ args = { "youre", "you are" } })

local cmd_regex_abbr_prefix = '@'

---Abbreviations to use in substitude for lesser friction
---@param lhs string
---@param rhs string
local function rabbr(lhs, rhs)
    vim.cmd.cabbr({ args = { cmd_regex_abbr_prefix .. lhs, rhs } })
end

-- TEST: just an experiment
rabbr("w", [[(\S+)]])
rabbr("W", [[\S+]])
-- rabbr("or", [[(|)]])

-- vim.o.foldenable = true
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.statuscolumn = "%=%r%s%C"

vim.opt.langmap = {
    "ΑA", "ΒB", "ΨC", "ΔD", "ΕE", "ΦF", "ΓG", "ΗH", "ΙI", "ΞJ", "ΚK", "ΛL", "ΜM", "ΝN",
    "ΟO", "ΠP", "QQ", "ΡR", "ΣS", "ΤT", "ΘU", "ΩV", "WW", "ΧX", "ΥY", "ΖZ",
    "αa", "βb", "ψc", "δd", "εe", "φf", "γg", "ηh", "ιi", "ξj", "κk", "λl", "μm", "νn",
    "οo", "πp", "qq", "ρr", "σs", "τt", "θu", "ωv", "ςw", "χx", "υy", "ζz",
}
vim.opt.spelllang = { 'en_us', 'el' }

vim.g.no_man_maps = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ","

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h14"

    vim.g.neovide_scale_factor = 1.0

    local function change_scale_factor(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

    vim.keymap.set("n", "<C-+>", function() change_scale_factor(1.25) end)
    vim.keymap.set("n", "<C-_>", function() change_scale_factor(1 / 1.25) end)

    local function alpha()
        return string.format("%x", math.floor(255 * (vim.g.neovide_transparency_point or 0.8)))
    end
    -- Set transparency and background color (title bar color)
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_transparency_point = 0.8
    vim.g.neovide_background_color = "#0f1117" .. alpha()
    -- Add keybinds to change transparency
    local function change_transparency(delta)
        vim.g.neovide_transparency_point = vim.g.neovide_transparency_point + delta
        vim.g.neovide_background_color = "#0f1117" .. alpha()
    end
    vim.keymap.set({ "n", "v", "o" }, "<C-}>", function()
        change_transparency(0.01)
    end)
    vim.keymap.set({ "n", "v", "o" }, "<C-{>", function()
        change_transparency(-0.01)
    end)
end
