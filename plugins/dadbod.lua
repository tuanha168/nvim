return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod" },
      {
        "pbogut/vim-dadbod-ssh",
        init = function()
          vim.cmd [[
            let g:my_db = "ssh://yopaz-dev:mysql://root:FUGNafjjCx5EDefk@127.0.0.1:3306" 
          ]]
        end,
      },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
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
