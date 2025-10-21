return {
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        dependencies = {
            { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {}, },
            'saghen/blink.cmp' },
        config = function()
            local vue_language_server_path = vim.fs.dirname(vim.fn.exepath("vue-language-server")) ..
                "/../lib/language-tools/packages/language-server/node_modules/@vue/typescript-plugin"
            -- local vue_language_server_path = vim.fs.dirname(vim.fn.exepath("vue-language-server")) ..
            -- "/../lib/language-tools/packages/typescript-plugin/"
            local vue_plugin = {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
                configNamespace = 'typescript',
                enableForWorkspaceTypeScriptVersions = true,
            }
            require("typescript-tools").setup {
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
                    tsserver_plugins = {},
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
                    complete_function_calls = false,
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

            local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
            local vtsls_config = {
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                vue_plugin,
                            },
                        },
                    },
                },
                filetypes = tsserver_filetypes,
            }

            local vue_ls_config = {}
            vim.lsp.config('vtsls', vtsls_config)
            vim.lsp.config('vue_ls', vue_ls_config)

            vim.lsp.enable({ 'vtsls', 'vue_ls' }) -- If using `ts_ls` replace `vtsls` to `ts_ls`

            local lsp = vim.lsp

            vim.diagnostic.config({
                underline = true,
                virtual_text = {
                    prefix = " ", -- Could be '●', '▎', 'x'
                    source = "if_many",
                    spacing = 4,
                    severity_sort = true,
                },
                -- virtual_text = false ,
                update_in_insert = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰋗 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
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
                -- vtsls = {
                --
                --     settings = {
                --         vtsls = {
                --             tsserver = {
                --                 globalPlugins = {
                --                     vue_plugin,
                --                 },
                --             },
                --         },
                --     },
                --     filetypes = tsserver_filetypes,
                -- },
                -- vue_ls = {
                -- },
                -- ts_ls = {
                --     init_options = {
                --         plugins = {
                --             vue_plugin,
                --         },
                --     },
                --     filetypes = tsserver_filetypes,
                -- },
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
                lsp.config(name, {
                    init_options = config.init_options,
                    on_attach = config.on_attach,
                    cmd = config.cmd,
                    filetypes = config.filetypes,
                    settings = config.settings
                })
                lsp.enable(name)
            end


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
                "nvim-dap-ui",
                "snacks",
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
