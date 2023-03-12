local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup {
    autotag = {
      enable = true,
    },
  }
end

M.opts = {
  filetypes = {
    "html",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "svelte",
    "vue",
    "tsx",
    "jsx",
    "rescript",
    "xml",
    "php",
    "markdown",
    "glimmer",
    "handlebars",
    "hbs",
  },
}

return M
