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
          if not vim.g.db_ui_ssh_connection then
            -- ssh -L 7000:localhost:3306 -N yopaz-dev
            local _, pid = vim.uv.spawn("ssh", { args = { "-L", "7000:localhost:3306", "-N", "yopaz-dev" } })
            vim.g.db_ui_ssh_connection = pid
          end
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
    init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
  },
}
