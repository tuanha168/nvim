---@type LazySpec
return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod" },
      { "pbogut/vim-dadbod-ssh" },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        init = function()
          local ok, cmp = pcall(require, "cmp")
          if not ok then return end

          local autocmd = vim.api.nvim_create_autocmd

          autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function() cmp.setup.buffer { sources = { { name = "vim-dadbod-completion" } } } end,
          })
        end,
      },
    },
    keys = {
      {
        "<leader>cdb",
        function()
          -- if not vim.g.db_ui_ssh_connection then
          --   -- ssh -L 7000:localhost:3306 -N yopaz-dev
          --   local _, pid = vim.uv.spawn("ssh", { args = { "-L", "7000:localhost:3306", "-N", "test-ec2" } })
          --   vim.g.db_ui_ssh_connection = pid
          -- end
          vim.cmd.DBUIToggle()
          vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.ToggleWindow, modeline = false })
        end,
        desc = "DBUIToggle",
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1

      vim.api.nvim_create_autocmd("VimLeavePre", {
        pattern = "*",
        callback = function()
          if vim.g.db_ui_ssh_connection then vim.uv.kill(vim.g.db_ui_ssh_connection) end
        end,
      })
    end,
  },
  -- {
  --   "MattiasMTS/cmp-dbee",
  --   cmd = { "Dbee" },
  --   dependencies = {
  --     {
  --       "kndndrj/nvim-dbee",
  --       dependencies = {
  --         "MunifTanjim/nui.nvim",
  --       },
  --       build = function()
  --         -- Install tries to automatically detect the install method.
  --         -- if it fails, try calling it with one of these parameters:
  --         --    "curl", "wget", "bitsadmin", "go"
  --         require("dbee").install()
  --       end,
  --       config = function()
  --         require("dbee").setup(--[[optional config]])
  --       end,
  --     },
  --   },
  --   opts = {}, -- needed
  --   init = function()
  --     local ok, cmp = pcall(require, "cmp")
  --     if not ok then return end

  --     local autocmd = vim.api.nvim_create_autocmd

  --     autocmd("FileType", {
  --       pattern = { "sql", "mysql", "plsql" },
  --       callback = function() cmp.setup.buffer { sources = { { name = "cmp-dbee" } } } end,
  --     })
  --     vim.api.nvim_create_autocmd("VimLeavePre", {
  --       pattern = "*",
  --       callback = function()
  --         if vim.g.db_ui_ssh_connection then vim.uv.kill(vim.g.db_ui_ssh_connection) end
  --       end,
  --     })
  --   end,
  --   keys = {
  --     {
  --       "<leader>cdb",
  --       function()
  --         if not vim.g.db_ui_ssh_connection then
  --           -- ssh -L 7000:localhost:3306 -N yopaz-dev
  --           local _, pid = vim.uv.spawn("ssh", { args = { "-L", "3306:localhost:3306", "-N", "test-ec2" } })
  --           vim.g.db_ui_ssh_connection = pid
  --         end
  --         vim.cmd.Dbee()
  --       end,
  --       desc = "Dbee",
  --     },
  --   },
  -- },
}
