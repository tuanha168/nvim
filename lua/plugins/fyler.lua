return {
  {
    "A7Lavinraj/fyler.nvim",
    -- enabled = false,
    cmd = "Fyler",
    keys = {
      { "<C-n>", "<cmd>Fyler<CR>" },
    },
    -- commit = "d87e4281e18712361f82a07f9fca71957244ef33",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      views = {
        explorer = {
          width = 0.3,
          height = 0.3,
          kind = "split:left",
          border = "single",
        },
        confirm = {
          width = 0.5,
          height = 0.4,
          kind = "float",
          border = "single",
        },
      },
    },
  },
}
