local lazy = require "pack.lazy-load"

local function apply_diff_colors()
  vim.api.nvim_set_hl(0, "HiColor1", vim.api.nvim_get_hl(0, { name = "DiffAdd", link = false }))
  vim.api.nvim_set_hl(0, "HiColor2", vim.api.nvim_get_hl(0, { name = "DiffDelete", link = false }))
end

-- Press <leader>N to always use HiColorN in normal or visual mode.
vim.g.HiSetSL = "<leader>h"
vim.g.HiErase = "<leader>hc"
vim.g.HiClear = "<leader>hc"

lazy.on_event("https://github.com/azabiong/vim-highlighter", "BufRead", function()
  apply_diff_colors()
  vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_diff_colors })

  for color = 1, 10 do
    local key = "<leader>" .. color
    local normal_command = ('<Cmd>call highlighter#Command("+%%", %d)<CR>'):format(color)
    local visual_command = (':<C-U>call highlighter#Command("+x%%", %d)<CR>'):format(color)
    vim.keymap.set("n", key, normal_command, {
      silent = true,
      desc = "Highlight with HiColor" .. color,
    })
    vim.keymap.set("x", key, visual_command, {
      silent = true,
      desc = "Highlight selection with HiColor" .. color,
    })
  end
end)
