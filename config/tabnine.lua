local M = {}


M.setupCmp = function()
  local tabnine = require "cmp_tabnine.config"
  tabnine:setup {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    ignored_file_types = {
      -- default is not to ignore
      -- uncomment to ignore in lua:
      -- lua = true
    },
    show_prediction_strength = true,
  }
end

M.setupClient = function()
  local tabnine = require "tabnine"
  tabnine.setup {
    disable_auto_comment = true,
    accept_keymap = "<C-f>",
    dismiss_keymap = "<C-]>",
    debounce_ms = 300,
    suggestion_color = { gui = "#808080", cterm = 244 },
    execlude_filetypes = { "TelescopePrompt" },
  }
end

return M
