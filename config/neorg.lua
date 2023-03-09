require("neorg").setup {
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.highlights"] = {
      config = {
        highlights = {
          modifiers = { escape = "+@spell" },
        },
      },
    },
    ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.norg.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/neorg",
        },
      },
    },
    ["core.norg.esupports.metagen"] = {
      config = {
        type = "auto",
        template = {
          { "title", "" },
          { "description", "" },
          { "authors", "TuanHA" },
          { "categories", "notes" },
          {
            "created",
            function()
              return os.date "%Y-%m-%d"
            end,
          },
          {
            "updated",
            function()
              return os.date "%Y-%m-%d"
            end,
          },
          { "version", "0.1.0" },
        },
      },
    },
    ["core.export"] = {},
  },
}
