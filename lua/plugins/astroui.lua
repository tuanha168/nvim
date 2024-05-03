-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local get_hlgroup = require("astroui").get_hlgroup
-- get highlights from highlight groups
local normal = get_hlgroup "Normal"
local bg = normal.bg
local pink = "#925070"
local green = get_hlgroup("String").fg

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "dracula",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = {
        Visual = { bg = pink },
        -- TelescopeBorder = { fg = bg_alt, bg = bg },
        -- TelescopeNormal = { bg = bg },
        -- TelescopePreviewBorder = { fg = bg, bg = bg },
        TelescopePreviewNormal = { bg = bg },
        TelescopePreviewTitle = { fg = green, bg = pink },
        -- TelescopePromptBorder = { fg = bg, bg = bg },
        TelescopePromptNormal = { fg = "#ffffff", bg = bg },
        -- TelescopePromptPrefix = { fg = red, bg = bg },
        TelescopePromptTitle = { fg = green, bg = pink },
        -- TelescopeResultsBorder = { fg = bg, bg = bg },
        TelescopeResultsNormal = { bg = bg },
        TelescopeResultsTitle = { fg = green, bg = pink },
        LspInlayHint = { fg = pink, italic = true },
        LspSignatureActiveParameter = { bg = "#666666" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
      VimIcon = "",
      ScrollText = "",
      GitBranch = "",
      GitAdd = "",
      GitChange = "",
      GitDelete = "",
    },
  },
  {
    "rebelot/heirline.nvim",
    event = "BufEnter",
    dependencies = {
      {
        "AstroNvim/astrocore",
        "AstroNvim/astroui",
      },
    },
    opts = function(_, opts)
      local status = require "astroui.status"
      local codeium = {
        provider = function()
          local success, output = pcall(vim.fn["codeium#GetStatusString"])
          if success then return output end
        end,
      }
      opts.statusline = {
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        codeium,
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav(),
        status.component.mode { surround = { separator = "right" } },
      }
      return opts
    end,
    config = function(...) require "astronvim.plugins.configs.heirline"(...) end,
  },
}
