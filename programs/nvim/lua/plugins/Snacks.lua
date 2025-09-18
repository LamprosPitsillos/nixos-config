local HEADERS = {
    guts = {
        [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣟⢻⣯⡻⢿⣿⠻⣿⣿⣿⣿⡿⣿⣿⣿⡿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡿⣿⣿⣆⠈⡙⠉⠓⠀⠀⠀⠀⠀⠈⠉⡛⢋⠀⠉⠉⠔⠈⠉⠀⣠⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⡉⠛⠂⠉⢉⠀⢀⣘⠀⠂⠈⣂⣂⠀⠠⢀⠊⠠⢀⠀⠤⠥⢰⢔⣂⠀⠒⢀⠐⠙⠛⢛⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣉⠉⠉⠀⢄⠀⠀⠀⠀⠰⠦⠤⠔⠲⠢⠐⡙⡫⠉⣤⢐⣶⢠⠠⠒⣄⠀⢀⡀⠀⠁⣀⠀⠀⠉⠉⣩⣭⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿
⣿⣿⣿⣿⣿⣿⡿⢿⡿⠟⡋⠡⠠⠂⠀⠀⠉⠉⠁⠤⠄⠀⠀⢀⠠⠂⠀⢀⠉⠊⢤⠀⠎⠹⢢⣄⢂⠹⠮⢆⠤⡦⡀⠀⠐⠄⠀⠀⠁⣉⣽⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣿⣿
⣿⣿⣿⣿⣉⣁⡀⠐⠀⠀⡀⠀⠰⣂⠞⠒⠁⠀⠀⡘⠁⢠⡊⠙⠔⢡⠄⠈⢠⠌⠀⠒⣄⠠⠀⡀⠀⠂⡀⠱⣵⡄⠀⠄⢀⠀⠁⠡⢂⠀⢙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⡿⠛⢣⠁⣠⣅⢊⠄⡪⠞⠁⠁⠀⠀⠂⡆⠀⣂⠊⠁⠀⠀⠀⠃⠈⡎⠀⣒⣔⠀⠀⠀⠁⠚⡒⠀⠀⠀⠁⠀⠀⠀⡉⠈⢑⡐⠌⠐⢦⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣷⣿⠟⣡⠾⡋⣁⣧⡬⡢⡀⠄⠐⠀⠠⠀⠀⠐⠀⠆⡋⠃⠀⠀⠀⠐⠀⠠⡹⠉⠀⢀⡄⣺⡀⠀⠞⠄⢂⠄⠀⠀⠐⡘⠨⠐⠕⠀⠰⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣯⡽⢉⣾⡿⣳⣉⣡⣺⣆⣤⡼⠀⠀⠀⠀⠀⠡⠀⠑⠂⠀⠀⠁⠀⠀⠀⡈⠀⠀⠀⠄⠀⠀⠁⠠⢒⣁⢀⠀⢗⡀⡀⠀⠐⡖⣥⠄⣫⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⡿⢩⣴⣢⣲⣿⣾⣿⣿⣾⣿⣽⠀⠀⠀⢀⠁⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠈⠀⠀⠠⠂⠀⠈⠀⠤⠀⠀⣐⡀⠐⠀⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣾⣼⣽⡿⣿⣿⣿⣿⢿⠸⡠⠏⠀⠀⠀⠀⠀⠀⠠⣮⠀⠀⠀⣌⡀⠀⠀⠠⣀⠀⠀⠀⠀⠀⠘⡆⠀⠂⠀⠀⠒⠁⣺⣯⣿⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⡏⣭⣿⣿⡙⣿⠞⠇⠁⠀⡀⠃⠈⢆⠀⠂⢠⠀⠢⠅⠂⠂⠀⠁⠀⣔⡺⣯⣬⢖⠠⡤⠀⠂⢐⠁⠀⠀⠘⠰⠀⢀⣼⡯⣮⡽⣇⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣧⣿⢭⣋⡇⠁⡲⢠⢀⠔⠅⠁⢸⣹⠄⢧⠅⠈⠀⠀⠀⢀⠄⣁⠪⡈⠴⠴⢄⡔⠖⡂⠜⠀⠁⠆⠀⠀⠂⠂⢠⣾⢯⣬⣆⣿⡜⡆⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡿⣳⣿⣻⠀⠉⠀⠈⠁⠁⠂⠈⠹⣦⣴⣷⣰⡠⠀⠐⠡⠾⠏⢊⠁⠀⣨⣵⣿⠄⣓⣇⣌⠀⠀⠀⠀⠀⠀⠱⣯⣶⡬⡂⣿⣧⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣼⢠⢇⡀⢀⡄⢀⠀⠀⠀⡿⣿⡿⣬⡠⠀⢠⠐⠴⢿⢔⢨⣬⣿⣿⣧⣶⣿⣿⠷⡄⠀⠀⠀⠀⡀⣸⡟⡿⣟⣿⢟⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⡏⣼⠸⡑⣙⠂⠰⠠⠉⠀⣿⣿⣯⣿⣿⡳⡤⠋⠂⠙⡪⣿⠸⠷⡿⠟⣽⣯⣯⡦⠋⠠⠅⠐⢀⡠⣿⠓⣿⠐⠺⡯⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢤⡿⠤⠀⠀⣨⢠⢢⣿⡿⣿⣿⣿⣿⣿⠄⡆⠀⠀⢄⠁⡖⡁⣒⠛⢻⢟⣏⠀⢐⠘⠿⣔⢚⡋⠀⢸⣦⡆⠀⠐⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⡇⢠⠄⢔⣟⣾⣿⣿⣿⣿⣿⣿⣿⣿⣧⣆⠁⢰⡵⣣⡟⠕⢟⠰⠉⠀⠚⢘⣃⣯⣾⣿⠣⠆⢅⢞⡈⡀⡂⠘⣿⣿⣿⣿⣿⣿⣿⣿⡿⠗⣽⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡧⠁⡀⠀⠫⠛⠛⡛⠏⠊⠿⢿⣗⣽⣿⣿⣷⡘⢿⣧⢳⣧⠀⡂⠀⠅⠍⠩⠷⡟⢻⣻⠀⡀⢡⣤⣚⢷⠕⠼⣿⣿⣿⣿⣿⣿⣿⡿⠍⢀⢎⣧
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡉⠀⠐⢃⠤⠀⣸⠦⢁⠶⣻⣿⣿⣽⣿⣷⡞⣽⢻⣮⢁⣠⠆⠃⠀⠘⣶⡌⢭⡑⢐⢔⣤⣿⡿⣽⣳⣿⣿⣿⣿⡿⢟⣿⣟⠉⠎⢢⠦⣽
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠉⠀⢨⠢⣸⢬⣷⣿⢠⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⠁⠀⢁⡘⢻⣾⣿⢳⢸⣢⣿⣯⣾⣿⡿⡿⣿⣿⠯⠃⢈⢿⣗⡪⠀⢊⡏⡰
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠠⠐⢵⡆⠿⣷⣿⢿⣿⣿⣟⣛⡙⠋⣹⣍⣾⣿⣿⣯⠄⠀⢄⣠⢼⢿⣿⢎⡾⢌⡿⢜⣿⠟⠂⠚⣿⣶⢎⢑⡆⢸⢻⣾⣾⣥⣿⠿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⣀⣌⠀⠸⣶⣾⣿⣿⣿⣧⣭⠕⢊⢈⠰⣿⣿⣿⢫⠀⢀⡀⠀⠉⢝⠏⣡⠿⠐⣿⣿⠃⠁⠤⢂⣾⠭⢙⣪⣯⣿⠿⣛⠹⠁⠒⠁
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠯⠋⠐⡂⠂⢆⢈⣭⣝⣾⣾⣿⣿⣾⡹⡶⢮⣯⣝⣿⣷⡄⠢⠚⢤⣎⣐⡨⠔⠁⠀⢀⣿⠀⡤⠤⣲⣜⣠⡽⢻⠫⠂⠁⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠙⠁⠀⠀⠐⠄⠘⡵⠻⣿⣿⣿⣿⠻⣿⣿⣮⠀⡈⠣⡵⠝⡑⢁⠔⠈⠻⣷⡶⣀⠀⠀⠦⣯⢤⣬⣿⠿⡋⠕⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠆⠀⠀⠀⠀⠀⠀⢘⢿⡢⠺⣿⣿⣷⡉⠹⣿⣿⢷⢎⠈⢐⠌⠀⠈⢰⡄⣈⡫⠟⠲⣧⣀⠀⠀⠀⡠⠑⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣸
⣿⣿⣿⣿⣿⣿⣿⣿⡟⠉⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠊⡚⠀⢕⣀⣁⡠⡀⠀⠀⠨⣿⢯⣞⠍⠀⠈⠀⠀⠅⠒⠉⠁⠀⠀⠀⠀⠀⡀⠄⠊⠁⠀⠀⣄⣖⣽⣿⣿⣿⣿⣿]],
    },
    neovim = {
        [[
                   ██╗  ' -*  ███╗ * ██╗███████╗ ██████╗ ██╗` ,██╗██╗███╗. *███╗ *  . ` ██╗
                  ██╔╝  .    *████╗ `██║██╔════╝██╔═══██╗██║ * ██║██║████╗ ████║.    () ╚██╗
████████████████████║      .  ██╔██╗ ██║█████╗` ██║ * ██║██║.  ██║██║██╔████╔██║    -*  '██████████████████╗
╚═════════════════██║ '  *    ██║╚██╗██║██╔══╝ *██║'  ██║╚██╗ ██╔╝██║██║╚██╔╝██║ *       ██╔═══════════════╝
                  ╚██╗  '   , ██║.╚████║███████╗╚██████╔╝.╚████╔╝ ██║██║ ╚═╝'██║     .  ██╔╝
                   ╚═╝  .  *  ╚═╝  ╚═══╝╚══════╝ ╚═════╝*  ╚═══╝ ,╚═╝╚═╝-* . ╚═╝  `*    ╚═╝]],
    },
    curiosity = {
        [[
⠀⠀⣶⡆⠀⠀⠀⣤⣤⣤⣤⣤⣤⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢶⣶⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⢀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⠀⠐⢷⣆⠀⠀
⠀⠀⢰⣿⠀⠀⠀⠀⠉⠉⠉⠉⠉⢉⣿⡟⠁⠀⠀⠘⠛⠛⠛⠛⠛⢻⣿⣟⡛⠛⠛⠛⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣷⡤⠀⠀⠀⠀⠀⠀⢸⣿⠛⠛⢻⣿⠈⠉⠉⠉⢹⣿⠉⠉⠉⠉⠁⠀⠀⠀⣿⡟⠛⠛⠛⠛⠛⣿⡟⠛⠛⢛⠛⠛⠃⠀⠀⠀⠀⠀
⠘⠛⢻⡿⠛⠛⣿⠇⠀⠀⠀⢰⣾⠟⠁⠀⠀⠀⠀⢀⣀⣀⣀⣤⡾⠟⠉⠉⠛⠿⢷⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⢠⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⢸⣿⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⣿⡷⠶⠶⢶⣶⠀⠸⣿⡀⢠⡾⠟⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣿⠃⠀⢰⡿⢠⣤⣤⣤⣼⣿⣤⣤⣤⣤⡄⠀⣬⣿⣭⣭⣭⣤⣤⣤⣤⣤⣤⣤⣬⣭⣭⣤⡄⠀⠀⢰⡶⠀⢸⣿⠀⠀⠀⠀⠀⠀⠸⢿⣄⠀⠀⠀⢸⣿⠶⠶⢾⣿⠀⣀⣀⣀⣸⣿⣀⣀⣀⣀⠀⠀⠀⣰⣿⠁⠀⠀⣸⡿⠀⢀⣹⣷⣟⠁⠀⣰⡄⠀⠀⠀⠀⠀
⠀⣾⣏⡀⠀⣸⡇⠈⠉⠉⠉⢹⣿⠉⠉⠉⠉⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⢸⣿⠀⠀⢸⣿⠀⠉⠉⠉⢹⣿⠉⠉⠉⠉⠀⠀⢠⣿⠇⠀⠛⠛⠋⠁⢾⠟⠉⠈⠹⢷⣶⣿⠃⠀⠀⠀⠀⠀
⠀⠛⠛⠛⣷⣿⡁⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⣿⡏⠉⠉⠉⢹⣿⠀⠀⠀⣿⡇⠀⠀⠀⠀⣴⡿⠃⠀⢸⣿⠀⠀⠀⠀⠀⠀⣤⡀⠈⢿⣧⠀⢸⣿⣀⣀⣸⣿⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠛⠛⢻⡟⠛⢻⣿⠛⠛⢻⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣼⠿⠙⢿⠦⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⣿⣧⣤⣤⣤⣼⣿⠀⠀⠀⣿⡇⠀⠀⠀⠈⠻⠁⠀⠀⢸⣿⠀⠀⠀⠀⠀⢀⣿⠀⠀⠈⠀⠀⢸⣿⠉⠉⠉⠉⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⢸⡇⠀⢸⣿⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠶⠟⠉⠀⠀⠀⠀⠀⠶⠶⠾⠟⠀⠀⠀⠀⠀⠀⠀⠀⠛⠃⠀⠀⠀⠀⠀⠶⠶⠶⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠷⠶⠶⠶⠶⠿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠃⠀⠰⠶⠾⠿⠶⠶⠾⠷⠶⠾⠿⠶⠶⠾⠷⠶⠆]]
    }
}

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        dashboard = {
            ---@class snacks.dashboard.Config
            ---@field enabled? boolean
            ---@field sections snacks.dashboard.Section
            ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
            width = 60,
            row = nil,                               -- dashboard position. nil for center
            col = nil,                               -- dashboard position. nil for center
            pane_gap = 4,                            -- empty columns between vertical panes
            autokeys = "asdfghjklqwertyuiopzxcvbnm", -- autokey sequence
            -- These settings are used by some built-in sections
            preset = {
                -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                ---@type fun(cmd:string, opts:table)|nil
                pick = nil,
                -- Used by the `keys` section to show keymaps.
                -- Set your custom keymaps here.
                -- When using a function, the `items` argument are the default keymaps.
                ---@type snacks.dashboard.Item[]
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                -- Used by the `header` section
                header = HEADERS.guts
            },
            -- item field formatters
            formats = {
                icon = function(item)
                    if item.file and item.icon == "file" or item.icon == "directory" then
                        local icon, hl = require('snacks').util.icon(item.file, item.icon)
                        return { icon, width = 2, hl = hl }
                    end
                    return { item.icon, width = 2, hl = "icon" }
                end,
                footer = { "%s", align = "center" },
                header = { "%s", align = "center" },
                file = function(item, ctx)
                    local fname = vim.fn.fnamemodify(item.file, ":~")
                    fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
                    if #fname > ctx.width then
                        local dir = vim.fn.fnamemodify(fname, ":h")
                        local file = vim.fn.fnamemodify(fname, ":t")
                        if dir and file then
                            file = file:sub(-(ctx.width - #dir - 2))
                            fname = dir .. "/…" .. file
                        end
                    end
                    local dir, file = fname:match("^(.*)/(.+)$")
                    return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or
                        { { fname, hl = "file" } }
                end,
            },
            sections = {
                {
                    { section = "header", padding = 1 },
                },
                {
                    pane = 2,
                    align = "center",
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },
                }
            },
        },
        indent = {

            --         -- symbol = "│",
            --         symbol = "▎",
            --
            --         -- symbol = "║",
            --         -- symbol = "┃",
            --         -- symbol = "┇",
            --         -- symbol = "┋",
            --         -- symbol = "┊",
            --
            --         -- symbol = "▌",
            --         -- symbol = "▎",
            --         -- symbol = "▏",
            --         -- symbol = "░",
            --
            ---@class snacks.indent.Config
            ---@field enabled? boolean
            priority = 1,
            enabled = true,       -- enable indent guides
            char = "▏",
            only_scope = false,   -- only show indent guides of the scope
            only_current = false, -- only show indent guides in the current window
            hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
            -- can be a list of hl groups to cycle through
            -- hl = {
            --     "SnacksIndent1",
            --     "SnacksIndent2",
            --     "SnacksIndent3",
            --     "SnacksIndent4",
            --     "SnacksIndent5",
            --     "SnacksIndent6",
            --     "SnacksIndent7",
            --     "SnacksIndent8",
            -- },
            -- animate scopes. Enabled by default for Neovim >= 0.10
            -- Works on older versions but has to trigger redraws during animation.
            ---@class snacks.indent.animate: snacks.animate.Config
            ---@field enabled? boolean
            --- * out: animate outwards from the cursor
            --- * up: animate upwards from the cursor
            --- * down: animate downwards from the cursor
            --- * up_down: animate up or down based on the cursor position
            ---@field style? "out"|"up_down"|"down"|"up"
            animate = {
                enabled = false,
                style = "out",
                easing = "linear",
                duration = {
                    step = 20,   -- ms per step
                    total = 500, -- maximum duration
                },
            },
            ---@class snacks.indent.Scope.Config: snacks.scope.Config
            scope = {
                enabled = true, -- enable highlighting the current scope
                priority = 200,
                char = "▏",
                underline = false,    -- underline the start of the scope
                only_current = false, -- only show scope in the current window
                hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
            },
            chunk = {
                -- when enabled, scopes will be rendered as chunks, except for the
                -- top-level scope which will be rendered as a scope.
                enabled = true,
                -- only show chunk scopes in the current window
                only_current = false,
                priority = 200,
                hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
                char = {
                    corner_top = "┌",
                    corner_bottom = "└",
                    -- corner_top = "╭",
                    -- corner_bottom = "╰",
                    horizontal = "─",
                    vertical = "│",
                    arrow = "▷",
                },
            },
            -- filter for buffers to enable indent guides
            filter = function(buf)
                return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
            end,
        },
        ---@class snacks.notifier.Config
        ---@field enabled? boolean
        ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
        ---@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
        notifier = {
            timeout = 3000, -- default timeout in ms
            width = { min = 40, max = 0.4 },
            height = { min = 1, max = 0.6 },
            -- editor margin to keep free. tabline and statusline are taken into account automatically
            margin = { top = 0, right = 1, bottom = 0 },
            padding = true,              -- add 1 cell of left/right padding to the notification window
            sort = { "level", "added" }, -- sort by level and time
            -- minimum log level to display. TRACE is the lowest
            -- all notifications are stored in history
            level = vim.log.levels.TRACE,
            icons = {
                error = " ",
                warn = " ",
                info = " ",
                debug = " ",
                trace = " ",
            },
            keep = function(notif)
                return vim.fn.getcmdpos() > 0
            end,
            ---@type snacks.notifier.style
            style = "fancy",
            top_down = true,    -- place notifications from top to bottom
            date_format = "%R", -- time format for notifications
            -- format for footer when more lines are available
            -- `%d` is replaced with the number of lines.
            -- only works for styles with a border
            ---@type string|boolean
            more_format = " ↓ %d lines ",
            refresh = 50, -- refresh at most every 50ms
            config = function(opts, defaults)
            end
        },
    }
}
