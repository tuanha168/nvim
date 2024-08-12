local mappings = {
  n = {
    ["<Leader>w"] = false,
    ["<Leader>l"] = false,
    ["<Leader>fm"] = false,
    ["<Leader>ls"] = false,
    ["<Leader>lD"] = false,
    ["<Leader>lS"] = false,
    ["<Leader>fc"] = false,
    ["<Leader>gl"] = false,
    ["<Leader>gL"] = false,
    ["<Leader>h"] = false,
    ["\\"] = false,
    ["|"] = false,
    ["<C-S-Up>"] = { function() require("smart-splits").resize_up() end, noremap = true, desc = "Resize split up" },
    ["<C-S-Down>"] = {
      function() require("smart-splits").resize_down() end,
      noremap = true,
      desc = "Resize split down",
    },
    ["<C-S-Left>"] = {
      function() require("smart-splits").resize_left() end,
      noremap = true,
      desc = "Resize split left",
    },
    ["<C-S-Right>"] = {
      function() require("smart-splits").resize_right() end,
      noremap = true,
      desc = "Resize split right",
    },
    ["*"] = { '"ayiwh/<c-r>a<CR>' },
    ["<Leader>r"] = {
      function() Chiruno.func.operatorfunc_lua "replace_motion" end,
    },
    -- Gitsigns
    -- ["H"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
    -- ["L"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
    -- ["H"] = { "^" },
    -- ["L"] = { "$" },
    ["<Leader>pp"] = { "<cmd>Gitsigns preview_hunk<CR>" },
    -- Moving
    ["K"] = { ":m .-2<CR>==", silent = true },
    ["J"] = { ":m .+1<CR>==", silent = true },
    ["<Tab>"] = {
      function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-Tab>"] = {
      function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- Keep center
    -- ["n"] = { "nzzzv" },
    -- ["<S-n>"] = { "Nzzzv" },
    ["}"] = { "<C-d>zz" },
    ["{"] = { "<C-u>zz" },
    -- Close Preview
    ["<CR>"] = { "<CR>zz", silent = true },
    -- ["q"] = { "<ESC>:ccl<CR>q", silent = true },
    -- Yank
    ["<c-c>"] = { '"+yiw', desc = "Yank", noremap = true },
    ["<Leader>y"] = { '"+y', desc = "Yank system clipboard", noremap = true },
    ["<Leader>Y"] = { '"+y$', desc = "Yank system clipboard", noremap = true },
    ["<Leader>p"] = { '"+p', desc = "Paste system clipboard", noremap = true },
    ["<Leader>P"] = { '"+P', desc = "Paste system clipboard", noremap = true },
    -- Telescope
    -- ["``"] = {
    --   "<cmd> Telescope project <CR>",
    -- },
    ["<Leader>O"] = {
      function()
        local ok, aerial = pcall(require, "aerial")
        if not ok then return end
        aerial.toggle()
        vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.ToggleWindow, modeline = false })
      end,
      desc = "Symbols outline",
    },

    -- Disable Yank
    ["c"] = {
      '"_c',
    },
    ["C"] = {
      '"_C',
    },
    -- Neotree
    ["<Leader>e"] = false,
    -- Illuminate
    ["("] = {
      function() require("illuminate").goto_next_reference() end,
    },
    [")"] = {
      function() require("illuminate").goto_prev_reference() end,
    },
    ["<Leader>c"] = false,
    ["<Leader>q"] = false,
    ["<Leader>qq"] = {
      function()
        require("astrocore.buffer").close()
        vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.ToggleWindow, modeline = false })
      end,
      desc = "Close buffer",
      silent = true,
    },
    ["+"] = { "<C-a>", noremap = true },
    ["-"] = { "<C-x>", noremap = true },
    ["<C-z>i"] = { "<C-i>" },
    ["dd"] = {
      function()
        if vim.api.nvim_get_current_line():match "^%s*$" then
          return vim.cmd 'normal! "_dd'
        else
          return vim.cmd "normal! dd"
        end
      end,
    },
    ["<Leader>fd"] = { function() Chiruno.func.run_make() end, desc = "Run make", noremap = true },
    ["]c"] = { "<cmd>cn<CR>", desc = "Next error", noremap = true },
    ["[c"] = { "<cmd>cp<CR>", desc = "Previous error", noremap = true },
    ["<Leader>z"] = {
      function() Chiruno.func.toggle_null_window() end,
      desc = "Toggle Null Window",
      noremap = true,
    },
    ["<Leader>du"] = {
      function()
        local ok, dapui = pcall(require, "dapui")
        if not ok then return end
        dapui.toggle()
        vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.ToggleWindow, modeline = false })
      end,
      desc = "Toggle Debugger UI",
    },
  },
  v = {
    ["*"] = { function() Chiruno.func.operatorfunc_lua "search" end },
    ["<Leader>r"] = {
      function() Chiruno.func.operatorfunc_lua "replace_motion" end,
    },
    -- Yank
    ["<c-c>"] = { '"+y', desc = "Yank", noremap = true },
    -- Gitsigns
    ["<c-u>"] = { ":Gitsigns undo_stage_hunk<CR>", silent = true },
    ["<c-s>"] = { ":Gitsigns stage_hunk<CR>", silent = true },
    ["u"] = { ":Gitsigns reset_hunk<CR>", silent = true },
    -- Moving
    ["K"] = { ":m '<-2<CR><CR>gv=gv", silent = true },
    ["J"] = { ":m '>+1<CR><CR>gv=gv", silent = true },
    -- ["H"] = { "^" },
    -- ["L"] = { "$" },
    -- Visual Indent
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
    ["="] = { "=gv" },

    -- ["<Leader>y"] = { '"+y', desc = "Yank system clipboard", noremap = true },
    -- ["<Leader>Y"] = { '"+Y', desc = "Yank system clipboard", noremap = true },
    -- ["<Leader>p"] = { '"+p', desc = "Paste system clipboard", noremap = true },
    -- ["<Leader>P"] = { '"+P', desc = "Paste system clipboard", noremap = true },
    -- Disable Yank
    ["c"] = {
      '"_c',
    },
    ["C"] = {
      '"_C',
    },
    ["+"] = { "<C-a>", noremap = true },
    ["-"] = { "<C-x>", noremap = true },
    ["g+"] = { "g<C-a>", noremap = true },
    ["g-"] = { "g<C-x>", noremap = true },
  },
  i = {
    ["<M-BS>"] = { "<C-w>", noremap = true },
  },
  x = {
    -- swap p
    ["p"] = { "P" },
    ["P"] = { "p" },
  },
  o = {},
}

-- Text Objects
local custom_text_objects = {
  ["gG"] = {
    ":<c-u>normal! ggVG<cr>",
    desc = "Buffer as text object",
  },
  -- ["iq"] = { function() Chiruno.quote_textobj "i" end, desc = "inner quote" },
  -- ["aq"] = { function() Chiruno.quote_textobj "a" end, desc = "outer quote" },
}

for key, value in pairs(custom_text_objects) do
  mappings.x[key] = value
  mappings.o[key] = value
end

return mappings
