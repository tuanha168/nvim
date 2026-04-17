require("which-key").add {
  -- vim.keymap.set('n', '[[', '<Nop>')
  -- ["*"] = { '"ayiwh/<c-r>a<CR>' },
  { "<Leader>r",  function() Chiruno.func.operatorfunc_lua "replace_motion" end },
  -- Gitsigns
  { "[g",         function() require("gitsigns").nav_hunk "prev" end,           desc = "Previous Git hunk" },
  { "]g",         function() require("gitsigns").nav_hunk "next" end,           desc = "Next Git hunk" },
  -- ["H"] = { "^" },
  -- ["L"] = { "$" },
  { "<Leader>pp", "<cmd>Gitsigns preview_hunk<CR>" },

  -- swap gj gk
  { "k",          "gk",                                                         silent = true,                   mode = { "n", "v" } },
  { "j",          "gj",                                                         silent = true,                   mode = { "n", "v" } },
  { "gk",         "k",                                                          silent = true,                   mode = { "n", "v" } },
  { "gj",         "j",                                                          silent = true,                   mode = { "n", "v" } },

  -- Moving
  { "K",          ":m .-2<CR>==",                                               silent = true },
  { "J",          ":m .+1<CR>==",                                               silent = true },
  { "}",          "<C-d>zz" },
  { "{",          "<C-u>zz" },
  -- Close Preview
  { "<CR>",       "<CR>zz",                                                     silent = true },
  -- ["q"] = { "<ESC>:ccl<CR>q", silent = true },
  -- Yank
  { "<Leader>y",  '"+y',                                                        desc = "Yank system clipboard",  noremap = true },
  { "<Leader>Y",  '"+y$',                                                       desc = "Yank system clipboard",  noremap = true },
  { "<Leader>p",  '"+p',                                                        desc = "Paste system clipboard", noremap = true },
  { "<Leader>P",  '"+P',                                                        desc = "Paste system clipboard", noremap = true },

  -- Disable Yank
  { "c",          '"_c' },
  { "C",          '"_C' },
  -- Illuminate
  { "(",          function() require("illuminate").goto_next_reference() end },
  { ")",          function() require("illuminate").goto_prev_reference() end },
  { "+",          "<C-a>",                                                      noremap = true },
  { "-",          "<C-x>",                                                      noremap = true },
  { "<C-z>i",     "<C-i>" },
  {
    "dd",
    function()
      if vim.api.nvim_get_current_line():match "^%s*$" then
        return vim.cmd 'normal! "_dd'
      else
        return vim.cmd "normal! dd"
      end
    end,
  },
  { "<Leader>fd", function() Chiruno.func.run_make() end,                         desc = "Run make",               noremap = true },
  { "]c",         "<cmd>cn<CR>",                                                  desc = "Next error",             noremap = true },
  { "[c",         "<cmd>cp<CR>",                                                  desc = "Previous error",         noremap = true },
  -- {
  --   "<Leader>du",
  --   function()
  --     local ok, dapui = pcall(require, "dapui")
  --     if not ok then return end

  --     dapui.toggle()
  --   end,
  --   desc = "Toggle Debugger UI",
  -- },

  -- ["*"] = { function() Chiruno.func.operatorfunc_lua "search" end },
  { "<Leader>r",  function() Chiruno.func.operatorfunc_lua "replace_motion" end,  mode = { "v" } },
  -- Gitsigns
  { "<c-u>",      ":Gitsigns undo_stage_hunk<CR>",                                silent = true },
  { "<c-s>",      ":Gitsigns stage_hunk<CR>",                                     silent = true,                   mode = { "n", "v" } },
  { "u",          ":Gitsigns reset_hunk<CR>",                                     silent = true,                   mode = { "v" } },
  -- Moving
  { "K",          ":m '<-2<CR><CR>gv=gv",                                         silent = true,                   mode = { "v" } },
  { "J",          ":m '>+1<CR><CR>gv=gv",                                         silent = true,                   mode = { "v" } },
  { "<",          "<gv",                                                          mode = { "v" } },
  { ">",          ">gv",                                                          mode = { "v" } },
  { "=",          "=gv",                                                          mode = { "v" } },

  -- Disable Yank
  { "c",          '"_c',                                                          mode = { "v" } },
  { "C",          '"_C',                                                          mode = { "v" } },
  { "+",          "<C-a>",                                                        noremap = true,                  mode = { "v" } },
  { "-",          "<C-x>",                                                        noremap = true,                  mode = { "v" } },
  { "g+",         "g<C-a>",                                                       noremap = true,                  mode = { "v" } },
  { "g-",         "g<C-x>",                                                       noremap = true,                  mode = { "v" } },

  { "<M-BS>",     "<C-w>",                                                        noremap = true,                  mode = { "i" } },

  -- swap p
  { "p",          "P",                                                            mode = { "x" } },
  { "P",          "p",                                                            mode = { "x" } },

  { "gG",         ":<c-u>normal! ggVG<cr>",                                       desc = "Buffer as text object",  mode = { "x", "o" } },

  { "<Tab>",      "<cmd>bn<CR>",                                                  desc = "Move to next buffer" },
  { "<S-Tab>",    "<cmd>bp<CR>",                                                  desc = "Move to previous buffer" },

  { "<ESC>",      "<cmd>noh<CR>",                                                 desc = "No Highlight" },

  { "<C-h>",      function() require("smart-splits").move_cursor_left() end,      mode = { "n", "t" } },
  { "<C-j>",      function() require("smart-splits").move_cursor_down() end,      mode = { "n", "t" } },
  { "<C-k>",      function() require("smart-splits").move_cursor_up() end,        mode = { "n", "t" } },
  { "<C-l>",      function() require("smart-splits").move_cursor_right() end,     mode = { "n", "t" } },

  { "<A-h>",      function() require("smart-splits").resize_left() end,           mode = { "n", "t" } },
  { "<A-j>",      function() require("smart-splits").resize_down() end,           mode = { "n", "t" } },
  { "<A-k>",      function() require("smart-splits").resize_up() end,             mode = { "n", "t" } },
  { "<A-l>",      function() require("smart-splits").resize_right() end,          mode = { "n", "t" } },

  { "/",          "<Esc>/\\%V",                                                   desc = "Search in visual mode",  mode = { "x" } },
  { "?",          "<Esc>?\\%V",                                                   desc = "Search in visual mode",  mode = { "x" } },

  -- Joinlines
  { "gJ",         "mzJ`z:delmarks z<CR>",                                         desc = "Join lines",             mode = { "n" } },

  -- snippet
  { "gl",         function() Chiruno.func.operatorfunc_lua "console_log" end,     mode = { "n", "x" } },

  -- treesitter
  { "<S-Up>",     "van", desc = "Select around node",    mode = { "n", "v" } },
  { "<S-Down>",   "vin", desc = "Select inner node",      mode = { "n", "v" } },
  { "<S-Up>",     function() require "vim.treesitter._select".select_parent(1) end, desc = "Select around node",    mode = { "x" } },
  { "<S-Down>",   function() require "vim.treesitter._select".select_child(1) end, desc = "Select inner node",      mode = { "x" } },
}
