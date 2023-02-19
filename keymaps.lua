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
    ["<leader>ls"] = "",
  },
}

M.advanceSearch = {
  n = {
    ["*"] = { '"ayiwh/<c-r>a<CR>', "", opts = opts },
    ["<leader>fiw"] = { '"ayiw<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk', "", opts = opts },
    ["<leader>riw"] = { "/\\<<c-r><c-w>\\><CR>:%s@\\<<c-r><c-w>\\>@<c-r><c-w>@gc<left><left><left>", "", opts = opts },
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>', "", opts = opts },
    ["<leader>fiw"] = { '"ay<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk', "", opts = opts },
    ["<leader>riw"] = { '"aygvv:%sno@<c-r>a@<c-r>a@g<left><left>', "", opts = opts },
  },
}

M.term_toggle = {
  n = {
    ["<leader>gg"] = { "<cmd>Lspsaga term_toggle lazygit<CR>", "", opts = opts },
    ["<c-T>"] = { "<cmd>Lspsaga term_toggle<CR>", "", opts = opts },
  },
  t = {
    ["<c-T>"] = { "<cmd>Lspsaga term_toggle<CR>", "", opts = opts },
  },
}

M.gitSigns = {
  n = {
    ["H"] = { "<cmd>Gitsigns prev_hunk<CR>", "", opts = opts },
    ["L"] = { "<cmd>Gitsigns next_hunk<CR>", "", opts = opts },
    ["<leader>pp"] = { "<cmd>Gitsigns preview_hunk<CR>", "Git Actions", opts = opts },
    ["<c-u>"] = { ":Gitsigns undo_stage_hunk<CR>", "", opts = opts },
    ["<c-s>"] = { ":Gitsigns stage_hunk<CR>", "", opts = opts },
  },
  v = {
    ["<c-s>"] = { ":Gitsigns stage_hunk<CR>", "", opts = opts },
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
    ["}"] = { "<C-d>zz", "", opts = {} },
    ["{"] = { "<C-u>zz", "", opts = {} },
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
    ["<leader>o"] = {
      "<cmd> Telescope lsp_document_symbols <CR>",
      opts = { silent = true },
    },
    ["<leader>wo"] = {
      "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>",
      opts = { silent = true },
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

-- M.plusMinus = {
--   n = {
--     ["+"] = {
--       "<c-a>",
--       "Plus",
--       opts = opts,
--     },
--     ["-"] = {
--       "<c-x>",
--       "Minus",
--       opts = opts,
--     },
--   },
--   v = {
--     ["+"] = {
--       "<c-a>gv",
--       "Plus",
--       opts = opts,
--     },
--     ["-"] = {
--       "<c-x>gv",
--       "Minus",
--       opts = opts,
--     },
--   },
-- }

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
  i = {
    ["<c-i>"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "lsp signature_help",
    },
  },
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
  n = {
    -- toggle
    ["<C-`>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.snippets = {
  n = {
    ["clg"] = {
      '"ayiwoconsole.log({ <c-r>a })<left><left><left>',
    },
  },
}

return M
