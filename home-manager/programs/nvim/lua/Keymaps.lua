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

local function toCursor(input)
    local result  = ""
    local pattern = "(.*)%{%}(.*)"
    local lhs, rhs = input:match(pattern)
    local count   = #rhs
    result        = lhs .. rhs .. string.rep("<Left>", count)
    return result
end

local function zen()
    if vim.opt.cmdheight:get() == 0 and vim.opt.laststatus:get() == 0 then
        vim.opt.cmdheight = 1
        vim.opt.laststatus = 3
        vim.opt.relativenumber = true
        vim.opt.number = true
        vim.opt.signcolumn = "auto"
        vim.opt.foldcolumn = "auto"
    else
        vim.opt.cmdheight = 0
        vim.opt.laststatus = 0
        vim.opt.relativenumber = false
        vim.opt.number = false
        vim.opt.signcolumn = "no"
        vim.opt.foldcolumn = "0"
    end
end

-- function map_group(group, binds_list)
--     for _, mapping in pairs(binds_list) do
--         map(mapping.mode, group .. mapping.key, mapping.after, mapping.opts)
--     end
-- end

M.map("", "<Space>", "<Nop>", { noremap = true, silent = true, })

--
-- =========================================================================
--

M.nmap("<leader>fn", function()
        vim.ui.input({ prompt = "New file's name: " }, function(input)
            if (input ~= nil) then vim.cmd("e " .. input) end
        end)
    end,
    { desc = "New File" })

M.nmap("<leader>ft", function()
        vim.ui.input({ prompt = "New /tmp file's name: " }, function(input)
            if (input ~= nil) then vim.cmd("e /tmp/" .. input) end
        end)
    end,
    { desc = "New Temp File" })


M.nmap("<C-S-t>", function()
        vim.fn.jobstart({ "kitty", vim.cmd.pwd() })
    end,
    { desc = "New File" })

-- Windows>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

M.nmap("<leader>wH", "<cmd>wincmd H<cr>", { desc = "move window to the far left" })
M.nmap("<leader>wJ", "<cmd>wincmd J<cr>", { desc = "move window to the very bottom" })
M.nmap("<leader>wK", "<cmd>wincmd K<cr>", { desc = "move window to the very top" })
M.nmap("<leader>wL", "<cmd>wincmd L<cr>", { desc = "move window to the far right" })

M.nmap("<leader>wP", "<cmd>wincmd P<cr>", { desc = "go to preview window" })
M.nmap("<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate windows upwards N times" })
M.nmap("<leader>wT", "<cmd>wincmd T<cr>", { desc = "move current window to a new tab page" })
M.nmap("<leader>w]", "<cmd>wincmd ]<cr>", { desc = "split window and jump to tag under cursor" })
M.nmap("<leader>w^", "<cmd>wincmd ^<cr>", { desc = "split current window and edit alternate file N" })
M.nmap("<leader>wd", "<cmd>wincmd d<cr>", { desc = "split window and jump to definition under the cursor" })
M.nmap("<leader>wf", "<cmd>wincmd f<cr>", { desc = "split window and edit file name under the cursor" })
M.nmap("<leader>wF", "<cmd>wincmd F<cr>",
    { desc = "split window and edit file name under the cursor and jump to the line number following the file name." })
M.nmap("<leader>wi", "<cmd>wincmd i<cr>",
    { desc = "split window and jump to declaration of identifier under the cursor" })
M.nmap("<leader>wn", "<cmd>wincmd n<cr>", { desc = "open new window, N lines high" })
M.nmap("<leader>wo", "<cmd>wincmd o<cr>", { desc = "close all but current window (like |:only|)" })
M.nmap("<leader>wp", "<cmd>wincmd p<cr>", { desc = "go to previous (last accessed) window" })
M.nmap("<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate windows downwards N times" })
M.nmap("<leader>wt", "<cmd>wincmd t<cr>", { desc = "go to top window" })

M.nmap("<leader>ws", "<cmd>wincmd s<cr>", { desc = "split current window in two parts, new window N lines high" })
M.nmap("<leader>wv", "<cmd>wincmd v<cr>", { desc = "split current window vertically, new window N columns wide" })

M.nmap("<leader>wW", "<cmd>wincmd W<cr>", { desc = "go to N previous window (wrap around)" })
M.nmap("<leader>ww", "<cmd>wincmd w<cr>", { desc = "go to N next window (wrap around)" })
M.nmap("<leader>wx", "<cmd>wincmd x<cr>", { desc = "exchange current window with window N (default: next window)" })
M.nmap("<leader>wz", "<cmd>wincmd z<cr>", { desc = "close preview window" })
M.nmap("<leader>w=", "<cmd>wincmd =<cr>", { desc = "equalise window sizes to fit screen" })
M.nmap("<leader>w}", "<cmd>wincmd }<cr>", { desc = "show tag under cursor in preview window" })

