local lazy = require "pack.lazy-load"

local md_preview_plugin = "https://github.com/selimacerbas/markdown-preview.nvim"
local live_server_plugin = "https://github.com/selimacerbas/live-server.nvim"

local function setup_markdown_preview()
  require("markdown_preview").setup {
    instance_mode = "takeover",
    port = 0,
    open_browser = true,
    default_theme = "dark",
    debounce_ms = 300,
  }
end

lazy.on_key(md_preview_plugin, {
  { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview Open" },
  { "<leader>mps", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview Start" },
  { "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
  { "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", desc = "Markdown Preview Refresh" },
}, function()
  vim.pack.add({ live_server_plugin }, { load = true })
  setup_markdown_preview()
end)
