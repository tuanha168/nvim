-- Only load inside Herdr
if vim.env.HERDR_ENV ~= "1" then
  return
end

local hs = require("herdr-splits")

hs.setup({
  auto_sync_herdr = true,
  unzoom_on_nav = true,
  nav_at_edge = "wrap",
})

-- Sync Herdr-side scripts after install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "herdr-splits.nvim" and (ev.data.kind == "install" or ev.data.kind == "update") then
      hs.sync_herdr()
    end
  end,
})

vim.keymap.set("n", "<A-h>", hs.resize_left,  { desc = "Resize left" })
vim.keymap.set("n", "<A-j>", hs.resize_down,  { desc = "Resize down" })
vim.keymap.set("n", "<A-k>", hs.resize_up,    { desc = "Resize up" })
vim.keymap.set("n", "<A-l>", hs.resize_right, { desc = "Resize right" })

vim.keymap.set("n", "<C-h>", hs.move_cursor_left,  { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", hs.move_cursor_down,  { desc = "Move to down split" })
vim.keymap.set("n", "<C-k>", hs.move_cursor_up,    { desc = "Move to up split" })
vim.keymap.set("n", "<C-l>", hs.move_cursor_right, { desc = "Move to right split" })
