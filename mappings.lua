local mappings = {
  n = {
    ["<leader>l"] = false,
    ["<leader>fm"] = false,
    ["<leader>ls"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["<leader>fc"] = false,
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
      function() Chiruno.operatorfunc_lua "live_grep_motion" end,
      desc = "Live grep motion",
      noremap = true,
    },
    ["<leader>r"] = {
      function() Chiruno.operatorfunc_lua "replace_motion" end,
    },
    ["<leader>fa"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find all files",
    },
    ["<leader>fF"] = {
      function()
        local cwd = vim.fn.stdpath "config" .. "/.."
        local search_dirs = {}
        for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
          if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
          if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
        end
        if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
          Chiruno.print "No user configuration files found"
        else
          if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
          require("telescope.builtin").find_files {
            prompt_title = "Config Files",
            search_dirs = search_dirs,
            cwd = cwd,
          } -- call telescope
        end
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
    ["q"] = { "<ESC>:ccl<CR>q", silent = true },
    -- Yank
    ["<c-c>"] = { '"+yiw', desc = "Yank", noremap = true },
    -- Telescope
    ["``"] = {
      "<cmd> Telescope project <CR>",
    },
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
    -- Close Tabs
    -- ["<leader>qq"] = {
    --   function()
    --     require("nvchad_ui.tabufline").close_buffer()
    --     if vim.api.nvim_buf_get_name(0) == "" then
    --       require("nvchad_ui.tabufline").tabuflinePrev()
    --       if vim.api.nvim_buf_get_name(0) == "" then
    --         pcall(vim.cmd, ":Alpha")
    --         pcall(vim.cmd, ":bd#")
    --       end
    --     end
    --   end,
    --   "   close buffer",
    --   opts = opts,
    -- },

    -- Disable Yank
    ["c"] = {
      '"_c',
    },
    ["C"] = {
      '"_C',
    },
    -- Neotree
    ["<leader>e"] = false,
    ["<c-n>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    -- Illuminate
    ["("] = {
      function() require("illuminate").goto_next_reference() end,
    },
    [")"] = {
      function() require("illuminate").goto_prev_reference() end,
    },
    ["<leader>c"] = false,
    ["<leader>q"] = false,
    ["<leader>qq"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" },
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
    ["]c"] = { "<cmd>cn<CR>", desc = "Next error", noremap = true },
    ["[c"] = { "<cmd>cp<CR>", desc = "Previous error", noremap = true },
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
    -- ["H"] = { "^" },
    -- ["L"] = { "$" },
    -- Visual Indent
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
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

-- Expand Region
local expand = { "<Plug>(expand_region_expand)", noremap = true, silent = true }
local shrink = { "<Plug>(expand_region_shrink)", noremap = true, silent = true }

mappings.n["<S-Up>"] = expand
mappings.v["<S-Up>"] = expand
mappings.x["<S-Up>"] = expand
mappings.n["<S-Down>"] = shrink
mappings.v["<S-Down>"] = shrink
mappings.x["<S-Down>"] = shrink

return mappings
