return {
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
    },
    {
        'chomosuke/typst-preview.nvim',
        dev = true,
        ft = 'typst',
        version = '0.1.*',
        opts = {
            executable = "typst-preview",
            debug = true,
            open_cmd = "firefox %s -P typst-preview --class typst-preview",
        },
    }
}
