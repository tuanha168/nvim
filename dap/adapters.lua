return {
  node2 = {
    type = "executable",
    command = vim.fn.exepath "node-debug2-adapter",
  },
  js = {
    type = "executable",
    command = vim.fn.exepath "js-debug-adapter",
  },
  ["pwa-node"] = {},
  ["pwa-chrome"] = {},
}
