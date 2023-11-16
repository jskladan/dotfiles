local p = require('kanagawa.colors').setup({ theme = 'wave' }).palette
require('kanagawa').setup({
    keywordStyle = { italic = false },
    statementStyle = { bold = false },
    colors = {
        -- https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/highlights/editor.lua
        palette = {
            -- change all usages of these colors
        },
        theme = {
            -- change specific usages for a certain theme, or for all of them
            wave = {
                ui = {
                    fg = "#e5e9e5",              --p.dragonWhite,
                    fg_dim = p.fujiWhite,        -- command line, TabLineSel
                    fg_reverse = p.dragonBlack0, -- IncSearch fg
                    bg = "#000000",              -- p.dragonBlack0,
                    bg_p1 = p.sumiInk0,          --  TabLineSel bg
                    bg_p2 = p.sumiInk2,          -- CursorLine bg
                    bg_m3 = p.sumiInk4,          -- WinSeparator fg; TabLine bg
                    bg_gutter = "none",
                    fg_search = p.dragonBlack0,--p.sumiInk5,
                    bg_cur_search = p.surimiOrange,
                    fg_cur_search = "#ffffff",
                    bg_search = p.surimiOrange,--p.sumiInk5,
                    bg_visual = p.dragonBlack5,
                    nontext = p.fujiGray,  -- LineNr fg
                    special = p.oniViolet, -- TabLine fg
                },
                syn = {
                    fun = p.lotusYellow4,-- "#a3c2ff",
                    variable = "#e5e9e5",
                    comment = p.dragonGray,
                    string = "#ecddc1", --"#f2dfba",
                    number = "#ecddc1",
                    identifier = "#e5e9e5",
                    statement = "#a4b8c1", --"#ff8097",
                    keyword = "#a4b8c1", --"#ff8097",
                    punct = "#e5e9e5",
                    --                    operator = p.waveRed,
                    type = p.surimiOrange,
                },
                diag = {
                    error = p.peachRed, --"#ff8097",
                    warning = p.roninYellow,
                    hint = p.fujiWhite,
                },
            },
        },
    },
})
require('kanagawa').load('wave')

-- vim.cmd('colorscheme github_dark_high_contrast')
-- vim.cmd([[ set noshowmode ]])
