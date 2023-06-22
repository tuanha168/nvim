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
          [[  _________  .__     .__                                  ]],
          [[  \_   ___ \ |  |__  |__|_______  __ __   ____    ____    ]],
          [[  /    \  \/ |  |  \ |  |\_  __ \|  |  \ /    \  /  _ \   ]],
          [[  \     \____|   Y  \|  | |  | \/|  |  /|   |  \(  <_> )  ]],
          [[   \______  /|___|  /|__| |__|   |____/ |___|  / \____/   ]],
          [[          \/      \/                         \/           ]],
          [[              ]],
          --
          -- [[                                             ]],
          -- [[   ___|  |     _)                            ]],
          -- [[  |      __ \   |   __|  |   |  __ \    _ \  ]],
          -- [[  |      | | |  |  |     |   |  |   |  (   | ]],
          -- [[ \____| _| |_| _| _|    \__,_| _|  _| \___/  ]],
          -- [[                                             ]],
          --
          -- [[                                  __]],
          -- [[     ___     ___    ___   __  __ /\_\    ___ ___]],
          -- [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
          -- [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
          -- [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
          -- [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
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

  { "wellle/targets.vim", event = "BufEnter" },

  -- {
  --   "andymass/vim-matchup",
  --   event = "BufRead",
  --   config = function() require("user.config.vim-matchup").setup() end,
  -- },

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
      -- noice = true,
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
        pre_open = function() vim.cmd ":bd!" end,
        -- Called after a file is opened
        -- Passed the buf id, win id, and filetype of the new window
        -- post_open = function(bufnr, winnr, filetype)
        --   local utils = require "astronvim.utils"
        --   if filetype ~= "gitcommit" then
        --     vim.defer_fn(function()
        --       utils.toggle_term_cmd "lazygit"
        --       vim.cmd ":bd!"
        --     end, 50)
        --   else
        --     vim.api.nvim_create_autocmd("BufWritePost", {
        --       buffer = bufnr,
        --       once = true,
        --       callback = function()
        --         -- This is a bit of a hack, but if you run bufdelete immediately
        --         -- the shell can occasionally freeze
        --         vim.defer_fn(function()
        --           vim.api.nvim_buf_delete(bufnr, {})
        --           utils.toggle_term_cmd "lazygit"
        --         end, 50)
        --       end,
        --     })
        --   end
        -- end,
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
    "terryma/vim-expand-region",
    event = "BufRead",
    config = function()
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

  -- {
  --   "samodostal/image.nvim",
  --   event = "BufRead",
  --   build = "ascii-image-converter -h",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "m00qek/baleia.nvim",
  --   },
  --   opts = {
  --     render = {
  --       min_padding = 5,
  --       show_label = true,
  --       use_dither = true,
  --       foreground_color = true,
  --       background_color = true,
  --     },
  --     events = {
  --       update_on_nvim_resize = true,
  --     },
  --   },
  -- },

  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make" },
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   config = function()
  --     -- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
  --     -- An alternative solution: https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
  --     local banned_messages = { "No information available" }
  --     vim.notify = function(msg, ...)
  --       for _, banned in ipairs(banned_messages) do
  --         if msg == banned then return end
  --       end
  --       return require "notify"(msg, ...)
  --     end
  --   end,
  -- },

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
        prev = "N",
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

  {
    "jonatan-branting/nvim-better-n",
    event = "BufEnter",
    opts = function()
      vim.keymap.set("n", "n", require("better-n").n, { nowait = true })
      vim.keymap.set("n", "N", require("better-n").shift_n, { nowait = true })

      return {
        callbacks = {
          mapping_executed = function(_mode, _key)
            -- Clear highlighting, indicating that `n` will not goto the next
            -- highlighted search-term
            vim.cmd [[ nohl ]]
          end,
        },
        mappings = {
          ["F"] = { previous = ";", next = "," },
          ["T"] = { previous = ";", next = "," },

          ["#"] = { previous = "n", next = "<s-n>" },
          ["?"] = { previous = "n", next = "<s-n>", cmdline = true },

          ["[d"] = { previous = "[d", next = "]d" },
          ["]d"] = { previous = "[d", next = "]d" },

          ["[g"] = { previous = "[g", next = "]g" },
          ["]g"] = { previous = "[g", next = "]g" },

          ["[c"] = { previous = "[c", next = "]c" },
          ["]c"] = { previous = "[c", next = "]c" },
        },
      }
    end,
  },

  -- {
  --   "ja-ford/delaytrain.nvim",
  --   opts = {
  --     keys = { -- Which keys (in which modes) should be delayed
  --       ["nv"] = { "h", "j", "k", "l", "gj", "gk" },
  --       ["nvi"] = { "<Left>", "<Down>", "<Up>", "<Right>" },
  --     },
  --   },
  --   event = "BufRead",
  -- },

  -- {
  --   "dawsers/edit-code-block.nvim",
  --   cmd = "EditCodeBlock",
  --   opts = {},
  -- },

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
  --   enabled = false,
  -- },
}
