---@type LazySpec
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
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = {
      ignore = "^$",
    },
    config = function(_, opts)
      local ft = require "Comment.ft"
      ft.set("dosini", "# %s")
      ft.set("hyprlang", "# %s")
      require("Comment").setup(opts)
    end,
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
  --   config = function() require("config.leap").setup() end,
  -- },

  -- {
  --   "rlane/pounce.nvim",
  --   keys = "s",
  --   opts = function()
  --     local map = vim.keymap.set
  --     map("n", "s", function() require("pounce").pounce {} end)
  --     return {}
  --   end,
  -- },

  -- {
  --   "folke/flash.nvim",
  --   opts = {},
  --   keys = {
  --     {
  --       "s",
  --       mode = { "n", "x", "o" },
  --       function()
  --         -- default options: exact mode, multi window, all directions, with a backdrop
  --         require("flash").jump()
  --       end,
  --     },
  --     -- {
  --     --   "S",
  --     --   mode = { "o", "x" },
  --     --   function() require("flash").treesitter() end,
  --     -- },
  --   },
  -- },

  { "wellle/targets.vim", event = "BufEnter" },

  -- {
  --   "andymass/vim-matchup",
  --   event = "BufRead",
  --   config = function() require("config.vim-matchup").setup() end,
  -- },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    event = "BufRead",
    config = function()
      vim.keymap.set("n", "<C-y>", function()
        vim.cmd "UndotreeToggle"
        vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.ToggleWindow, modeline = false })
      end, { silent = true })
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "BufReadPre",
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup {
        floating_window = false,
        bind = true,
        hint_enable = false,
        handler_opts = {
          border = "rounded",
        },
        always_trigger = true,
        toggle_key = "<C-z>i",
        toggle_key_flip_floatwin_setting = true,
      }
    end,
  },

  -- {
  --   "willothy/flatten.nvim",
  --   lazy = false,
  --   opts = {
  --     callbacks = {
  --       -- Called when a request to edit file(s) is received
  --       pre_open = function() vim.cmd ":bd!" end,
  --       -- Called after a file is opened
  --       -- Passed the buf id, win id, and filetype of the new window
  --       -- post_open = function(bufnr, winnr, filetype)
  --       --   local utils = require "astronvim.utils"
  --       --   if filetype ~= "gitcommit" then
  --       --     vim.defer_fn(function()
  --       --       utils.toggle_term_cmd "lazygit"
  --       --       vim.cmd ":bd!"
  --       --     end, 50)
  --       --   else
  --       --     vim.api.nvim_create_autocmd("BufWritePost", {
  --       --       buffer = bufnr,
  --       --       once = true,
  --       --       callback = function()
  --       --         -- This is a bit of a hack, but if you run bufdelete immediately
  --       --         -- the shell can occasionally freeze
  --       --         vim.defer_fn(function()
  --       --           vim.api.nvim_buf_delete(bufnr, {})
  --       --           utils.toggle_term_cmd "lazygit"
  --       --         end, 50)
  --       --       end,
  --       --     })
  --       --   end
  --       -- end,
  --       -- post_open = function() end,
  --       -- Called when a file is open in blocking mode, after it's done blocking
  --       -- (after bufdelete, bufunload, or quitpre for the blocking buffer)
  --       -- block_end = function()
  --       --   local openLazygit = vim.api.nvim_replace_termcodes("<leader>gg", true, false, true)
  --       --   local quit = vim.api.nvim_replace_termcodes("i<Enter>q", true, false, true)
  --       --   vim.api.nvim_feedkeys(openLazygit, "m", false)
  --       --   vim.defer_fn(function() vim.api.nvim_feedkeys(quit, "m", false) end, 500)
  --       -- end,
  --     },
  --     window = {
  --       open = "current",
  --       focus = "first",
  --     },
  --   },
  -- },

  {
    "chrisgrieser/nvim-spider",
    event = "BufRead",
    opts = { skipInsignificantPunctuation = false },
    config = function()
      -- Keymaps
      vim.keymap.set({ "n", "o", "x" }, "w", function() require("spider").motion("w", {}) end, { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", function() require("spider").motion("e", {}) end, { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", function() require("spider").motion("b", {}) end, { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", function() require("spider").motion("ge", {}) end, { desc = "Spider-ge" })
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

  -- {
  --   "terryma/vim-expand-region",
  --   event = "BufRead",
  --   config = function()
  --     vim.cmd [[
  --       call expand_region#custom_text_objects({
  --         \ 'a]' :1,
  --         \ 'ab' :1,
  --         \ 'aB' :1,
  --         \ })
  --     ]]
  --   end,
  -- },

  -- {
  --   "AckslD/muren.nvim",
  --   opts = true,
  --   cmd = { "MurenFresh" },
  -- },

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
  -- {
  --   "3rd/image.nvim",
  --   event = "BufRead",
  --   config = function() require("image").setup() end,
  --   dependencies = {
  --     {
  --       "theHamsta/nvim_rocks",
  --       build = "pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
  --       config = function()
  --         ---- Add here the packages you want to make sure that they are installed
  --         local nvim_rocks = require "nvim_rocks"
  --         nvim_rocks.ensure_installed { "magick", "cffi-lua" }
  --         local magick = require "magick"
  --         Chiruno.func.print(magick)
  --       end,
  --     },
  --   },
  -- },

  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make" },
  },

  -- {
  --   "JASONews/glow-hover",
  --   opts = function()
  --     return {
  --       -- The followings are the default values
  --       max_width = 50,
  --       padding = 10,
  --       border = "shadow",
  --       glow_path = "glow",
  --     }
  --   end,
  --   event = "LspAttach",
  -- },

  -- {
  --   "dmmulroy/tsc.nvim",
  --   cmd = "TSC",
  --   opts = {
  --     bin_path = "./node_modules/.bin/vue-tsc",
  --   },
  -- },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },

  -- {
  --   "folke/noice.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   lazy = false,
  --   opts = function()
  --     vim.keymap.set({ "n", "i", "s" }, "<c-d>", function()
  --       if not require("noice.lsp").scroll(4) then return "<c-d>" end
  --     end, { silent = true, expr = true })
  --
  --     vim.keymap.set({ "n", "i", "s" }, "<c-u>", function()
  --       if not require("noice.lsp").scroll(-4) then return "<c-u>" end
  --     end, { silent = true, expr = true })
  --
  --     return {
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --         hover = {
  --           silent = true,
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true, -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --     }
  --   end,
  -- },

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
    enabled = false,
    event = "InsertEnter",
    opts = function(_, opts)
      opts.fast_wrap.map = "<C-l>"
      opts.fast_wrap.keys = "hjklnmyuiopqwertasdfgzxcvb"
      opts.fast_wrap.highlight = "DiffAdd"
      opts.fast_wrap.pattern = string.gsub([[ [%.%:%'%"%)%>%]%)%}%,] ]], "%s+", "")
      return opts
    end,
  },

  {
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
  },

  -- {
  --   "jonatan-branting/nvim-better-n",
  --   event = "BufEnter",
  --   opts = function()
  --     vim.keymap.set("n", "n", require("better-n").n, { nowait = true })
  --     vim.keymap.set("n", "N", require("better-n").shift_n, { nowait = true })
  --
  --     return {
  --       callbacks = {
  --         mapping_executed = function(_mode, _key)
  --           -- Clear highlighting, indicating that `n` will not goto the next
  --           -- highlighted search-term
  --           vim.cmd [[ nohl ]]
  --         end,
  --       },
  --       mappings = {
  --         ["F"] = { previous = ";", next = "," },
  --         ["T"] = { previous = ";", next = "," },
  --
  --         ["#"] = { previous = "n", next = "<s-n>" },
  --         ["?"] = { previous = "n", next = "<s-n>", cmdline = true },
  --
  --         ["[d"] = { previous = "[d", next = "]d" },
  --         ["]d"] = { previous = "[d", next = "]d" },
  --
  --         ["[g"] = { previous = "[g", next = "]g" },
  --         ["]g"] = { previous = "[g", next = "]g" },
  --
  --         ["[c"] = { previous = "[c", next = "]c" },
  --         ["]c"] = { previous = "[c", next = "]c" },
  --       },
  --     }
  --   end,
  -- },

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

  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.cmd "let g:VM_default_mappings = 0"
      vim.cmd "let g:VM_maps = {}"
      vim.cmd 'let g:VM_maps["Find Under"] = "<C-e>"'
      vim.cmd 'let g:VM_maps["Find Subword Under"] = "<C-e>"'
      vim.cmd 'let g:VM_maps["Switch Mode"] = "v"'
    end,
  },
  -- {
  --   "smoka7/multicursors.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "smoka7/hydra.nvim",
  --   },
  --   opts = {
  --     hint_config = false,
  --   },
  --   cmd = { "MCstart" },
  --   keys = {
  --     {
  --       mode = { "v", "n" },
  --       "<C-e>",
  --       "<cmd>MCstart<cr>",
  --       desc = "Create a selection for selected text or word under the cursor",
  --     },
  --   },
  -- },

  {
    "aznhe21/actions-preview.nvim",
    opts = {
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
      },
    },
  },

  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>K", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
    },
    opts = {
      border = "rounded", -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = false, -- Sets the preview as the current window
    },
  },

  {
    "9seconds/repolink.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "RepoLink" },
    keys = {
      {
        "<leader>gL",
        function()
          local prefix = ""
          if vim.api.nvim_get_mode().mode == "V" or vim.api.nvim_get_mode().mode == "v" then prefix = "'<,'>" end
          vim.ui.input({ prompt = "Origin (default: origin): " }, function(origin)
            if origin == nil or origin == "" then origin = "origin" end
            local current_branch = string.sub(vim.fn.system "git branch --show-current", 1, -2)
            vim.ui.input({ prompt = "Branch:", default = current_branch }, function(branch)
              if branch == nil or branch == "" then branch = current_branch end
              Chiruno.func.feedkeys(":" .. prefix .. "RepoLink! " .. branch .. " " .. origin .. "<CR>", "n")
            end)
          end)
        end,
        mode = { "n", "x" },
        desc = "RepoLink",
      },
    },
    opts = function()
      local api = require "repolink.api"
      return {
        url_builders = {
          ["yopaz"] = api.url_builder_for_github(),
          ["yopaz-liberty"] = api.url_builder_for_github(),
          -- ["bitbucket.org"] = require("repolink").url_builder_for_bitbucket "https://bitbucket.org",
          -- ["gitlab.com"] = require("repolink").url_builder_for_gitlab "https://gitlab.com",
          -- ["git.sr.ht"] = require("repolink").url_builder_for_sourcehut "https://git.sr.ht",
        },
      }
    end,
  },

  -- {
  --   "dstein64/vim-startuptime",
  --   cmd = "StartupTime",
  --   config = function() vim.g.startuptime_tries = 10 end,
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

  { -- TODO: REMOVE neovim-session-manager with AstroNvim v4
    "Shatur/neovim-session-manager",
    enabled = false,
  },
  {
    "pocco81/high-str.nvim",
    keys = {
      { "<leader>1", ":<c-u>HSHighlight 1<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>2", ":<c-u>HSHighlight 2<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>3", ":<c-u>HSHighlight 3<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>4", ":<c-u>HSHighlight 4<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>5", ":<c-u>HSHighlight 5<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>6", ":<c-u>HSHighlight 6<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>7", ":<c-u>HSHighlight 7<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>8", ":<c-u>HSHighlight 8<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>9", ":<c-u>HSHighlight 9<CR>", mode = "v", noremap = true, silent = true },
      { "<leader>hc", ":<c-u>HSRmHighlight rm_all<CR>", mode = "n", noremap = true, silent = true },
      { "<leader>hc", ":<c-u>HSRmHighlight<CR>", mode = "v", noremap = true, silent = true },
    },
  },
  { "Aasim-A/scrollEOF.nvim", opts = {}, event = "BufEnter" },
  -- {
  --   "stevearc/oil.nvim",
  --   keys = {
  --     {
  --       "<leader>-",
  --       function()
  --         local oil = require "oil"
  --         oil.toggle_float()
  --       end,
  --       mode = "n",
  --     },
  --   },
  --   opts = {},
  -- },
  {
    "vuki656/package-info.nvim",
    lazy = false,
    dependency = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup {
        colors = {
          up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
          outdated = "#d19a66", -- Text color for outdated dependency virtual text
        },
        icons = {
          enable = true, -- Whether to display icons
          style = {
            up_to_date = "|  ", -- Icon for up to date dependencies
            outdated = "|  ", -- Icon for outdated dependencies
          },
        },
        autostart = true, -- Whether to autostart when `package.json` is opened
        hide_up_to_date = false, -- It hides up to date versions when displaying virtual text
        hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
        -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
        -- The plugin will try to auto-detect the package manager based on
        -- `yarn.lock` or `package-lock.json`. If none are found it will use the
        -- provided one, if nothing is provided it will use `yarn`
        package_manager = "yarn",
      }
    end,
  },
  {
    "lambdalisue/vim-suda",
    opts = function() vim.cmd "let g:suda_smart_edit = 1" end,
  },
}
