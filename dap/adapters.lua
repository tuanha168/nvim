return {
  ["pwa-node"] = {
    type = "executable",
    command = vim.fn.exepath "js-debug-adapter",
    -- command = "node",
    -- args = { vim.fn.stdpath "data" .. "/lazy/vscode-js-debug" },
  },
  ["pwa-chrome"] = {
    type = "executable",
    command = vim.fn.exepath "js-debug-adapter",
    -- command = "node",
    -- args = { vim.fn.stdpath "data" .. "/lazy/vscode-js-debug" },
  },
}
