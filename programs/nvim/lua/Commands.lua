local function insert_text_around_selection(text, symbol, width)
    -- Get the current buffer and the start and end of the selected range
    local s_line = vim.fn.getpos("v")[2]
    local e_line = vim.fn.getpos(".")[2]
    if e_line < s_line then
        s_line, e_line = e_line, s_line
    end

    vim.api.nvim_buf_set_lines(0, s_line - 1, s_line - 1, false, { text .. string.rep(symbol[1], width) })
    vim.api.nvim_buf_set_lines(0, e_line + 1, e_line + 1, false, { text .. string.rep(symbol[#symbol], width) })
end


vim.keymap.set({ "v" }, "<leader>s", function()
    -- Prompt the user for input
    --
    local style = {
        sin    = { "⠁⠂⠄⠄⠂⠁" }, -- ⠁⠂⠄⠄⠂⠁⠁⠂⠄⠂⠁⠁⠂⠄⠄⠂⠁⠁⠂⠄|⠄⠂⠁⠁⠂⠄⠄⠂⠁⠁⠂⠄⠂⠁⠁⠂⠄⠄⠂⠁⠁
        line1  = { "= " }, -- ====================|=====================
        line2  = { "-" }, -- --------------------|---------------------
        arrow1 = { ">", "<" }, -- >>>>>>>>>>>>>>>>>>>>|<<<<<<<<<<<<<<<<<<<<<
    }
    local user_input = vim.fn.input("Enter some text (including comment symbol): ")
    insert_text_around_selection(user_input, style.arrow1, 80)
end)


vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = "*.pdf",
    callback = function(ev)
        local filename = ev.file
        vim.fn.jobstart({ "xdg-open", filename }, { detach = true })
        require("mini.bufremove").delete(0, false)
    end
})
vim.api.nvim_create_user_command("DiffOrig", function()
    -- Get start buffer
    local start = vim.api.nvim_get_current_buf()

    -- `vnew` - Create empty vertical split window
    -- `set buftype=nofile` - Buffer is not related to a file, will not be written
    -- `0d_` - Remove an extra empty start row
    -- `diffthis` - Set diff mode to a new vertical split
    vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")

    -- Get scratch buffer
    local scratch = vim.api.nvim_get_current_buf()

    -- `wincmd p` - Go to the start window
    -- `diffthis` - Set diff mode to a start window
    vim.cmd("wincmd p | diffthis")

    -- Map `q` for both buffers to exit diff view and delete scratch buffer
    for _, buf in ipairs({ scratch, start }) do
        vim.keymap.set("n", "q", function()
            vim.api.nvim_buf_delete(scratch, { force = true })
            vim.keymap.del("n", "q", { buffer = start })
        end, { buffer = buf })
    end
end, {})

-- https://jdhao.github.io/2019/05/30/markdown2pdf_pandoc/
local function md_to_pdf()
    -- Check if pandoc is installed
    if vim.fn.executable("pandoc") ~= 1 then
        print("Pandoc not found")
        return
    end

    local md_path = vim.fn.expand("%:p")
    local pdf_path = vim.fn.fnamemodify(md_path, ":r") .. ".pdf"

    print(md_path)
    print(pdf_path)
    local cmd = "pandoc -f gfm+hard_line_breaks " .. md_path ..
        " -t pdf --pdf-engine=xelatex -V 'mainfont=Fira Code'" ..
        " -V 'mainfontoptions:BoldFont=Fira Code SemiBold, ItalicFont=JetBrains Mono Italic, BoldItalicFont=JetBrains Mono Bold Italic'" ..
        " -V 'monofont=Fira Mono' -o " .. pdf_path

    if vim.loop.os_uname().sysname == "Darwin" then
        cmd = cmd .. " && xdg-open " .. pdf_path
    elseif vim.loop.os_uname().sysname == "Windows" then
        cmd = cmd .. " && start " .. pdf_path
    end

    local job = vim.fn.jobstart(cmd)
    if job <= 0 then
        print("Error running command")
    end
end

local function tex_to_pdf()
    local cmd = { "tectonic", vim.fn.expand("%"), "--synctex", "--keep-logs", "--keep-intermediates" }
    local job = vim.fn.jobstart(cmd)
    if job <= 0 then
        vim.notify("Error Compiling Latex :: ")
    end
end
local function buf_to_pdf()
    local name = vim.fn.tempname()
    vim.cmd.TOhtml(name)


    -- local html_lines = require("tohtml").tohtml(0, {number_lines=true})

end
vim.api.nvim_create_user_command("ToPDF", md_to_pdf, {})
-- vim.api.nvim_create_user_command("WriteGreek", function()
--     local current_layout = vim.fn.system("setxkbmap -query"):match("layout:%s+(%a+)")
--     print(current_layout)
--     -- if current_layout == "us" then
--     --     vim.fn.system("setxkbmap -layout gr")
--     -- else
--     --    vim.fn.system("setxkbmap -layout us")
--     -- end
-- end
-- , {})

local function extract_text()
    local s_line = vim.fn.getpos("v")[2]
    local e_line = vim.fn.getpos(".")[2]

    local text = ""
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, s_line - 1, e_line + 1, false)) do
        for match in line:gmatch("%*%*(.-)%*%*") do
            text = text .. match .. "\n"
        end
    end
    vim.api.nvim_set_reg("a", text:sub(1, -2))
end

vim.api.nvim_create_user_command("SplitRead", function()
    local winid_tophalf = vim.api.nvim_get_current_win()
    vim.wo[winid_tophalf].scrollbind = false
    -- vim.api.nvim_feedkeys("zt", 'n', false)

    vim.cmd.vsplit()
    local winid_bottomhalf = vim.api.nvim_get_current_win()

    local win_height = vim.api.nvim_win_get_height(winid_bottomhalf)
    local cursor_line = vim.api.nvim_win_get_cursor(winid_bottomhalf)[1]
    vim.api.nvim_win_set_cursor(winid_bottomhalf, { cursor_line + win_height, 0 })
    vim.cmd.norm("zt")

    vim.api.nvim_set_current_win(winid_tophalf)

    vim.cmd.norm("zt")

    vim.wo[winid_tophalf].scrollbind = true
    vim.wo[winid_bottomhalf].scrollbind = true
    vim.wo[winid_bottomhalf].number = false
    vim.wo[winid_bottomhalf].relativenumber = false
end, {})
