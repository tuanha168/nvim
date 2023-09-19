return {
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    build = "npm install -g tsun",
  },
  {
    "m-demare/attempt.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>at",
        function()
          local ok, attempt = pcall(require, "attempt")
          if not ok then return end

          attempt.new_select()
          vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = "*",
            callback = function(e)
              if string.find(vim.api.nvim_buf_get_name(e.buf), "scratch", 1, true) then
                vim.cmd "Codi"
                local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = "attempt" })
                if cmds_found then vim.tbl_map(function(cmd) vim.api.nvim_del_autocmd(cmd.id) end, cmds) end
              end
            end,
            group = vim.api.nvim_create_augroup("attempt", { clear = true }),
          })
        end,
        desc = "Attempt",
      },
      {
        "<leader>aa",
        "<cmd>Telescope attempt<cr>",
        desc = "Telescope Attempt",
      },
    },
    config = function()
      require("attempt").setup {
        dir = os.getenv "HOME" .. "/.config/nvim/lua/user/scratch/src",
        ext_options = { "lua", "js", "ts", "py", "cpp", "c" }, -- Options to choose from
      }

      local ok, telescope = pcall(require, "telescope")
      if not ok then return end
      telescope.load_extension "attempt"
    end,
  },
}
