return {
  timeout_ms = 1000,
  filter = function(client)
    local disabled = {
      "lua_ls",
      "jsonls",
      "intelephense",
      "volar",
      "tailwindcss",
    }
    -- check if client is fully disabled or filtered by function
    return not (vim.tbl_contains(disabled, client.name))
  end,
}
