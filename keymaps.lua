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
  },
}

M.terminal = {
  n = {
    ["<c-T>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle horizontal term",
      opts = opts,
    },
  },
  t = {
    ["<c-T>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle horizontal term",
      opts = opts,
    },
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
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>', "", opts = opts },
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
    ["[c"] = { "<cmd>Gitsigns prev_hunk<CR>", "", opts = opts },
    ["]c"] = { "<cmd>Gitsigns next_hunk<CR>", "", opts = opts },
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
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "jzz" : "gjzz"', opts = { expr = true, silent = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "kzz" : "gkzz"', opts = { expr = true, silent = true } },
    ["H"] = { "^", "", opts = opts },
    ["L"] = { "$", "", opts = opts },
    ["gd"] = { "gdzz", "", opts = opts },
  },
  v = {
    ["H"] = { "^", "", opts = opts },
    ["L"] = { "$", "", opts = opts },
  }
}

M.splitAndResize = {
  n = {
    ["<up>"] = { ":resize +2<CR>", "", opts = opts },
    ["<down>"] = { ":resize -2<CR>", "", opts = opts },
    ["<left>"] = { ":vertical resize -2<CR>", "", opts = opts },
    ["<right>"] = { ":vertical resize +2<CR>", "", opts = opts },
  },

  v = {
    ["<up>"] = { ":resize +2<CR>", "", opts = opts },
    ["<down>"] = { ":resize -2<CR>", "", opts = opts },
    ["<left>"] = { ":vertical resize -2<CR>", "", opts = opts },
    ["<right>"] = { ":vertical resize +2<CR>", "", opts = opts },
  },
}

M.closePreview = {
  n = {
    ["<CR>"] = { "<CR>:ccl<CR>", "", opts = opts },
    ["q"] = { "<ESC>:ccl<CR>q", "", opts = opts },
  },
}

M.yanky = {
  n = {
    ["p"] = { "<Plug>(YankyPutAfter)", "", opts = opts },
    ["P"] = { "<Plug>(YankyPutBefore)", "", opts = opts },
    ["gp"] = { "<Plug>(YankyGPutAfter)", "", opts = opts },
    ["gP"] = { "<Plug>(YankyGPutBefore)", "", opts = opts },
    ["<c-V>"] = { "<Plug>(YankyCycleForward)", "", opts = opts },
    ["<c-B>"] = { "<Plug>(YankyCycleBackward)", "", opts = opts },
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
    ["<leader><ESC><ESC>"] = {
      function()
        require("core.utils").close_buffer()
        require("core.utils").tabuflineNext()
        if vim.api.nvim_buf_get_name(0) == "" then
          pcall(vim.cmd, ":Alpha")
          pcall(vim.cmd, ":bd#")
        end
        require("core.utils").tabuflinePrev()
      end,
      "   close buffer",
      opts = opts,
    },
  },
}

-- M.mru = {
--   n = {
--     ["<C-t>"] = { "<cmd>Mru<CR>", "", opts = opts },
--   },
-- }

return M
