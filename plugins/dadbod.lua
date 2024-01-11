return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod" },
      { "pbogut/vim-dadbod-ssh" },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    keys = {
      {
        "<leader>cdb",
        -- ssh -L 7000:localhost:3306 -N yopaz-dev
        function()
          vim.cmd.DBUIToggle()
          vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.DBUI, modeline = false })
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
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      -- autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

      local ok, cmp = pcall(require, "cmp")
      if not ok then return end

      local autocmd = vim.api.nvim_create_autocmd

      autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function() cmp.setup.buffer { sources = { { name = "vim-dadbod-completion" } } } end,
        once = true,
      })
    end,
  },
}
