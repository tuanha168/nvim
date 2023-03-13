return {
  n = {
    ["<leader>l"] = false,
    ["<leader>fm"] = false,
    ["<leader>ls"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["<leader>fc"] = false,
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
        if replaceWord == nil then return end

        vim.cmd(string.format("%%s@%s@%s@gc", cword, replaceWord))
      end,
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
    ["gd"] = { "gdzz" },
    -- Close Preview
    ["<CR>"] = { "<CR>zz:ccl<CR>" },
    ["q"] = { "<ESC>:ccl<CR>q" },
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
  },
  v = {
    ["*"] = { '"ayh/<c-r>a<CR>' },
    ["<leader>fiw"] = { '"ay<cmd> Telescope live_grep <CR>a<c-r>a<esc>jk' },
    ["<leader>riw"] = { '"aygvv:%sno@<c-r>a@<c-r>a@g<left><left>' },
    -- Gitsigns
    ["<c-u>"] = { ":Gitsigns undo_stage_hunk<CR>" },
    ["<c-s>"] = { ":Gitsigns stage_hunk<CR>" },
    ["u"] = { ":Gitsigns reset_hunk<CR>" },
    -- Moving
    ["K"] = { ":m '<-2<CR>gv=gv" },
    ["J"] = { ":m '>+1<CR>gv=gv" },
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
