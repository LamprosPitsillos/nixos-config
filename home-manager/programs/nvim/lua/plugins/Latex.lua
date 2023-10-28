return {
    "lervag/vimtex",
    enabled = false,
    config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "tectonic"

        vim.g.vimtex_indent_enabled = 1
        vim.g.vimtex_quickfix_mode = 1

        vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Warning", }

        vim.g.vimtex_quickfix_open_on_warning = 0

        vim.g.vimtex_matchparen_enabled = 0
        vim.g.vimtex_fold_enabled = 1
        vim.g.vimtex_complete_recursive_bib = 0
        vim.g.vimtex_syntax_enabled = 1
        vim.g.vimtex_syntax_conceal_disable = 0
        vim.g.vimtex_toc_enabled = 1

        vim.g.vimtex_motion_enabled = 1
        -- vim.g.vimtex_quickfix_enabled = 0
        vim.g.vimtex_text_obj_enabled = 1
        vim.g.vimtex_view_enabled = 1
        vim.g.vimtex_complete_enable = 1
        vim.g.vimtex_fold_bib_enabled = 0
        vim.g.vimtex_indent_enabled = 1
        vim.g.vimtex_indent_bib_enabled = 0
        vim.g.vimtex_doc_enabled = 1
        vim.g.vimtex_include_search_enabled = 1
        vim.g.vimtex_viewer_check = 1

        vim.g.vimtex_compiler_tectonic = {
            executable = "tectonic",
            callback = 1,
            continuous = 1,
            options = {
                "--synctex",
                "--keep-logs",
                "--keep-intermediates"
            }
        }
    end
}

-- vim.g.vimtex_view_general_viewer = 'okular'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

--  VimTeX uses latexmk as the default compiler backend. If you use it, which is
--  strongly recommended, you probably don't need to configure anything. If you
--  want another compiler backend, you can change it as follows. The list of
--  supported backends and further explanation is provided in the documentation,
-- " Most VimTeX mappings rely on localleader and this can be changed with the
-- " following line. The default is usually fine and is the symbol "\".
-- let maplocalleader = ","
