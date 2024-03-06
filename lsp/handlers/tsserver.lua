return function(_, opts)
  require("typescript-tools").setup {
    settings = {
      tsserver_plugins = {
        "@vue/typescript-plugin",
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
    server = opts,
  }
end
