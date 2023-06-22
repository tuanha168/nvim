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
    LspInlayHint = { fg = pink },
    ["@lsp.type.class"] = { fg = pink },
    ["@lsp.type.function"] = { fg = pink },
    ["@lsp.type.method"] = { fg = pink },
    ["@lsp.type.parameter"] = { fg = pink },
    ["@lsp.type.variable"] = { fg = pink },
    ["@lsp.type.property"] = { fg = pink },
    ["@lsp.typemod.function.classScope"] = { fg = pink },
    ["@lsp.typemod.variable.classScope"] = { fg = pink },
    ["@lsp.typemod.variable.fileScope"] = { fg = pink },
    ["@lsp.typemod.variable.globalScope"] = { fg = pink },
  }
end
