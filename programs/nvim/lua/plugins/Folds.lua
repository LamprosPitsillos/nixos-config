return {
    {
        "kevinhwang91/nvim-ufo",
        lazy = true,
        event = "BufReadPost",
        enabled = true,
        dependencies = { "kevinhwang91/promise-async", {
            "luukvbaal/statuscol.nvim",
            config = function(_, opts)
                local builtin = require("statuscol.builtin")
                require("statuscol").setup(

                    {
                        relculright = true,
                        segments = {
                            {
                                sign = { name = { "Dap*" }, maxwidth = 1, colwidth = 2, auto = true, fillchars = "" },
                                click = "v:lua.ScSa",
                            },
                            {
                                sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
                                click = "v:lua.ScSa"
                            },

                            {
                                sign = { namespace = { "gitsigns" }, colwidth = 1, wrap = true },
                                click = "v:lua.ScSa"
                            },
                            -- {text = { builtin.foldfunc }, click = "v:lua.ScFa"},
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        }

                    }
                )
            end

        } },
        config = function(_, opts)
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰦸 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end

            -- global handler
            -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
            -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
            require('ufo').setup({
                fold_virt_text_handler = handler
            })
        end
    }

}
