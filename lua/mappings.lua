local mappings = {
  -- ["*"] = { '"ayiwh/<c-r>a<CR>' },
  { "<Leader>r", function() Chiruno.func.operatorfunc_lua "replace_motion" end },
  -- Gitsigns
  {"[g", function() require("gitsigns").nav_hunk('prev') end, description = "Previous Git hunk" },
  {"]g", function() require("gitsigns").nav_hunk('next') end, description = "Next Git hunk" },
  -- ["H"] = { "^" },
  -- ["L"] = { "$" },
  { "<Leader>pp", "<cmd>Gitsigns preview_hunk<CR>" },

  -- Move cursor wrapped line
  { "k", "gk", opts = { silent = true } },
  { "j", "gj", opts = { silent = true } },

  -- Moving
  { "K", ":m .-2<CR>==", opts = { silent = true } },
  { "J", ":m .+1<CR>==", opts = { silent = true } },
  { "}", "<C-d>zz" },
  { "{", "<C-u>zz" },
  -- Close Preview
  { "<CR>", "<CR>zz", opts = { silent = true } },
  -- ["q"] = { "<ESC>:ccl<CR>q", silent = true },
  -- Yank
  { "<c-c>", '"+yiw', description = "Yank", opts = { noremap = true } },
  { "<Leader>y", '"+y', description = "Yank system clipboard", opts = { noremap = true } },
  { "<Leader>Y", '"+y$', description = "Yank system clipboard", opts = { noremap = true } },
  { "<Leader>p", '"+p', description = "Paste system clipboard", opts = { noremap = true } },
  { "<Leader>P", '"+P', description = "Paste system clipboard", opts = { noremap = true } },
  {
    "<Leader>O",
    function()
      local ok, aerial = pcall(require, "aerial")
      if not ok then return end

      aerial.toggle()
    end,
    description = "Symbols outline",
  },

  -- Disable Yank
  { "c", '"_c' },
  { "C", '"_C' },
  -- Illuminate
  { "(", function() require("illuminate").goto_next_reference() end },
  { ")", function() require("illuminate").goto_prev_reference() end },
  { "+", "<C-a>", opts = { noremap = true } },
  { "-", "<C-x>", opts = { noremap = true } },
  { "<C-z>i", "<C-i>" },
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
  { "<Leader>fd", function() Chiruno.func.run_make() end, description = "Run make", opts = { noremap = true } },
  { "]c", "<cmd>cn<CR>", description = "Next error", opts = { noremap = true } },
  { "[c", "<cmd>cp<CR>", description = "Previous error", opts = { noremap = true } },
  -- {
  --   "<Leader>du",
  --   function()
  --     local ok, dapui = pcall(require, "dapui")
  --     if not ok then return end

  --     dapui.toggle()
  --   end,
  --   description = "Toggle Debugger UI",
  -- },

  -- ["*"] = { function() Chiruno.func.operatorfunc_lua "search" end },
  { "<Leader>r", function() Chiruno.func.operatorfunc_lua "replace_motion" end, mode = { "v" } },
  -- Yank
  { "<c-c>", '"+y', description = "Yank", opts = { noremap = true }, mode = { "v" } },
  -- Gitsigns
  { "<c-u>", ":Gitsigns undo_stage_hunk<CR>", silent = true },
  { "<c-s>", ":Gitsigns stage_hunk<CR>", silent = true, mode = { "v" } },
  { "u", ":Gitsigns reset_hunk<CR>", silent = true, mode = { "v" } },
  -- Moving
  { "K", ":m '<-2<CR><CR>gv=gv", silent = true, mode = { "v" } },
  { "J", ":m '>+1<CR><CR>gv=gv", silent = true, mode = { "v" } },
  { "<", "<gv", mode = { "v" } },
  { ">", ">gv", mode = { "v" } },
  { "=", "=gv", mode = { "v" } },

  -- Disable Yank
  { "c", '"_c', mode = { "v" } },
  { "C", '"_C', mode = { "v" } },
  { "+", "<C-a>", opts = { noremap = true }, mode = { "v" } },
  { "-", "<C-x>", opts = { noremap = true }, mode = { "v" } },
  { "g+", "g<C-a>", opts = { noremap = true }, mode = { "v" } },
  { "g-", "g<C-x>", opts = { noremap = true }, mode = { "v" } },

  { "<M-BS>", "<C-w>", opts = { noremap = true }, mode = { "i" } },

  -- swap p
  { "p", "P", mode = { "x" } },
  { "P", "p", mode = { "x" } },

  { "gG", ":<c-u>normal! ggVG<cr>", description = "Buffer as text object", mode = { "x", "o" } },

  { "<Tab>", "<cmd>bn<CR>", description = "Move to next buffer" },
  { "<S-Tab>", "<cmd>bp<CR>", description = "Move to previous buffer" },

  { "<ESC>", "<cmd>noh<CR>", description = "No Highlight" },
}

return mappings
