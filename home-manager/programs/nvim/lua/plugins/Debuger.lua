return {
    {
        "mfussenegger/nvim-dap",
        enabled = true,
        lazy = true,
        dependencies = { "nvim-neotest/nvim-nio", "rcarriga/nvim-dap-ui", 'jbyuki/one-small-step-for-vimkind' },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local b_map = vim.api.nvim_buf_set_keymap
            local map = vim.keymap.set

            local function set_terminal_keymaps()
                local opts = {
                    noremap = true,
                }
                b_map(0, "t", "<esc>", [[<C-\><C-n>]], opts)
                b_map(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], opts)
                b_map(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], opts)
                b_map(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], opts)
                b_map(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], opts)
                b_map(0, "t", "<A-Right>", [[<C-\><C-n><C-W>2>]], opts)
                b_map(0, "t", "<A-Up>", [[<C-\><C-n><C-W>2+]], opts)
                b_map(0, "t", "<A-Down>", [[<C-\><C-n><C-W>2-]], opts)
                b_map(0, "t", "<A-Left>", [[<C-\><C-n><C-W>2<]], opts)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dap-repl",
                callback = function(args)
                    vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
                end,
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "dapui_console",
                callback = set_terminal_keymaps
            })

            -- dap.adapters.codelldb = {
            --     type = "server",
            --     port = "${port}",
            --     executable = {
            --         command = "/home/inferno/docs/Packages/LLVMdebug/adapter/codelldb",
            --         args = { "--port", "${port}" },
            --     }
            -- }
            -- dap.configurations.cpp = {
            --     {
            --         name = "Launch file",
            --         type = "codelldb",
            --         request = "launch",
            --         program = function()
            --             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            --         end,
            --         cwd = "${workspaceFolder}",
            --         stopOnEntry = true,
            --     },
            -- }
            -- dap.configurations.c = dap.configurations.cpp
            -- dap.configurations.rust = dap.configurations.cpp
            --
            --
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
            dap.configurations.cpp = dap.configurations.c
            dap.configurations.rust = dap.configurations.c

            local dap = require("dap")
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }

            dap.configurations.lua = {
                {
                    type = 'nlua',
                    request = 'attach',
                    name = "Attach to running Neovim instance",
                }
            }

            dap.adapters.nlua = function(callback, config)
                callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
            end

            map("n", "<F1>", dap.continue, { desc = "Debbuger continue" })
            map("n", "<F2>", dap.step_over, { desc = "Debbuger step_over" })
            map("n", "<F3>", dap.step_into, { desc = "Debbuger step_into" })
            map("n", "<F4>", dap.step_out, { desc = "Debbuger step_out" })
            map("n", "<F12>", dap.toggle_breakpoint, { desc = "Debbuger toggle_breakpoint" })
            map("n", "<Leader><F12>", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
                { desc = "Debbuger breakpoint " })
            map("n", "<Leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
                { desc = "Debbuger breakpoint" })
            map("n", "<Leader>dr", function() dap.repl.open() end, { desc = "Debbuger repl.open" })
            map("n", "<Leader>dl", function() dap.run_last() end, { desc = "Debbuger run_last" })
            map("n", "<F10>", dapui.toggle, { desc = "Toggle Debbuger UI" })

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        enabled = true,
        lazy = true,
        opts = {
            icons = { expanded = "", collapsed = "", current_frame = "" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Expand lines larger than the window
            expand_lines = true,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
                {
                    elements = {
                        -- Elements can be strings or table with id and size keys.
                        "watches",
                        "breakpoints",
                        "repl",
                        "stacks",
                    },
                    size = 40, -- 40 columns
                    position = "left",
                },
                {
                    elements = {
                        "scopes",
                        "console",
                    },
                    size = 0.25, -- 25% of total lines
                    position = "bottom",
                },
            },
            floating = {
                max_height = nil,  -- These can be integers or a float between 0 and 1.
                max_width = nil,   -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
            }
        }
    },
}
