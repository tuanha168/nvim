local mappings = {
  n = {
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" },
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" },
    ["<S-Up>"] = {''},
    ["<S-Down>"] = {''},
    ["*"] = { '"ayiwh/<c-r>a<CR>' },
    ["<leader>fs"] = {
      function() Chiruno.operatorfunc_lua "live_grep_motion" end,
      desc = "Live grep motion",
      noremap = true,
    }, ["<leader>r"] = {
      function() Chiruno.operatorfunc_lua "replace_motion" end,
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
      function()
        -- require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
      end,
      desc = "Next buffer",
    },
    ["<S-Tab>"] = {
      function()
        -- require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
      end,
      desc = "Previous buffer",
    },
    -- Keep center
    ["}"] = { "<C-d>zz" },
    ["{"] = { "<C-u>zz" },
    -- Close Preview
    ["<CR>"] = { "<CR>zz", silent = true },
    ["q"] = { "<ESC>:ccl<CR>q", silent = true },
    -- Yank
    ["<c-c>"] = { '"+yiw', desc = "Yank", noremap = true },
    -- Telescope
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
    ["<leader>O"] = { function() require("aerial").toggle() end, desc = "Symbols outline" },

    -- Disable Yank
    ["c"] = {
      '"_c',
    },
    ["C"] = {
      '"_C',
    },
    -- Neotree
    ["<c-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    -- Illuminate
    ["("] = {
      function() require("illuminate").goto_next_reference() end,
    },
    [")"] = {
      function() require("illuminate").goto_prev_reference() end,
    },
    ["<leader>qq"] = { function()
      pcall(MiniBufremove.delete)
    end, desc = "Close buffer", silent = true },
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
    ["<leader>fd"] = { function() Chiruno.run_make() end, desc = "Run make", noremap = true },
    ["<leader>gc"] = { function() require("telescope.builtin").git_commits() end, desc = "Git commits" },
    ["<leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" },
    ["<leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" },
    ["<leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
    ["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" },
    ["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" },
    ["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
        }
      end,
      desc = "Find words in all files",
    },
    ["<leader>gg"] = {
      function()
        local worktree = Chiruno.file_worktree()
        local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
        Chiruno.toggle_terminal("lazygit " .. flags)
      end,
      desc = "ToggleTerm lazygit",
    },
    ["]c"] = { "<cmd>cn<CR>", desc = "Next error", noremap = true },
    ["[c"] = { "<cmd>cp<CR>", desc = "Previous error", noremap = true },
    ["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
    ["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" },
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>' },
    ["<leader>fs"] = {
      function() Chiruno.operatorfunc_lua "live_grep_motion" end,
      desc = "Live grep motion",
      noremap = true,
    },
    ["<leader>r"] = {
      function() Chiruno.operatorfunc_lua "replace_motion" end,
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
    -- Visual Indent
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
    ["<S-Tab>"] = { "<gv", desc = "Unindent line" },
    ["<Tab>"] = { ">gv", desc = "Indent line" },
    ["p"] = { '"_dP' },
    ["="] = { "=gv" },
    -- Disable Yank
    ["c"] = {
      '"_c',
    },
    ["C"] = {
      '"_C',
    },
  },
  x = {},
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

Chiruno.set_mappings(mappings)
