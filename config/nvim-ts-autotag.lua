local M = {}

M.setup = function()
  require("nvim-ts-autotag").setup {
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
  require("nvim-treesitter.configs").setup {
    autotag = {
      enable = true,
    },
  }
end

return M
