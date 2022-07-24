-- lua/custom/mappings
local M = {}

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
    ["<leader>`"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },
  },
  t = {
    ["<leader>`"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },
  },
}

M.windowMove = {
  n = {
    ["<C-h>"] = { "<C-w>h", "" },
    ["<C-j>"] = { "<C-w>j", "" },
    ["<C-k>"] = { "<C-w>k", "" },
    ["<C-l>"] = { "<C-w>l", "" },
  },
}

M.advanceSearch = {
  n = {
    ["*"] = { '"ayiwh/<c-r>a<CR>', "" },
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>', "" },
  },
}

M.neoGit = {
  n = {
    ["<leader>gg"] = { ":Neogit<cr>", "" },
    ["<leader>gd"] = { ":DiffviewOpen<cr>", "" },
    ["<leader>gD"] = { ":DiffviewOpen main<cr>", "" },
    ["<leader>gl"] = { ":Neogit log<cr>", "" },
    ["<leader>gp"] = { ":Neogit push<cr>", "" },
  },
}

M.gitSigns = {
  n = {
    ["[c"] = { "<cmd>Gitsigns prev_hunk<CR>", "" },
    ["]c"] = { "<cmd>Gitsigns next_hunk<CR>", "" },
    ["<leader>pp"] = { "<cmd>Gitsigns preview_hunk<CR>", "Git Actions" },
  },
  v = {
    ["u"] = { ":Gitsigns reset_hunk<CR>", "" },
  },
}

M.moving = {
  n = {
    ["K"] = { ":m .-2<CR>==", "" },
    ["J"] = { ":m .+1<CR>==", "" },
  },
  v = {
    ["K"] = { ":m '<-2<CR>gv=gv", "" },
    ["J"] = { ":m '>+1<CR>gv=gv", "" },
  },
}

M.visualIndent = {
  v = {
    ["<"] = { "<gv", "" },
    [">"] = { ">gv", "" },
    ["p"] = { '"_dP', "" },
  },
}

M.keepCenter = {
  n = {
    ["n"] = { "nzzzv", "" },
    ["<S-n>"] = { "Nzzzv", "" },
    ["j"] = { "jzz", "" },
    ["k"] = { "kzz", "" },
    ["L"] = { "Lzz", "" },
    ["H"] = { "Hzz", "" },
  },
}

M.splitAndResize = {
  n = {
    ["<C-down>"] = { ":split<CR>", "" },
    ["<C-right>"] = { ":vsplit<CR>", "" },
    ["<up>"] = { ":resize +2<CR>", "" },
    ["<down>"] = { ":resize -2<CR>", "" },
    ["<left>"] = { ":vertical resize -2<CR>", "" },
    ["<right>"] = { ":vertical resize +2<CR>", "" },
  },
}

M.closePreview = {
  n = {
    ["<CR>"] = { "<CR>:ccl<CR>" },
  },
}

M.yanky = {
  n = {
    ["p"] = { "<Plug>(YankyPutAfter)", "" },
    ["P"] = { "<Plug>(YankyPutBefore)", "" },
    ["gp"] = { "<Plug>(YankyGPutAfter)", "" },
    ["gP"] = { "<Plug>(YankyGPutBefore)", "" },
    ["<a-n>"] = { "<Plug>(YankyCycleForward)", "" },
    ["<a-p>"] = { "<Plug>(YankyCycleBackward)", "" },
  },

  x = {
    ["p"] = { "<Plug>(YankyPutAfter)", "" },
    ["P"] = { "<Plug>(YankyPutBefore)", "" },
    ["gp"] = { "<Plug>(YankyGPutAfter)", "" },
    ["gP"] = { "<Plug>(YankyGPutBefore)", "" },
  },
}

M.projects = {
  n = {
    ["``"] = {
      ":lua require'telescope'.extensions.project.project{}<CR>",
      "",
    },
  },
}

M.closeTab = {
  n = {
    ["<leader><ESC><ESC>"] = {
      function()
        require("core.utils").close_buffer()
        if vim.api.nvim_buf_get_name(0) == "" then
          pcall(vim.cmd, ":Alpha")
          pcall(vim.cmd, ":bd#")
        end
      end,
      "   close buffer",
    },
  },
}

M.mru = {
  n = {
    ["<C-t>"] = { "<cmd>Mru<CR>", "" },
  },
}

return M
