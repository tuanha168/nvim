local function load_mcp_servers()
  local config_root = vim.fn.stdpath "config"
  local mcp_file = config_root .. "/mcphub.servers.json"

  if vim.fn.filereadable(mcp_file) == 1 then
    local content = vim.fn.readfile(mcp_file)
    local json_str = table.concat(content, "\n")
    local ok, mcp_config = pcall(vim.json.decode, json_str)
    if ok and mcp_config.mcpServers then return mcp_config.mcpServers end
  end

  return {}
end

local mcpServers = load_mcp_servers()

---@type LazySpec
return {
  {
    "dlants/magenta.nvim",
    enabled = true,
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
    opts = {
      profiles = {
        {
          name = "copilot-claude",
          provider = "copilot",
          model = "claude-sonnet-4",
          fastModel = "gpt-4.1",
        },
        {
          name = "copilot-4.1",
          provider = "copilot",
          model = "gpt-4.1",
          fastModel = "gpt-4.1",
        },
      },
      picker = "snacks",
      sidebarPosition = "right",
      mcpServers = mcpServers,
      commandAllowlist = {
        "^ls( [^;&|()<>]*)?$",
        "^pwd$",
        "^echo( [^;&|()<>]*)?$",
        "^ls [^;&()<>]* | grep [^;&|()<>]*$",
        "^echo [^;&|()<>]* > [a-zA-Z0-9_\\-.]+$",
        "^grep( -[A-Za-z]*)? [^;&|()<>]*$",
      },
    },
    dependencies = {
      "ravitemer/mcphub.nvim",
    },
  },
}
