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
        spec = { import = "plugins" },
        git = {
            -- defaults for the `Lazy log` command
            -- log = { "-10" }, -- show the last 10 commits
            log = { "-8" }, -- show commits from the last 3 days
            timeout = 120,  -- kill processes that take more than 2 minutes
            url_format = "https://github.com/%s.git",
            -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
            -- then set the below to false. This should work, but is NOT supported and will
            -- increase downloads a lot.
            filter = true,
        },
        dev = {
            -- directory where you store your local plugin projects
            path = "~/docs/Programming/NEOVIM/Plugins",
            ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
            patterns = {},    -- For example {"folke"}
            fallback = false, -- Fallback to git when local plugin doesn't exist
        },
        install = {
            -- install missing plugins on startup. This doesn't increase startup time.
            missing = true,
            -- try to load one of these colorschemes when starting an installation during startup
            colorscheme = { "onedark" },
        },
        lockfile = vim.env.NIXOS_CONFIG_PATH and
            vim.env.NIXOS_CONFIG_PATH .. "/home-manager/programs/nvim/lazy-lock.json" or nil,
    }
)
