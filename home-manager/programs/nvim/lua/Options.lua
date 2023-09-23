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
vim.opt.splitkeep="screen"
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undodir = "/home/inferno/.cache/nvim/undodir"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.diffopt:append("linematch:60")
vim.opt.virtualedit = "onemore"

-- vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

vim.cmd.iabbr({args={"cosnt","const"}})
vim.cmd.iabbr({args={"csnt","const"}})
vim.cmd.iabbr({args={"costn","const"}})
vim.cmd.iabbr({args={"youre","you are"}})


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


vim.g.neovide_window_floating_blur = 0.3
vim.g.neovide_floating_opacity = 0.3
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_font_hinting = 'none'
vim.g.neovide_font_edging = 'subpixelantialias'
vim.g.gui_font_default_size = 8
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Fira Code"

RefreshGuiFont = function()
	vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
	vim.g.gui_font_size = vim.g.gui_font_size + delta
	RefreshGuiFont()
end

ResetGuiFont = function()
	vim.g.gui_font_size = vim.g.gui_font_default_size
	RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-BS>", function() ResetGuiFont() end, opts)
