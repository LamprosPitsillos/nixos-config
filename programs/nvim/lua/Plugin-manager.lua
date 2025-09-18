-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        spec = { import = "plugins" },
        git = {
            log = { "-8" },
            timeout = 120,
            url_format = "https://github.com/%s.git",
            filter = true,
        },
        dev = {
            path = "~/dev/NEOVIM/plugins",
            patterns = {},
            fallback = false,
        },
        install = {
            missing = true,
            colorscheme = { "onedark" },
        },
        lockfile = vim.env.NIXOS_CONFIG_PATH and
            vim.env.NIXOS_CONFIG_PATH .. "/programs/nvim/lazy-lock.json" or nil,
    }
)
