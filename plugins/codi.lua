return {
  { "metakirby5/codi.vim", cmd = "Codi", build = "npm install -g tsun" },
  {
    "m-demare/attempt.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>at",
        function()
          local ok, attempt = pcall(require, "attempt")
          if not ok then return end

          attempt.new_select()
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

      vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        pattern = "*",
        callback = function(e)
          if vim.b.scratch_entered then return end
          if string.find(vim.api.nvim_buf_get_name(e.buf), "scratch/src", 1, true) then
            vim.b.scratch_entered = true
            vim.cmd "e"
            Chiruno.close_null_window()
            vim.cmd "Codi"
            Chiruno.open_null_window()
          end
        end,
      })
    end,
  },
}
