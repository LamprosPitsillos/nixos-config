vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
    end
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LazySync",
    callback = function()
        vim.fn.jobstart('notify-send "Neovim" "Update Finished" -i pamac-download')
    end
})
