vim.keymap.set("n", "q", function()
    local bufs_all = vim.api.nvim_list_bufs()
    local bufs_listed = vim.tbl_filter(function(buf)
        if (vim.fn.buflisted(buf) == 1) then return true
        else return false
        end
    end, bufs_all)
    if (#bufs_listed == 1) then vim.api.nvim_cmd({ cmd = "quit" }, {})
    else vim.api.nvim_buf_delete(0, {})
    end
end)
