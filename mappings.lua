local mappings = {
  n = {
    ["<leader>w"] = false,
    ["<leader>l"] = false,
    ["<leader>fm"] = false,
    ["<leader>ls"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["<leader>fc"] = false,
    ["<leader>gL"] = false,
    ["<leader>h"] = false,
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
    ["<leader>fs"] = {
      function() Chiruno.func.operatorfunc_lua "live_grep_motion" end,
      desc = "Live grep motion",
      noremap = true,
    },
    ["<leader>r"] = {
      function() Chiruno.func.operatorfunc_lua "replace_motion" end,
    },
    ["<leader>fa"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find all files",
    },
    ["<leader>ff"] = {
      function()
        local check, telescope = pcall(require, "telescope.builtin")
        if not check then return end
        pcall(telescope.find_files)
      end,
      desc = "Find files",
    },
    ["<leader>fg"] = {
      function()
        local check, telescope = pcall(require, "telescope.builtin")
        if not check then return end
        pcall(telescope.git_files)
      end,
      desc = "Find AstroNvim config files",
    },
    -- Gitsigns
    -- ["H"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
    -- ["L"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
    -- ["H"] = { "^" },
    -- ["L"] = { "$" },
    ["<leader>pp"] = { "<cmd>Gitsigns preview_hunk<CR>" },
    -- Moving
    ["K"] = { ":m .-2<CR>==", silent = true },
    ["J"] = { ":m .+1<CR>==", silent = true },
    ["<Tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-Tab>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
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
    ["<leader>y"] = { '"+y', desc = "Yank system clipboard", noremap = true },
    ["<leader>Y"] = { '"+y$', desc = "Yank system clipboard", noremap = true },
    ["<leader>p"] = { '"+p', desc = "Paste system clipboard", noremap = true },
    ["<leader>P"] = { '"+P', desc = "Paste system clipboard", noremap = true },
    -- Telescope
    -- ["``"] = {
    --   "<cmd> Telescope project <CR>",
    -- },
    ["<leader>o"] = {
      function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
          require("telescope").extensions.aerial.aerial()
        else
          require("telescope.builtin").lsp_document_symbols()
        end
      end,
      desc = "Search symbols",
    },
    ["<leader>O"] = {
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
    ["D"] = {
      '"_D',
    },
    -- Neotree
    ["<leader>e"] = false,
    -- Illuminate
    ["("] = {
      function() require("illuminate").goto_next_reference() end,
    },
    [")"] = {
      function() require("illuminate").goto_prev_reference() end,
    },
    ["<leader>c"] = false,
    ["<leader>q"] = false,
    ["<leader>qq"] = {
      function()
        require("astronvim.utils.buffer").close()
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
    ["<leader>fd"] = { function() Chiruno.func.run_make() end, desc = "Run make", noremap = true },
    ["]c"] = { "<cmd>cn<CR>", desc = "Next error", noremap = true },
    ["[c"] = { "<cmd>cp<CR>", desc = "Previous error", noremap = true },
    ["<leader>z"] = {
      function() Chiruno.func.toggle_null_window() end,
      desc = "Toggle Null Window",
      noremap = true,
    },
    ["<leader>du"] = {
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
    ["<leader>fs"] = {
      function() Chiruno.func.operatorfunc_lua "live_grep_motion" end,
      desc = "Live grep motion",
      noremap = true,
    },
    ["<leader>r"] = {
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

    -- ["<leader>y"] = { '"+y', desc = "Yank system clipboard", noremap = true },
    -- ["<leader>Y"] = { '"+Y', desc = "Yank system clipboard", noremap = true },
    -- ["<leader>p"] = { '"+p', desc = "Paste system clipboard", noremap = true },
    -- ["<leader>P"] = { '"+P', desc = "Paste system clipboard", noremap = true },
    -- Disable Yank
    ["c"] = {
      '"_c',
    },
    ["C"] = {
      '"_C',
    },
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
