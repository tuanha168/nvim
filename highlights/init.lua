-- set highlights for all themes
-- use a function override to let us use lua to retrieve colors from highlight group
-- there is no default table so we don't need to put a parameter for this function
return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  -- get highlights from highlight groups
  local normal = get_hlgroup "Normal"
  local bg = normal.bg
  local pink = "#925070"
  local green = get_hlgroup("String").fg
  -- return a table of highlights for telescope based on colors gotten from highlight groups
  return {
    -- transparent background
    Normal = { bg = nil },
    SignColumn = { bg = bg },
    NvimTreeNormal = { bg = bg },
    NvimTreeVertSplit = { bg = bg },
    NeoTreeNormal = { bg = bg },
    NeoTreeNormalNC = { bg = bg },
    NormalFloat = { bg = bg },
    NormalNC = { bg = bg },
    NotifyBackground = { bg = "#000000" },
    FoldColumn = { bg = bg },
    EndOfBuffer = { bg = bg },
    Visual = { bg = pink },
    -- TelescopeBorder = { fg = bg_alt, bg = bg },
    -- TelescopeNormal = { bg = bg },
    -- TelescopePreviewBorder = { fg = bg, bg = bg },
    TelescopePreviewNormal = { bg = bg },
    TelescopePreviewTitle = { fg = green, bg = pink },
    -- TelescopePromptBorder = { fg = bg, bg = bg },
    TelescopePromptNormal = { fg = bg, bg = bg },
    -- TelescopePromptPrefix = { fg = red, bg = bg },
    TelescopePromptTitle = { fg = green, bg = pink },
    -- TelescopeResultsBorder = { fg = bg, bg = bg },
    TelescopeResultsNormal = { bg = bg },
    TelescopeResultsTitle = { fg = green, bg = pink },
    -- ["@tag"] = { fg = pink },
    LspInlayHint = { fg = pink, italic = true },
    LspSignatureActiveParameter = { bg = "#666666" },
    FlashMatch = { bg = pink },
    -- RainbowDelimiterRed = { fg = "#fcb3ed" },
    -- RainbowDelimiterYellow = { fg = "#f7f6c1" },
    -- RainbowDelimiterBlue = { fg = "#a3e8ff" },
    -- RainbowDelimiterGreen = { fg = "#b3fcb4" },
    -- RainbowDelimiterOrange = { fg = "#fcceb3" },
  }
end
