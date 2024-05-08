-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
      update_in_insert = false,
    },
    -- vim options can be configured here
    options = require "options",
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = require "mappings",
    autocmds = {
      q_close_windows = {
        {
          event = "BufWinEnter",
          desc = "Make q close help, man, quickfix, dap floats",
          callback = function(event)
            if
              vim.tbl_contains({ "help", "nofile", "quickfix" }, vim.bo[event.buf].buftype)
              and not vim.tbl_contains({ "minifiles" }, vim.bo[event.buf].filetype)
            then
              vim.keymap.set("n", "q", "<Cmd>close<CR>", {
                desc = "Close window",
                buffer = event.buf,
                silent = true,
                nowait = true,
              })
            end
          end,
        },
      },
    },
  },
}
