return {
    {
        "neovim/nvim-lspconfig",

        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            -- { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {}, },
            -- "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }

            -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
                volar = {},
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
                    filetypes = { "vue","javascriptreact", "typescriptreact" }
                },
                texlab = {},
                ts_ls = {
                    init_options = {
                        hostInfo = "neovim",
                        plugins = {
                            {
                                name = '@vue/typescript-plugin',
                                location = vim.fn.exepath("vue-language-server") .. '/../../lib/node_modules/@vue/language-server',
                                languages = { 'typescript', 'javascript' ,'vue' },
                            },
                        },
                    },
                    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
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

            for name, prop in pairs(servers) do
                lsp[name].setup({
                    init_options = prop.init_options,
                    on_attach = prop.on_attach,
                    capabilities = capabilities,
                    cmd = prop.cmd,
                    filetypes = prop.filetypes,
                    settings = prop.settings
                })
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
                -- vim.env.LAZY .. "/luvit-meta/library", -- see below
                -- You can also add plugins you always want to have loaded.
                -- Useful if the plugin has globals or types you want to use
                -- vim.env.LAZY .. "/LazyVim", -- see below
            },
        },
    },
}
