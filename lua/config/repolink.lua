local M = {}

M.lazyKeys = {
  {
    "<Leader>gL",
    function()
      local prefix = ""
      if vim.api.nvim_get_mode().mode == "V" or vim.api.nvim_get_mode().mode == "v" then prefix = "'<,'>" end
      vim.ui.input({ prompt = "Origin (default: origin): " }, function(origin)
        if origin == nil or origin == "" then origin = "origin" end
        local current_branch = string.sub(vim.fn.system "git branch --show-current", 1, -2)
        vim.ui.input({ prompt = "Branch:", default = current_branch }, function(branch)
          if branch == nil or branch == "" then branch = current_branch end
          Chiruno.func.feedkeys(":" .. prefix .. "RepoLink! " .. branch .. " " .. origin .. "<CR>", "n")
        end)
      end)
    end,
    mode = { "n", "x" },
    desc = "RepoLink",
  },
}

M.opts = function()
  local api = require "repolink.api"
  return {
    url_builders = {
      ["yopaz"] = api.url_builder_for_github(),
      ["yopaz-liberty"] = api.url_builder_for_github(),
      ["git:ByapzGb3Px-W6TQotA-w@gitlab.dig-pg.net"] = api.url_builder_for_gitlab "https://gitlab.dig-pg.net",
    },
  }
end

return M