M.imap("<A-k>", "<cmd>wincmd k<cr>", { desc = "up" })
M.imap("<A-l>", "<cmd>wincmd l<cr>", { desc = "right" })
M.imap("<A-j>", "<cmd>wincmd j<cr>", { desc = "down" })
M.imap("<A-h>", "<cmd>wincmd h<cr>", { desc = "left" })
M.imap("<A-Up>", "<cmd>2wincmd +<cr>", { desc = "increase" })
M.imap("<A-Right>", "<cmd>2wincmd ><cr>", { desc = "right" })
M.imap("<A-Left>", "<cmd>2wincmd <<cr>", { desc = "left" })
M.imap("<A-Down>", "<cmd>2wincmd -<cr>", { desc = "decrease" })
M.nmap("<A-l>", "<cmd>wincmd l<cr>", { desc = "right" })
M.nmap("<A-k>", "<cmd>wincmd k<cr>", { desc = "up" })
M.nmap("<A-j>", "<cmd>wincmd j<cr>", { desc = "down" })
M.nmap("<A-h>", "<cmd>wincmd h<cr>", { desc = "left" })
M.nmap("<A-Up>", "<cmd>2wincmd +<cr>", { desc = "increase" })
M.nmap("<A-Right>", "<cmd>2wincmd ><cr>", { desc = "right" })
M.nmap("<A-Left>", "<cmd>2wincmd <<cr>", { desc = "left" })
M.nmap("<A-Down>", "<cmd>2wincmd -<cr>", { desc = "decrease" })
M.nmap("<leader>wq", "<cmd>wincmd q<cr>", { desc = "quit" })

-- Windows<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



-- M.nmap("<A-s>", ":source %<cr>", { desc = "source file" })
M.nmap("<S-Tab>", "<cmd>bprev<cr>", {})
M.nmap("<Tab>", "<cmd>bnext<cr>", {})
M.nmap("<leader>pu", "<cmd>Lazy update<cr>", { desc = "update" })
M.nmap("<leader>pp", "<cmd>Lazy profile<cr>", { desc = "profile" })

-- Replace >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
M.vmap("rb", [[:s/\%V\v]], { desc = "replace in block" })
M.nmap("<leader>ra", "zz" .. toCursor([[:.,$s/\({}\)/gc]]), { desc = "replace from here" })
M.vmap("<leader>ra", "zz" .. toCursor([["ry:.,$s/\(<c-r>r\)/{}/gc]]), { desc = "replace selection from here" })
M.nmap("<leader>rl", toCursor([[:s/\v({})]]), { desc = "replace in line" })
M.vmap("<leader>rl", toCursor([["ry:s/\(<c-r>r\)/{}/g]]), { desc = "replace selection in line" })
M.nmap("<leader>rf", toCursor([[:%s/\v({})]]), { desc = "replace everywhere" })
M.vmap("<leader>rf", toCursor([["ry:%s/\(<c-r>r\)/{}/g]]), { desc = "replace selection everywhere" })
M.vmap("<leader>re", toCursor([["ry:.,$s/\<<c-r>r\>/{}/gc]]), { desc = "search exact" })
-- Replace <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- Search >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
M.nmap("<leader>sn", "/", { desc = "search basic" })
M.nmap("<leader>sy", [[/<c-r>"]], { desc = "search yank" })
M.nmap("<leader>se", toCursor([[/\<{}\>]]), { desc = "search exact" })
-- Search <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


-- Quality of Life >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- M.nmap("<leader>sc","<cmd>nohl<cr>",{desc="Clear screen"})
M.vmap("x", [["_d]], {})
M.vmap("p", [["_dhp]], {})
M.vmap("y", "y`]", { desc = "yank" })
M.nmap("zh", "zH", {})
M.nmap("zl", "zL", {})
M.imap("<C-c>", "<esc>cgn", { desc = "change next" })
M.nmap("<C-u>", "<C-u>zz", { desc = "scroll up" })
M.nmap("<C-d>", "<C-d>zz", { desc = "scroll down" })
-- M.cmap("<A-j>", "<Down>", { desc = "Down history" })
-- M.cmap("<A-k>", "<Up>", { desc = "Up history" })
M.cmap("<C-h>", "<Left>", { desc = "Left" })
M.cmap("<C-l>", "<Right>", { desc = "Right" })


M.nmap("<C-s>", "<cmd>w<cr>", {})
M.nmap("N", "Nzz", {})
M.nmap("n", "nzz", {})
M.nmap("X", '"_dd', {})
M.nmap("gP", "<cmd>pu! *<cr>", {})
M.nmap("gp", "<cmd>pu *<cr>", {})
M.nmap("n", "nzz", {})
M.nmap("x", '"_x', { desc = "remove text" })
M.nmap("yY", "^y$", {})
M.nmap("dD", "^d$", {})
M.vmap("<C-k>", ":m '<-2<CR>gv=gv", { desc = "move line up" })
M.vmap("<C-j>", ":m '>+1<CR>gv=gv", { desc = "move line down" })
M.vmap(">", ">gv", { desc = "indent right" })
M.vmap("<", "<gv", { desc = "indent left" })
-- Quality of Life <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

M.nmap("]q", "<cmd>:cnext<cr>", { desc = "Down history" })
M.nmap("[q", "<cmd>:cprev<cr>", { desc = "Up history" })
M.nmap("<leader>gg", "<cmd>Neogit<cr>", { desc = "Up history" })



M.nmap("<leader>vz", zen, { desc = "[v]isual [z]en" })
vim.keymap.set("n", "<F11>", function()
    vim.opt.spell = not vim.opt.spell:get()
end, { desc = "enable spelling" })


return M
