return {
  {
    "ravitemer/mcphub.nvim",
    enabled = false,
    cmd = { "MCPHub" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "CopilotC-Nvim/CopilotChat.nvim",
    },
    -- commit = "15d490149502a8fb523a148dd564d597d34c3eb4",
    -- build = "npm install -g mcp-hub@3.7.0", -- Installs `mcp-hub` node binary globally
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    opts = {
      config = vim.fn.stdpath "config" .. "/mcphub.servers.json",
      extensions = {
        copilotchat = {
          enabled = true,
          convert_tools_to_functions = false, -- Convert MCP tools to CopilotChat functions
          convert_resources_to_functions = false, -- Convert MCP resources to CopilotChat functions
          add_mcp_prefix = false, -- Add "mcp_" prefix to function names
        },
      },
      log = {
        level = vim.log.levels.DEBUG,
        to_file = true,
        file_path = vim.fn.expand "~/mcphub.log",
      },
    },
  },
}
