local M = {}

M.map   = vim.keymap.set

function M.nmap(before, after, opts)
    opts.noremap = true
    M.map("n", before, after, opts)
end

function M.imap(before, after, opts)
    opts.noremap = true
    M.map("i", before, after, opts)
end

function M.cmap(before, after, opts)
    opts.noremap = true
    M.map("c", before, after, opts)
end

function M.vmap(before, after, opts)
    opts.noremap = true
    M.map("v", before, after, opts)
end

function M.tmap(before, after, opts)
    opts.noremap = true
    M.map("t", before, after, opts)
end

---@param input string -- A string with special chars '{}' set on
---the possition the cursor should be.
---@return string
--- Returns a string that can be used in command line keymaps
---ex. `[[:.,$s/\({}\)/gc]]`
---    `[[:.,$s/\(\)/gc<Left><Left><Left><Left><Left>]]`
function M.toCursor(input)
    local pattern  = "(.*)%{%}(.*)"
    local lhs, rhs = input:match(pattern)
    local count    = #rhs
    return lhs .. rhs .. string.rep("<Left>", count)
end

return M
