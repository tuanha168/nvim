return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.config = require("alpha.themes.startify").config
      -- customize the dashboard header
      opts.config.layout[2] = {
        type = "text",
        val = {
          [[                                  __]],
          [[     ___     ___    ___   __  __ /\_\    ___ ___]],
          [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
          [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
          [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
          [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        },
        opts = {
          hl = "Type",
          shrink_margin = false,
          -- wrap = "overflow";
        },
      }
      return opts
    end,
  },

  { "kylechui/nvim-surround", event = "BufRead", opts = {} },

  {
    "numToStr/Comment.nvim",
    opts = function(_, opts) require("Comment").setup(opts) end,
    config = function() require "user.config.comment" end,
  },

  {
    "max397574/better-escape.nvim",
    opts = function(_, opts)
      opts.mapping = { "jk", "jj", "kk" }
      opts.clear_empty_lines = true
      return opts
    end,
  },

  -- {
  --   "ggandor/leap.nvim",
  --   event = "BufRead",
  --   opts = function(_, opts) require("leap").setup(opts) end,
  --   config = function() require("user.config.leap").setup() end,
  -- },

  {
    "rlane/pounce.nvim",
    keys = "s",
    opts = function()
      local map = vim.keymap.set
      map("n", "s", function() require("pounce").pounce {} end)
      return {}
    end,
  },

  -- { "wellle/targets.vim", event = "BufEnter" },

  {
    "andymass/vim-matchup",
    event = "BufRead",
    config = function() require("user.config.vim-matchup").setup() end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    event = "BufRead",
    config = function() vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>UndotreeToggle<CR>", { silent = true }) end,
  },

  {
    "RRethy/vim-illuminate",
    event = "BufRead",
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      floating_window = false,
      bind = false,
      noice = true,
      hint_enable = false,
    },
  },

  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    build = "npm install -g tsun",
  },

  {
    "willothy/flatten.nvim",
    lazy = false,
    opts = {
      callbacks = {
        -- Called when a request to edit file(s) is received
        pre_open = function()
          local utils = require "astronvim.utils"
          utils.toggle_term_cmd "lazygit"
        end,
        -- Called after a file is opened
        -- Passed the buf id, win id, and filetype of the new window
        post_open = function(bufnr, winnr, filetype)
          local utils = require "astronvim.utils"
          if filetype ~= "gitcommit" then
            vim.defer_fn(function()
              utils.toggle_term_cmd "lazygit"
              vim.cmd ":bd!"
            end, 50)
          else
            vim.api.nvim_create_autocmd("BufWritePost", {
              buffer = bufnr,
              once = true,
              callback = function()
                -- This is a bit of a hack, but if you run bufdelete immediately
                -- the shell can occasionally freeze
                vim.defer_fn(function()
                  vim.api.nvim_buf_delete(bufnr, {})
                  utils.toggle_term_cmd "lazygit"
                end, 50)
              end,
            })
          end
        end,
        -- post_open = function() end,
        -- Called when a file is open in blocking mode, after it's done blocking
        -- (after bufdelete, bufunload, or quitpre for the blocking buffer)
        -- block_end = function()
        --   local openLazygit = vim.api.nvim_replace_termcodes("<leader>gg", true, false, true)
        --   local quit = vim.api.nvim_replace_termcodes("i<Enter>q", true, false, true)
        --   vim.api.nvim_feedkeys(openLazygit, "m", false)
        --   vim.defer_fn(function() vim.api.nvim_feedkeys(quit, "m", false) end, 500)
        -- end,
      },
      window = {
        open = "current",
        focus = "first",
      },
    },
  },

  {
    "chrisgrieser/nvim-spider",
    event = "BufRead",
    opts = { skipInsignificantPunctuation = false },
    config = function()
      -- Keymaps
      vim.keymap.set({ "n", "o", "x" }, "w", function() require("spider").motion "w" end, { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", function() require("spider").motion "e" end, { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", function() require("spider").motion "b" end, { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", function() require("spider").motion "ge" end, { desc = "Spider-ge" })
    end,
  },

  -- {
  --   -- Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}
  --   "knubie/vim-kitty-navigator",
  --   build = "cp ./*.py ~/.config/kitty/",
  --   lazy = false,
  -- },

  {
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        enable = false,
      },
    },
  },

  -- {
  --   "Fildo7525/pretty_hover",
  --   event = "LspAttach",
  --   opts = {},
  -- },

  {
    "napisani/nvim-github-codesearch",
    -- build = "make",
    opts = {
      -- an optional table entry to explicitly configure the API key to use for Github API requests.
      -- alternatively, you can configure this parameter by export an environment variable named "GITHUB_AUTH_TOKEN"
      github_auth_token = "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",

      -- this table entry is optional, if not provided "https://api.github.com" will be used by default
      -- otherwise this parameter can be used to configure a different Github API URL.
      github_api_url = "https://api.github.com",

      -- whether to use telescope to display the github search results or not
      use_telescope = true,
    },
    -- config = function() require("nvim-github-codesearch").cleanup() end,
  },

  {
    "terryma/vim-expand-region",
    event = "BufRead",
    config = function()
      vim.keymap.set({ "n", "v", "x" }, "<S-Up>", "<Plug>(expand_region_expand)", { noremap = false, silent = true })
      vim.keymap.set({ "n", "v", "x" }, "<S-Down>", "<Plug>(expand_region_shrink)", { noremap = false, silent = true })
      vim.cmd [[
        call expand_region#custom_text_objects({
          \ 'a]' :1,
          \ 'ab' :1,
          \ 'aB' :1,
          \ })
      ]]
    end,
  },

  {
    "AckslD/muren.nvim",
    opts = true,
    cmd = { "MurenFresh" },
  },

  {
    "ziontee113/icon-picker.nvim",
    opts = function()
      vim.keymap.set(
        "n",
        "<leader>ip",
        "<cmd>IconPickerNormal<CR>",
        { noremap = true, silent = true, desc = "Icon Picker" }
      )
    end,
    keys = { { "<leader>ip", mode = { "n" } } },
    cmd = "IconPickerNormal",
  },

  {
    "samodostal/image.nvim",
    event = "BufRead",
    build = "ascii-image-converter -h",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
    opts = {
      render = {
        min_padding = 5,
        show_label = true,
        use_dither = true,
        foreground_color = true,
        background_color = true,
      },
      events = {
        update_on_nvim_resize = true,
      },
    },
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    lazy = false,
    opts = function()
      vim.keymap.set({ "n", "i", "s" }, "<c-d>", function()
        if not require("noice.lsp").scroll(4) then return "<c-d>" end
      end, { silent = true, expr = true })

      vim.keymap.set({ "n", "i", "s" }, "<c-u>", function()
        if not require("noice.lsp").scroll(-4) then return "<c-u>" end
      end, { silent = true, expr = true })
      return {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            silent = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    event = "BufRead",
    opts = {
      default_mappings = {
        ours = "cc",
        theirs = "ic",
        none = "dd",
        both = "<Enter>",
        next = "n",
        prev = "p",
      },
      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffDelete",
        current = "DiffText",
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = function(_, opts)
      opts.fast_wrap.map = "<C-t>"
      opts.fast_wrap.keys = "hjklnmyuiopqwertasdfgzxcvb"
      opts.fast_wrap.highlight = "DiffAdd"
      opts.fast_wrap.pattern = string.gsub([[ [%.%:%'%"%)%>%]%)%}%,] ]], "%s+", "")
      return opts
    end,
  },

  -- {
  --   "mg979/vim-visual-multi",
  --   branch = "master",
  --   event = "BufRead",
  -- },

  -- {
  --   "chrisgrieser/nvim-various-textobjs",
  --   event = "BufRead",
  --   opts = { useDefaultKeymaps = true },
  -- },

  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "BufRead",
  --   opts = {},
  -- },

  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     plugin.default_config(opts)
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}
