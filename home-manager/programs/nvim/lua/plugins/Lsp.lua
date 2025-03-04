return {
    {
        "neovim/nvim-lspconfig",

        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {}, },
            'saghen/blink.cmp' },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }


            local border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            }

            local lsp = require("lspconfig")
            lsp.util.default_config = vim.tbl_extend(
                "force",
                lsp.util.default_config,
                {
                    autostart = true,
                    handlers = {
                        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                            border = border,
                        }),
                        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                            border = border,
                        })
                    }
                }
            )
            vim.diagnostic.config({
                underline = true,
                virtual_text = {
                    prefix = " ", -- Could be '●', '▎', 'x'
                    spacing = 4,
                },
                -- virtual_text = false ,
                update_in_insert = true,
            })
            local servers = {
                jsonls = {},
                bashls = {},
                ruff = {},
                phpactor = {},
                dotls = {},
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                ruff = {
                                    enabled = true,
                                    extendSelect = { "I" },
                                },
                            }
                        }
                    }
                },
                cmake = {},
                html = {},
                tinymist = {
                    settings = {
                        formatterMode = "typstfmt",
                        formatterPrintWidth = 90
                    }
                },
                -- typst_lsp = {
                --     settings = {
                --         exportPdf = "onType" -- Choose onType, onSave or never.
                --         -- serverPath = "" -- Normally, there is no need to uncomment it.
                --     }
                -- },
                cssls = {},
                quick_lint_js = {},
                prismals = {
                    cmd = {
                        "prisma-language-server",
                        "--stdio" },
                    {
                        prisma = {
                            prismaFmtBinPath =
                            "/nix/store/hmxi33qpcc3w2lk3z8n5v69pb3bcqd3i-prisma-engines-4.13.0/bin/prisma-fmt"
                        }
                    }
                },
                nil_ls = {},
                zls = {},
                rust_analyzer = {},
                sqlls = {},
                clangd = {
                    cmd = {
                        vim.env.CLANGD_PATH or "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "-j=4",
                        "--clang-tidy-checks=*",
                        "--all-scopes-completion",
                        "--cross-file-rename",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        -- "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                },
                tailwindcss = {
                    filetypes = { "vue", "javascriptreact", "typescriptreact" }
                },
                texlab = {},
                volar = {
                    -- add filetypes for typescript, javascript and vue
                    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                    init_options = {
                        vue = {
                            -- disable hybrid mode
                            hybridMode = false,
                        },
                    },
                },
                ts_ls = {
                    -- init_options = {
                    --     hostInfo = "neovim",
                    --     plugins = {
                    --         {
                    --             name = '@vue/typescript-plugin',
                    --             location = vim.fn.exepath("vue-language-server") ..
                    --                 '/../../lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin',
                    --             languages = { 'typescript', 'javascript', 'vue' },
                    --         },
                    --     },
                    -- },
                    -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                },
                svelte = {},
                marksman = {},
                lua_ls = {
                    -- on_attach = function(client, bufnr)
                    --     vim.lsp.semantic_tokens.stop(bufnr, client.id)
                    -- end,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                        },
                    },
                },
            }

            for name, config in pairs(servers) do
                capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lsp[name].setup({
                    init_options = config.init_options,
                    on_attach = config.on_attach,
                    capabilities = capabilities,
                    cmd = config.cmd,
                    filetypes = config.filetypes,
                    settings = config.settings
                })
            end

            require("typescript-tools").setup {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
                settings = {
                    -- spawn additional tsserver instance to calculate diagnostics on it
                    separate_diagnostic_server = true,
                    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                    publish_diagnostic_on = "change",
                    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
                    -- "remove_unused_imports"|"organize_imports") -- or string "all"
                    -- to include all supported code actions
                    -- specify commands exposed as code_actions
                    expose_as_code_action = {},
                    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                    -- not exists then standard path resolution strategy is applied
                    tsserver_path = nil,
                    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                    -- (see 💅 `styled-components` support section)
                    tsserver_plugins = {
                        "@vue/typescript-plugin"
                    },
                    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                    -- memory limit in megabytes or "auto"(basically no limit)
                    tsserver_max_memory = "auto",
                    -- described below
                    tsserver_format_options = {},
                    tsserver_file_preferences = {},
                    -- locale of all tsserver messages, supported locales you can find here:
                    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
                    tsserver_locale = "en",
                    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
                    complete_function_calls = true,
                    include_completions_with_insert_text = true,
                    -- CodeLens
                    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
                    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
                    code_lens = "off",
                    -- by default code lenses are displayed on all referencable values and for some of you it can
                    -- be too much this option reduce count of them by removing member references from lenses
                    disable_member_code_lens = true,
                },
            }

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    --
                    local diagnostic        = vim.diagnostic
                    local lsp_b             = vim.lsp.buf
                    local map               = vim.keymap.set

                    -- default in neovim 0.10
                    -- map("n", "[d", diagnostic.goto_prev, { desc = "prev error", buffer = ev.buf })
                    -- map("n", "]d", diagnostic.goto_next, { desc = "next error", buffer = ev.buf })
                    map("n", "<leader>lD", lsp_b.declaration, { desc = "declaration", buffer = ev.buf })
                    map("n", "<leader>lt", lsp_b.type_definition, { desc = "type definition", buffer = ev.buf })
                    map("n", "<leader>lpa", lsp_b.add_workspace_folder,
                        { desc = "add workspace folder", buffer = ev.buf })
                    map("n", "<leader>lpl", function() print(vim.inspect(lsp_b.list_workspace_folders())) end,
                        { desc = "list workspace folders", buffer = ev.buf })
                    map("n", "<leader>lpr", lsp_b.remove_workspace_folder,
                        { desc = "remove workspace folder", buffer = ev.buf })
                    map("n", "<leader>li", lsp_b.implementation, { desc = "Show implementation", buffer = ev.buf })
                    map("n", "<leader>lh", "<cmd>Ouroboros<cr>", { desc = "Switch header", buffer = ev.buf })
                    map("n", "<leader>cr", lsp_b.rename, { desc = "rename", buffer = ev.buf })
                    map("n", "<leader>ca", lsp_b.code_action, { desc = "code action", buffer = ev.buf })
                    map("v", "<leader>ca", lsp_b.code_action, { desc = "code action", buffer = ev.buf })
                    map("n", "<leader>ce", diagnostic.open_float, { desc = "show line diagnostics", buffer = ev.buf })
                    map("n", "<leader>dt", function()
                        if vim.b.diagnostics == true then
                            vim.b.diagnostics = false
                            diagnostic.disable()
                        else
                            vim.b.diagnostics = true
                            diagnostic.enable()
                        end
                    end, { desc = "show line diagnostics", buffer = 0 })
                    map("n", "<leader>cs", lsp_b.signature_help, { desc = "signature help", buffer = ev.buf })
                    map("n", "K", lsp_b.hover, { desc = "hover", buffer = ev.buf })
                    map("n", "<space>=", function() lsp_b.format({ async = true }) end,
                        { desc = "formatting", buffer = ev.buf })
                    map("n", "<leader>lI",
                        function() vim.lsp.inlay_hint.enable(ev.buf, not vim.lsp.inlay_hint.is_enabled(ev.buf)) end,
                        { desc = "Toggle inlay hints", buffer = ev.buf }

                    )
                end,
            })
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- vim.env.LAZY .. "/luvit-meta/library", -- see below
                -- You can also add plugins you always want to have loaded.
                -- Useful if the plugin has globals or types you want to use
                -- vim.env.LAZY .. "/LazyVim", -- see below
            },
        },
    },
}
