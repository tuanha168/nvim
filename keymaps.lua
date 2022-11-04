-- lua/custom/mappings
local M = {}
local opts = { silent = true, noremap = true }

-- add this table only when you want to disable default keys
M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<C-s>"] = "",
    ["<leader>x"] = "",
    ["<leader>wK"] = "",
    ["<leader>wk"] = "",
    ["<leader>tt"] = "",
  },
}

M.terminal = {
  n = {
    ["<c-T>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
  },
  t = {
    ["<c-T>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "toggle horizontal term",
    },
    -- ["<leader><ESC><ESC>"] = {
    --   function()
    --     require("nvterm.terminal").toggle "float"
    --   end,
    --   "toggle floating term",
    -- },
  },
}

M.windowMove = {
  n = {
    ["<C-h>"] = { "<C-w>h", "", opts = opts },
    ["<C-j>"] = { "<C-w>j", "", opts = opts },
    ["<C-k>"] = { "<C-w>k", "", opts = opts },
    ["<C-l>"] = { "<C-w>l", "", opts = opts },
  },
}

M.advanceSearch = {
  n = {
    ["*"] = { '"ayiwh/<c-r>a<CR>', "", opts = opts },
    ["<leader>fiw"] = { '"ayiwh/<c-r>a<CR><cmd> Telescope live_grep <CR>a<c-r>a<esc>jk', "", opts = opts },
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>', "", opts = opts },
    ["<leader>fiw"] = { '"ayh/<c-r>a<CR><cmd> Telescope live_grep <CR>a<c-r>a<esc>jk', "", opts = opts },
  },
}

M.neoGit = {
  n = {
    ["<leader>gg"] = { ":Neogit<cr>", "", opts = opts },
    ["<leader>gd"] = { ":DiffviewOpen<cr>", "", opts = opts },
    ["<leader>gD"] = { ":DiffviewOpen main<cr>", "", opts = opts },
    ["<leader>gl"] = { ":Neogit log<cr>", "", opts = opts },
    ["<leader>gp"] = { ":Neogit push<cr>", "", opts = opts },
  },
}

M.gitSigns = {
  n = {
    ["H"] = { "<cmd>Gitsigns prev_hunk<CR>", "", opts = opts },
    ["L"] = { "<cmd>Gitsigns next_hunk<CR>", "", opts = opts },
    ["<leader>pp"] = { "<cmd>Gitsigns preview_hunk<CR>", "Git Actions", opts = opts },
  },
  v = {
    ["u"] = { ":Gitsigns reset_hunk<CR>", "", opts = opts },
  },
}

M.moving = {
  n = {
    ["K"] = { ":m .-2<CR>==", "", opts = opts },
    ["J"] = { ":m .+1<CR>==", "", opts = opts },
  },
  v = {
    ["K"] = { ":m '<-2<CR>gv=gv", "", opts = opts },
    ["J"] = { ":m '>+1<CR>gv=gv", "", opts = opts },
  },
}

M.visualIndent = {
  v = {
    ["<"] = { "<gv", "", opts = opts },
    [">"] = { ">gv", "", opts = opts },
    ["p"] = { '"_dP', "", opts = opts },
  },
}

M.keepCenter = {
  n = {
    ["n"] = { "nzzzv", "", opts = opts },
    ["<S-n>"] = { "Nzzzv", "", opts = opts },
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "jzz" : "gjzz"', opts = { expr = true, silent = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "kzz" : "gkzz"', opts = { expr = true, silent = true } },
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true, silent = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true, silent = true } },
    ["{"] = { "Hzz", "", opts = opts },
    ["}"] = { "Lzz", "", opts = opts },
    ["gd"] = { "gdzz", "", opts = opts },
    -- ["H"] = { "^", "", opts = opts },
    -- ["L"] = { "$", "", opts = opts },
  },
  -- v = {
  --   ["H"] = { "^", "", opts = opts },
  --   ["L"] = { "$", "", opts = opts },
  -- },
}

-- M.splitAndResize = {
--   n = {
--     ["<up>"] = { ":resize +2<CR>", "", opts = opts },
--     ["<down>"] = { ":resize -2<CR>", "", opts = opts },
--     ["<left>"] = { ":vertical resize -2<CR>", "", opts = opts },
--     ["<right>"] = { ":vertical resize +2<CR>", "", opts = opts },
--   },
--
--   v = {
--     ["<up>"] = { ":resize +2<CR>", "", opts = opts },
--     ["<down>"] = { ":resize -2<CR>", "", opts = opts },
--     ["<left>"] = { ":vertical resize -2<CR>", "", opts = opts },
--     ["<right>"] = { ":vertical resize +2<CR>", "", opts = opts },
--   },
-- }

M.closePreview = {
  n = {
    ["<CR>"] = { "<CR>zz:ccl<CR>", "", opts = { silent = true } },
    ["q"] = { "<ESC>:ccl<CR>q", "", opts = { silent = true } },
  },
}

M.yanky = {
  n = {
    -- ["p"] = { "<Plug>(YankyPutAfter)", "", opts = opts },
    -- ["P"] = { "<Plug>(YankyPutBefore)", "", opts = opts },
    -- ["gp"] = { "<Plug>(YankyGPutAfter)", "", opts = opts },
    -- ["gP"] = { "<Plug>(YankyGPutBefore)", "", opts = opts },
    -- ["<c-P>"] = { "<cmd>Telescope yank_history<CR>", "", opts = opts },
    ["p"] = { "<cmd>Telescope yank_history<CR>jk", "", opts = opts },
  },

  x = {
    ["p"] = { "<Plug>(YankyPutAfter)", "", opts = opts },
    ["P"] = { "<Plug>(YankyPutBefore)", "", opts = opts },
    ["gp"] = { "<Plug>(YankyGPutAfter)", "", opts = opts },
    ["gP"] = { "<Plug>(YankyGPutBefore)", "", opts = opts },
  },
}

M.telescope = {
  n = {
    ["``"] = {
      "<cmd> Telescope project <CR>",
      "",
      opts = opts,
    },
  },
}

M.closeTab = {
  n = {
    ["<leader>qq"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
        if vim.api.nvim_buf_get_name(0) == "" then
          require("nvchad_ui.tabufline").tabuflinePrev()
          if vim.api.nvim_buf_get_name(0) == "" then
            pcall(vim.cmd, ":Alpha")
            pcall(vim.cmd, ":bd#")
          end
        end
      end,
      "   close buffer",
      opts = opts,
    },
  },
}

M.toggleDiagnostics = {
  n = {
    ["<leader>tt"] = {
      function()
        vim.g.diagnostics_active = not vim.g.diagnostics_active
      end,
      "toggle diagnostics",
      opts = opts,
    },
  },
}

M.disableDeleteYank = {
  n = {
    ["c"] = {
      '"_c',
      "change no yank",
      opts = opts,
    },
  },
}

return M
