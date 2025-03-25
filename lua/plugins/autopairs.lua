return {
  "altermo/ultimate-autopair.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  branch = "v0.6",
  opts = {
    fastwarp = {
      map = "<c-l>", --string or table
      rmap = "<c-h>", --string or table
      cmap = "<c-l>", --string or table
      rcmap = "<c-h>", --string or table
      multiline = false,
    },
  },
}
