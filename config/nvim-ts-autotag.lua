require("nvim-treesitter.configs").setup {
  autotag = {
    enable = true,
  },
}

return {
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
