---@type LazySpec

local db_ui_ssh_connection

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
          if not db_ui_ssh_connection then
            -- ssh -L 7000:localhost:3306 -N yopaz-dev
            local obj = vim.system({ "ssh", "-L", "7000:localhost:3306", "-N", "test-ec2" }, { text = true })
            db_ui_ssh_connection = obj
          end
          vim.cmd.DBUIToggle()
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
          if db_ui_ssh_connection then db_ui_ssh_connection:kill(9) end
        end,
      })
    end,
  },
}
