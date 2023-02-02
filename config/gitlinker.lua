local M = {}

M.setup = function()
  require("gitlinker").setup {
    opts = {
      -- remote = 'github', -- force the use of a specific remote
      -- adds current line nr in the url for normal mode
      add_current_line_on_normal_mode = true,
      -- callback for what to do with the url
      action_callback = require("gitlinker.actions").open_in_browser,
      -- print the url after performing the action
      print_url = false,
      -- mapping to call url generation
      mappings = "<leader>gy",
    },
    callbacks = {
      ["achicir2"] = function(url)
        url.host = "github.com"
        return require("gitlinker.hosts").get_github_type_url(url)
      end,
      ["mizunogitlab"] = function(url)
        url.host = "gitlab.com"
        return require("gitlinker.hosts").get_gitlab_type_url(url)
      end,
    },
  }
end

return M
