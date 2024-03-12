return {
    -- {
    --     'kaarmu/typst.vim',
    --     ft = 'typst',
    --     lazy = false,
    -- },
    {
        'chomosuke/typst-preview.nvim',
        dev = false,
        ft = 'typst',
        opts = {
            dependencies_bin = {
                ['typst-preview'] = 'typst-preview',
                ['websocat'] = 'websocat'
            },
            invert_colors = "auto",
            debug = false,
            open_cmd = "firefox %s --class firefox-typst-preview --name firefox-typst-preview --kiosk",
        },
    }
}
