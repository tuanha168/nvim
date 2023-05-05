local mappings = {
  n = {
    ["<leader>l"] = false,
    ["<leader>fm"] = false,
    ["<leader>ls"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["<leader>fc"] = false,
    ["|"] = false,
    -- ["<C-b>"] = {
    --   function() require("smart-splits").start_resize_mode() end,
    --   noremap = true,
    --   desc = "Start Resize Mode",
    -- },
    -- ["<C-h>"] = { "<cmd>KittyNavigateLeft<CR>", desc = "Move to left split" },
    -- ["<C-j>"] = { "<cmd>KittyNavigateDown<CR>", desc = "Move to below split" },
    -- ["<C-k>"] = { "<cmd>KittyNavigateUp<CR>", desc = "Move to above split" },
    -- ["<C-l>"] = { "<cmd>KittyNavigateRight<CR>", desc = "Move to right split" },
    -- ["<C-S-R>"] = {
    --   function() require("smart-splits").start_resize_mode() end,
    --   noremap = true,
    --   desc = "Start Resize Mode",
    -- },
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
      function() require("user.utils").operatorfunc_lua "live_grep_motion" end,
      desc = "Live grep motion",
      noremap = true,
    },
    ["<leader>r"] = {
      function() require("user.utils").operatorfunc_lua "replace_motion" end,
    },
    ["<leader>fa"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find all files",
    },
    ["<leader>fF"] = {
      function()
        local utils = require "user.utils"
        local cwd = vim.fn.stdpath "config" .. "/.."
        local search_dirs = {}
        for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
          if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
          if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
        end
        if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
          utils.print "No user configuration files found"
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
    ["H"] = { "^" },
    ["L"] = { "$" },
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
    ["n"] = { "nzzzv" },
    ["<S-n>"] = { "Nzzzv" },
    ["}"] = { "<C-d>zz" },
    ["{"] = { "<C-u>zz" },
    -- Close Preview
    ["<CR>"] = { "<CR>zz:ccl<CR>", silent = true },
    ["q"] = { "<ESC>:ccl<CR>q", silent = true },
    -- Yank
    ["<c-c>"] = { '"+yiw', desc = "Yank", noremap = true },
    -- Yanky
    ["p"] = { "<cmd>Telescope yank_history<CR>jk" },
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
    ["<C-n>i"] = { "<C-i>" },
    ["<S-Up>"] = { "<Plug>(expand_region_expand)", noremap = false, silent = true },
    ["<S-Down>"] = { "<Plug>(expand_region_shrink)", noremap = false, silent = true },
    ["dd"] = {
      function()
        if vim.api.nvim_get_current_line():match "^%s*$" then
          return vim.cmd 'normal! "_dd'
        else
          return vim.cmd "normal! dd"
        end
      end,
    },
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>' },
    ["<leader>fs"] = { '"ay<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk' },
    -- ["<leader>r"] = { '"aygvv:%sno@<c-r>a@<c-r>a@g<left><left>' },
    ["<leader>r"] = {
      function() require("user.utils").operatorfunc_lua "replace_motion" end,
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
    ["H"] = { "^" },
    ["L"] = { "$" },
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
  },
}

for key, value in pairs(custom_text_objects) do
  mappings.x[key] = value
  mappings.o[key] = value
end

return mappings
