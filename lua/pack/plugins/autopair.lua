local lazy = require("pack.lazy-load")

lazy.on_event(
  { src = "https://github.com/altermo/ultimate-autopair.nvim", version = "v0.6" },
  { "InsertEnter", "CmdlineEnter" },
  function()
    require('ultimate-autopair').setup({
      fastwarp = {
        map = "<c-l>",
        rmap = "<c-h>",
        cmap = "<c-l>",
        rcmap = "<c-h>",
        multiline = false,
      },
    })
  end
)
