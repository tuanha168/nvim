return {
  n = {
    ["<leader>l"] = false,
    ["<leader>fm"] = false,
    ["<leader>ls"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["<leader>fc"] = false,
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
    ["<leader>fiw"] = {
      function() require("telescope.builtin").grep_string() end,
      desc = "Find for word under cursor",
    },
    ["<leader>riw"] = {
      function()
        local cword = vim.fn.expand "<cword>" -- select word under cursor.
        if cword == "" then return end

        local replaceWord = vim.fn.input("Enter replacement: ", cword)
        if replaceWord == "" or replaceWord == cword then return end

        vim.cmd(string.format("%%s@%s@%s@gc", cword, replaceWord))
      end,
    },
    ["<leader>fa"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find all files",
    },
    ["<leader>fF"] = {
      function()
        local utils = require "astronvim.utils"
        local cwd = vim.fn.stdpath "config" .. "/.."
        local search_dirs = {}
        for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
          if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
          if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
        end
        if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
          utils.notify("No user configuration files found", "warn")
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
    ["H"] = { "<cmd>Gitsigns prev_hunk<CR>" },
    ["L"] = { "<cmd>Gitsigns next_hunk<CR>" },
    ["<leader>pp"] = { "<cmd>Gitsigns preview_hunk<CR>" },
    ["<c-u>"] = { ":Gitsigns undo_stage_hunk<CR>" },
    ["<c-s>"] = { ":Gitsigns stage_hunk<CR>" },
    -- Moving
    ["K"] = { ":m .-2<CR>==" },
    ["J"] = { ":m .+1<CR>==" },
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
    ["<CR>"] = { "<CR>zz:ccl<CR>" },
    ["q"] = { "<ESC>:ccl<CR>q" },
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
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>' },
    ["<leader>fiw"] = { '"ay<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk' },
    ["<leader>riw"] = { '"aygvv:%sno@<c-r>a@<c-r>a@g<left><left>' },
    -- Yank
    ["<c-c>"] = { '"+y', desc = "Yank", noremap = true },
    -- Gitsigns
    ["<c-u>"] = { ":Gitsigns undo_stage_hunk<CR>" },
    ["<c-s>"] = { ":Gitsigns stage_hunk<CR>" },
    ["u"] = { ":Gitsigns reset_hunk<CR>" },
    -- Moving
    ["K"] = { ":m '<-2<CR><CR>gv=gv" },
    ["J"] = { ":m '>+1<CR><CR>gv=gv" },
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
    -- Lsp related
    ["<leader>fm"] = {
      function() vim.lsp.buf.format { async = true } end,
    },
  },
  i = {
    ["<c-u>"] = {
      function() vim.lsp.buf.signature_help() end,
    },
  },
}
