return function()
  local m = require "markid"
  m.queries.vue = m.queries.typescript
  m.queries.php = [[
    (variable_name) @markid
  ]]
  local configs = require "nvim-treesitter.configs"
  configs.setup {
    markid = {
      enable = true,
      colors = m.colors.bright,
      query = m.queries,
    },
  }
end
