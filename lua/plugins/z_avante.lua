---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    version = false, -- Never set this value to "*"! Never!
    keys = function(_, keys)
      ---@type avante.Config
      local opts =
        require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

      local mappings = {
        {
          opts.mappings.ask,
          function() require("avante.api").ask() end,
          desc = "avante: ask",
          mode = { "n", "v" },
        },
        {
          opts.mappings.refresh,
          function() require("avante.api").refresh() end,
          desc = "avante: refresh",
          mode = "v",
        },
        {
          opts.mappings.edit,
          function() require("avante.api").edit() end,
          desc = "avante: edit",
          mode = { "n", "v" },
        },
      }
      mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      provider = "copilot",
      file_selector = {
        provider = "snacks",
      },
      mappings = {
        ask = "<leader>ua", -- ask
        edit = "<leader>ue", -- edit
        refresh = "<leader>ur", -- refresh
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
      {
        "saghen/blink.cmp",
        dependencies = {
          "Kaiser-Yang/blink-cmp-avante",
        },
        opts = function(_, opts)
          opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
            default = vim.tbl_deep_extend("force", {
              "avante",
            }, opts.sources.default or {}),
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

          Print(opts.sources)
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
