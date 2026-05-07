local lazy = require("pack.lazy-load")

lazy.on_event(
  {
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/iamcco/markdown-preview.nvim",
  },
  "FileType",
  function()
    require("render-markdown").setup({
      file_types = { "markdown" },
    })

    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = 1
  end,
  { pattern = "markdown" }
)

require("which-key").add({
  { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
})
