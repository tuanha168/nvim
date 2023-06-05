return {
  {
    "nvim-neorg/neorg",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-cmp",
      "nvim-lua/plenary.nvim",
    },
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.autocommands"] = {},
        ["core.highlights"] = {},
        ["core.mode"] = {},
        ["core.neorgcmd"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.concealer"] = { config = { icon_preset = "diamond" } },
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.keybinds"] = { config = { default_keybinds = true, neorg_leader = "<Leader><Leader>" } },
        ["core.dirman"] = {
          config = {
            default_workspace = "neorg",
            workspaces = {
              neorg = "~/neorg",
            },
          },
        },
      },
    },
  },
}
