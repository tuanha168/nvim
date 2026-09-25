local lazy = require "pack.lazy-load"

local plugin = "https://github.com/blackhat-7/vellum.nvim"

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name ~= "vellum.nvim" then return end
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then return end

    dofile(ev.data.path .. "/build.lua")
  end,
})

lazy.on_key(plugin, {
  { "<leader>mp", "<cmd>Vellum<cr>", desc = "Markdown Preview" },
}, function() require("vellum").setup() end)
