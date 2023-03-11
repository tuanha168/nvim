local M = {}

M.setup = function()
  local augend = require "dial.augend"
  require("dial.config").augends:register_group {
    default = {
      augend.integer.alias.decimal_int,
      augend.integer.alias.binary,
      augend.integer.new {
        radix = 16,
        prefix = "#",
        natural = true,
        case = "lower",
      },
      augend.constant.new {
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      },
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.date.alias["%H:%M:%S"],
      augend.date.alias["%H:%M"],
      augend.constant.new { elements = { "let", "const" } },
      augend.constant.new { elements = { "true", "false" } },
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
      augend.semver.alias.semver,
    },
  }
  vim.api.nvim_set_keymap("n", "+", require("dial.map").inc_normal(), { noremap = true })
  vim.api.nvim_set_keymap("n", "-", require("dial.map").dec_normal(), { noremap = true })
  vim.api.nvim_set_keymap("v", "+", require("dial.map").inc_visual(), { noremap = true })
  vim.api.nvim_set_keymap("v", "-", require("dial.map").dec_visual(), { noremap = true })
  vim.api.nvim_set_keymap("v", "g+", require("dial.map").inc_gvisual(), { noremap = true })
  vim.api.nvim_set_keymap("v", "g-", require("dial.map").dec_gvisual(), { noremap = true })
end
return M
