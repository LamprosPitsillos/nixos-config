local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(
    {
        spec = {import = "plugins"},
        lockfile = vim.env.NIXOS_CONFIG_PATH and vim.env.NIXOS_CONFIG_PATH .. "/home-manager/programs/nvim/lazy-lock.json" or nil,
    }
)
