return function()
  local m = require "markid"
  m.queries.vue = m.queries.typescript
  local configs = require "nvim-treesitter.configs"
  configs.setup {
    markid = {
      enable = true,
      colors = m.colors.bright,
    },
  }
end
