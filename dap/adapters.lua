return {
  node2 = {
    type = "executable",
    command = vim.fn.exepath "node-debug2-adapter",
  },
  node = {
    type = "executable",
    command = vim.fn.exepath "js-debug-adapter",
  },
}
