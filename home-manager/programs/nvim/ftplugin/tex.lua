local kmap = vim.keymap
vim.api.nvim_buf_create_user_command(0,"SSubscript",function ()
vim.api.nvim_feedkeys([[:'<,'>s/\(x\)\(\S\)/\1_\2 /g]],"v",true)
end,{})

vim.api.nvim_buf_create_user_command(0,"SDMatrix",

function (opts)

        local search = vim.fn.search
        local cmd,and_then,execute =":", " | ", "<cr>"
        
        local select_matrix = "v/]<cr>jo<esc>"
        local fix_last_bracket = "/]<cr>i<cr><esc>"
        local replace_brackets = [['<,'>s/\(\[\)/\\begin{Matrix}/g | '<,'>s/\(\]\)/\\end{Matrix}/g]]
        local replace_dots = [['<,'>s/\(⋯\)/\\hdots/g | '<,'>s/\(⋮\)/\\vdots/g | '<,'>s/\(⋱\)/\\ddots/g]]

        local goto_after_first_bracket = [[ execute search("begin{Matrix}","b") | norm j]]
        local call_fix_rowscols = "SFixMatrixRC " .. opts.fargs[1] .. " " .. opts.fargs[2]
        
        local macro =
        select_matrix
            ..fix_last_bracket 
        ..cmd
        ..replace_brackets 
        ..and_then
        ..replace_dots
        ..and_then
        ..goto_after_first_bracket
        ..execute
        ..cmd
        ..call_fix_rowscols
        ..execute

        local keys = vim.api.nvim_replace_termcodes(macro, true, true, true)
        vim.api.nvim_feedkeys(keys, "n", true)
end
     ,{nargs = "*"})

vim.api.nvim_buf_create_user_command(0,"SMatrix",
function (opts)
        local search = vim.fn.search
        local cmd,and_then,execute =":", " | ", "<cr>"
    local rows = opts.fargs[1]
    local cols =opts.fargs[2]
        local select_matrix = "v/]<cr>jo<esc>"
        local fix_last_bracket = "/]<cr>i<cr><esc>"
        local replace_brackets = [['<,'>s/\(\[\)/\\begin{Matrix}/g | '<,'>s/\(\]\)/\\end{Matrix}/g]]

        local goto_after_first_bracket = [[ execute search("begin{Matrix}","b") | norm j]]
        local call_fix_rowscols = "SFixMatrixRC " .. rows .. " " .. cols
        
        local macro =
        select_matrix
            ..fix_last_bracket 
        ..cmd
        ..replace_brackets 
        ..and_then
        ..goto_after_first_bracket
        ..execute
        ..cmd
        ..call_fix_rowscols
        ..execute

        local keys = vim.api.nvim_replace_termcodes(macro, true, true, true)
        vim.api.nvim_feedkeys(keys, "n", true)
        --
        -- vim.cmd(
        -- replace_brackets 
        -- ..and_then
        -- ..replace_dots
        -- ..goto_after_first_bracket
        --     ..and_then
        --     ..call_fix_rowscols
        -- ..execute
        -- )
    --     SFixMatrixRC(opts)
    -- vim.cmd([['<,'>s/\(\[\)/\\begin{Matrix}/gc | '<,'>s/\(\]\)/\\end{Matrix}/gc ]])
    -- vim.cmd([['<,'>s/\(⋯\)/\\hdots/gc]])
    -- vim.cmd([['<,'>s/\(⋮\)/\\vdots/gc]])
    -- vim.cmd([['<,'>s/\(⋱\)/\\ddots/gc]])
end
     ,{nargs = "*"})

function SNMatrix (opts)
        local search = vim.fn.search
    local rows = opts.fargs[1]
    local cols =opts.fargs[2]
    local arraycols = ( "r"):rep(cols)
        local cmd,and_then,execute =":", " | ", "<cr>"
        
        local select_matrix = "v/]<cr>jo<esc>"
        local fix_last_bracket = "/]<cr>i<cr><esc>"
        local replace_brackets = [['<,'>s/\(\[\)/\\begin{NMatrix}{]]..arraycols .. [[}/g | '<,'>s/\(\]\)/\\end{NMatrix}/g]]

        local goto_after_first_bracket = [[ execute search("begin{NMatrix}","b") | norm j]]
        local call_fix_rowscols = "SFixMatrixRC " .. rows .. " " .. cols
        local macro =
        select_matrix
            ..fix_last_bracket 
        ..cmd
        ..replace_brackets 
        ..and_then
        ..goto_after_first_bracket
        ..execute
        ..cmd
        ..call_fix_rowscols
        ..execute

        local keys = vim.api.nvim_replace_termcodes(macro, true, true, true)
        vim.api.nvim_feedkeys(keys, "n", true)
end

vim.api.nvim_buf_create_user_command(0,"SNMatrix",
     SNMatrix,{nargs ="*"})


    function SFixMatrixRC(opts)
        local rows = opts.fargs[1]
        local cols = opts.fargs[2]
        for _ = 1, rows do
            for _ = 1, cols -1 do
                vim.api.nvim_feedkeys([[A&J]], "n", true)
            end
            vim.api.nvim_feedkeys([[A\\j]], "n", true)
        end
    end

vim.api.nvim_buf_create_user_command(0, "SFixMatrixRC",
    SFixMatrixRC,
    { nargs = "*" })

