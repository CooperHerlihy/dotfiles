local M = {}

M.setColorScheme = function(name, colors)
    vim.g.colors_name = name

    vim.cmd("hi clear")
    vim.cmd("syntax reset")

    vim.o.termguicolors = true
    vim.o.background = "dark"

    colors.background = colors.background or "NvimDarkGrey2"
    colors.semihighlight = colors.semihighlight or "NvimDarkGrey3"
    colors.highlight = colors.highlight or "NvimDarkGrey4"

    colors.text = colors.text or "NvimLightGrey2"
    colors.textDark = colors.textDark or "NvimLightGrey4"
    colors.textHidden = colors.textHidden or "NvimDarkGrey4"

    colors.accent1 = colors.accent1 or "NvimLightCyan"
    colors.accent2 = colors.accent2 or "NvimLightBlue"
    colors.accent3 = colors.accent3 or "NvimLightGreen"

    colors.error = colors.error or "NvimLightRed"
    colors.warn = colors.warn or "NvimLightYellow"
    colors.info = colors.info or "NvimLightCyan"
    colors.hint = colors.hint or "NvimLightBlue"
    colors.ok = colors.ok or "NvimLightGreen"

    local groups = {

        -- Code

        ["Normal"] = {fg = colors.text, bg = colors.background},

        ["CursorLine"] = {bg = colors.semihighlight},
        ["CursorColumn"] = {bg = colors.semihighlight},
        ["ColorColumn"] = {bg = colors.semihighlight},

        ["Visual"] = {bg = colors.highlight},
        ["MatchParen"] = {bg = colors.highlight},

        ["Search"] = {fg = colors.background, bg = colors.accent1, bold = true},
        ["CurSearch"] = {fg = colors.accent1, bg = colors.highlight, bold = true},

        ["Folded"] = {fg = colors.textDark},
        ["NonText"] = {fg = colors.textHidden},
        ["Conceal"] = {fg = colors.textHidden},

        ["Title"] = {fg = colors.accent1},
        ["Directory"] = {fg = colors.accent1},

        ["Comment"] = {fg = colors.textDark},
        ["Delimiter"] = {fg = colors.text},
        ["Operator"] = {fg = colors.text},
        ["@variable"] = {fg = colors.text},

        ["Statement"] = {fg = colors.accent1},
        ["Type"] = {fg = colors.accent1},
        ["PreProc"] = {fg = colors.accent1},
        ["Special"] = {fg = colors.accent1},

        ["Identifier"] = {fg = colors.accent2},
        ["Function"] = {fg = colors.accent2},

        ["Constant"] = {fg = colors.accent3},
        ["String"] = {fg = colors.accent3},

        ["Added"] = {fg = colors.ok},
        ["Removed"] = {fg = colors.error},
        ["Changed"] = {fg = colors.info},

        ["DiffAdd"] = {fg = colors.ok},
        ["DiffChange"] = {fg = colors.info},
        ["DiffDelete"] = {fg = colors.error},
        ["DiffText"] = {fg = colors.text},

        ["SpellBad"] = {sp = colors.error},
        ["SpellCap"] = {sp = colors.warn},
        ["SpellRare"] = {sp = colors.info},
        ["SpellLocal"] = {sp = colors.ok},

        -- UI

        ["StatusLine"] = {fg = colors.accent1, bg = colors.semihighlight},
        ["StatusLineNC"] = {fg = colors.accent1, bg = colors.background},
        ["Question"] = {fg = colors.accent1},

        ["LineNr"] = {fg = colors.textHidden},
        ["CursorLineNr"] = {bold = true},
        ["SignColumn"] = {fg = colors.textHidden},

        ["WinBar"] = {fg = colors.textDark, bg = colors.background},
        ["WinBarNC"] = {fg = colors.textDark, bg = colors.background},

        ["QuickFixLine"] = {fg = colors.accent1},

        ["Pmenu"] = {bg = colors.semihighlight},
        ["PmenuThumb"] = {bg = colors.highlight},

        ["NormalFloat"] = {bg = colors.background},
        ["FloatShadow"] = {bg = colors.highlight, blend = 80},
        ["FloatShadowThrough"] = {bg = colors.highlight, blend = 100},

        -- Diagnostics

        ["Error"] = {fg = colors.text, bg = colors.error},

        ["Todo"] = {fg = colors.text},

        ["ErrorMsg"] = {fg = colors.error},
        ["WarningMsg"] = {fg = colors.warn},
        ["OkMsg"] = {fg = colors.ok},
        ["MoreMsg"] = {fg = colors.info},
        ["ModeMsg"] = {fg = colors.hint},

        ["DiagnosticError"] = {fg = colors.error},
        ["DiagnosticWarn"] = {fg = colors.warn},
        ["DiagnosticInfo"] = {fg = colors.info},
        ["DiagnosticHint"] = {fg = colors.hint},
        ["DiagnosticOk"] = {fg = colors.ok},
        ["DiagnosticDeprecated"] = {sp = colors.error},

        ["DiagnosticUnderlineError"] = {underline = true, sp = colors.error},
        ["DiagnosticUnderlineWarn"] = {underline = true, sp = colors.warn},
        ["DiagnosticUnderlineInfo"] = {underline = true, sp = colors.info},
        ["DiagnosticUnderlineHint"] = {underline = true, sp = colors.hint},
        ["DiagnosticUnderlineOk"] = {underline = true, sp = colors.ok},

        -- Plugins

        ["MiniIconsAzure"] = {fg = "NvimLightCyan"},
        ["MiniIconsBlue"] = {fg = "NvimLightBlue"},
        ["MiniIconsCyan"] = {fg = "NvimLightCyan"},
        ["MiniIconsGreen"] = {fg = "NvimLightGreen"},
        ["MiniIconsOrange"] = {fg = "NvimLightYellow"},
        ["MiniIconsPurple"] = {fg = "NvimLightMagenta"},
        ["MiniIconsRed"] = {fg = "NvimLightRed"},
        ["MiniIconsYellow"] = {fg = "NvimLightYellow"},
        ["MiniIconsGrey"] = {fg = "NvimLightGrey2"},

        ["RenderMarkdownH1"] = {fg = colors.accent1},
        ["RenderMarkdownH2"] = {fg = colors.accent2},
        ["RenderMarkdownH3"] = {fg = colors.accent3},
        ["RenderMarkdownH4"] = {fg = colors.accent1},
        ["RenderMarkdownH5"] = {fg = colors.accent2},
        ["RenderMarkdownH6"] = {fg = colors.accent3},
        ["RenderMarkdownH1Bg"] = {bg = colors.semihighlight},
        ["RenderMarkdownH2Bg"] = {bg = colors.semihighlight},
        ["RenderMarkdownH3Bg"] = {bg = colors.semihighlight},
        ["RenderMarkdownH4Bg"] = {bg = colors.semihighlight},
        ["RenderMarkdownH5Bg"] = {bg = colors.semihighlight},
        ["RenderMarkdownH6Bg"] = {bg = colors.semihighlight},
        ["RenderMarkdownBullet"] = {fg = colors.accent1},
        ["RenderMarkdownLink"] = {fg = colors.accent2},
        ["RenderMarkdownQuote"] = {fg = colors.accent3},
        ["RenderMarkdownCode"] = {bg = colors.semihighlight},
    }

    for group, hl in pairs(groups) do
        vim.api.nvim_set_hl(0, group, hl)
    end
end

return M
