local mappings = {
  -- ["*"] = { '"ayiwh/<c-r>a<CR>' },
  { "<Leader>r", function() Chiruno.func.operatorfunc_lua "replace_motion" end },
  -- Gitsigns
  -- ["H"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
  -- ["L"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
  -- ["H"] = { "^" },
  -- ["L"] = { "$" },
  { "<Leader>pp", "<cmd>Gitsigns preview_hunk<CR>" },
  -- Moving
  { "K", ":m .-2<CR>==", silent = true },
  { "J", ":m .+1<CR>==", silent = true },
  { "}", "<C-d>zz" },
  { "{", "<C-u>zz" },
  -- Close Preview
  { "<CR>", "<CR>zz", silent = true },
  -- ["q"] = { "<ESC>:ccl<CR>q", silent = true },
  -- Yank
  { "<c-c>", '"+yiw', desc = "Yank", noremap = true },
  { "<Leader>y", '"+y', desc = "Yank system clipboard", noremap = true },
  { "<Leader>Y", '"+y$', desc = "Yank system clipboard", noremap = true },
  { "<Leader>p", '"+p', desc = "Paste system clipboard", noremap = true },
  { "<Leader>P", '"+P', desc = "Paste system clipboard", noremap = true },
  {
    "<Leader>O",
    function()
      local ok, aerial = pcall(require, "aerial")
      if not ok then return end

      aerial.toggle()
    end,
    desc = "Symbols outline",
  },

  -- Disable Yank
  { "c", '"_c' },
  { "C", '"_C' },
  -- Illuminate
  { "(", function() require("illuminate").goto_next_reference() end },
  { ")", function() require("illuminate").goto_prev_reference() end },
  { "+", "<C-a>", noremap = true },
  { "-", "<C-x>", noremap = true },
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
  { "<Leader>fd", function() Chiruno.func.run_make() end, desc = "Run make", noremap = true },
  { "]c", "<cmd>cn<CR>", desc = "Next error", noremap = true },
  { "[c", "<cmd>cp<CR>", desc = "Previous error", noremap = true },
  {
    "<Leader>du",
    function()
      local ok, dapui = pcall(require, "dapui")
      if not ok then return end

      dapui.toggle()
    end,
    desc = "Toggle Debugger UI",
  },

  -- ["*"] = { function() Chiruno.func.operatorfunc_lua "search" end },
  { "<Leader>r", function() Chiruno.func.operatorfunc_lua "replace_motion" end, mode = { "v" } },
  -- Yank
  { "<c-c>", '"+y', desc = "Yank", noremap = true, mode = { "v" } },
  -- Gitsigns
  { "<c-u>", ":Gitsigns undo_stage_hunk<CR>", silent = true, mode = { "v" } },
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
  { "+", "<C-a>", noremap = true, mode = { "v" } },
  { "-", "<C-x>", noremap = true, mode = { "v" } },
  { "g+", "g<C-a>", noremap = true, mode = { "v" } },
  { "g-", "g<C-x>", noremap = true, mode = { "v" } },

  { "<M-BS>", "<C-w>", noremap = true, mode = { "i" } },

  -- swap p
  { "p", "P", mode = { "x" } },
  { "P", "p", mode = { "x" } },

  { "gG", ":<c-u>normal! ggVG<cr>", desc = "Buffer as text object", mode = { "x", "o" } },
}

return mappings
