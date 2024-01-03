return {
  ["pwa-node"] = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath "data" .. "/lazy/vscode-js-debug" },
  },
  ["pwa-chrome"] = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath "data" .. "/lazy/vscode-js-debug" },
  },
}
