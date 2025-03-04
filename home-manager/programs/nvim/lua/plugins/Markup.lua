return {
    {
        'chomosuke/typst-preview.nvim',
        dev = false,
        ft = 'typst',
        opts = {
            dependencies_bin = {
                ['tinymist'] = 'tinymist',
                ['websocat'] = 'websocat'
            },
            invert_colors = "auto",
            debug = false,
            open_cmd = "qutebrowser %s --target window ",
        },
    }
}
