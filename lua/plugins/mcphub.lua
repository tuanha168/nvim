return {
  {
    "ravitemer/mcphub.nvim",
    cmd = { "MCPHub" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    commit = "15d490149502a8fb523a148dd564d597d34c3eb4",
    build = "npm install -g mcp-hub@3.7.0", -- Installs `mcp-hub` node binary globally
    opts = {
      config = vim.fn.stdpath "config" .. "/mcphub.servers.json",
      log = {
        level = vim.log.levels.DEBUG,
        to_file = true,
        file_path = vim.fn.expand "~/mcphub.log",
      }
    },
  },
}
