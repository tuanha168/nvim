return {
  js = {
    type = "executable",
    command = vim.fn.exepath "js-debug-adapter",
  },
  -- ["pwa-node"] = {
  --   type = "executable",
  --   command = vim.fn.exepath "js-debug-adapter",
  -- },
  -- ["pwa-chrome"] = {
  --   type = "executable",
  --   command = vim.fn.exepath "js-debug-adapter",
  -- },
}
