return {
  {
    "ravitemer/mcphub.nvim",
    cmd = { "MCPHub" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    build = "bundled_build.lua", -- Installs `mcp-hub` node binary globally
    opts = {
      config = vim.fn.stdpath "config" .. "/mcphub.servers.json",
      use_bundled_binary = true,
      log = {
        level = vim.log.levels.DEBUG,
        to_file = true,
        file_path = vim.fn.expand "~/mcphub.log",
      }
    },
  },
}
