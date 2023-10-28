vim.cmd.iabbrev({ args = { "<buffer>", "i", "I" } })
vim.wo.wrap = true
vim.keymap.set("n", "j", "gj", { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "k", "gk", { silent = true, noremap = true, buffer = 0 })
