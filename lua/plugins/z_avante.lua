---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    version = false, -- Never set this value to "*"! Never!
    keys = {
      {
        "<leader>ua",
        "<cmd>AvanteChatNew<cr>",
        desc = "avante: ask",
        mode = { "n", "v" },
      },
      {
        "<leader>uf",
        "<cmd>AvanteHistory<cr>",
        desc = "avante: history",
        mode = { "n" },
      },
      {
        "<leader>ur",
        "<cmd>AvanteRefresh<cr>",
        desc = "avante: refresh",
        mode = "v",
      },
      {
        "<leader>ue",
        "<cmd>AvanteEdit<cr>",
        desc = "avante: edit",
        mode = { "n", "v" },
      },
    },
    opts = {
      provider = "copilot",
      selector = {
        provider = "snacks",
      },
      behaviour = {
        use_cwd_as_project_root = true,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "folke/snacks.nvim",
      {
        "saghen/blink.cmp",
        dependencies = {
          "Kaiser-Yang/blink-cmp-avante",
        },
        opts = function(_, opts)
          table.insert(opts.sources.default, 1, "avante")

          opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
            providers = {
              avante = {
                module = "blink-cmp-avante",
                name = "Avante",
                opts = {
                  -- options for blink-cmp-avante
                },
              },
            },
          })
          return opts
        end,
      },
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
