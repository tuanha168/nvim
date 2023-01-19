-- lua/custom/mappings
-- Mappings for Neovim
local M = {}
local opts = { silent = true, noremap = true }

-- add this table only when you want to disable default keys
M.disabled = {
  n = {
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<C-s>"] = "",
    ["<leader>x"] = "",
    ["<leader>wK"] = "",
    ["<leader>wk"] = "",
    ["<leader>tt"] = "",
  },
}

M.advanceSearch = {
  n = {
    ["*"] = { '"ayiwh/<c-r>a<CR>', "", opts = opts },
    ["<leader>fiw"] = { '"ayiw<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk', "", opts = opts },
    ["<leader>riw"] = { '/\\<<c-r><c-w>\\><CR>:%s@\\<<c-r><c-w>\\>@<c-r><c-w>@gc<left><left><left>', "", opts = opts },
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>', "", opts = opts },
    ["<leader>fiw"] = { '"ay<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk', "", opts = opts },
    ["<leader>riw"] = { '"aygvv:%sno@<c-r>a@<c-r>a@g<left><left>', "", opts = opts },
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
    ["="] = { "=gv", "", opts = opts },
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
    ["}"] = { "<C-d>zz", "", opts = opts },
    ["{"] = { "<C-u>zz", "", opts = opts },
    ["gd"] = { "gdzz", "", opts = opts },
    -- ["gh"] = { "^", "", opts = opts },
    -- ["gl"] = { "$", "", opts = opts },
  },
  -- v = {
  --   ["gh"] = { "^", "", opts = opts },
  --   ["gl"] = { "$", "", opts = opts },
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
    ["p"] = { "<cmd>Telescope yank_history<CR>jk", "", opts = opts },
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

M.plusMinus = {
  n = {
    ["+"] = {
      "<c-a>",
      "Plus",
      opts = opts,
    },
    ["-"] = {
      "<c-x>",
      "Minus",
      opts = opts,
    },
  },
  v = {
    ["+"] = {
      "<c-a>gv",
      "Plus",
      opts = opts,
    },
    ["-"] = {
      "<c-x>gv",
      "Minus",
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
    ["C"] = {
      '"_C',
      "change no yank",
      opts = opts,
    },
  },
  v = {
    ["c"] = {
      '"_c',
      "change no yank",
      opts = opts,
    },
    ["C"] = {
      '"_C',
      "change no yank",
      opts = opts,
    },
  },
}

M.lspRelated = {
  v = {
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
  },
}

M.copy = {
  v = {
    ["<C-c>"] = {
      '"+y',
      "copy",
      opts = opts,
    },
  },
}

M.nvimtree = {
  plugin = true,
  n = {
    -- toggle
    ["<C-`>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

return M
