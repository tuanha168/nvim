return {
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = function()
      require("yanky").setup {
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
          ignore_registers = { "_" },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      }
    end,
    config = function()
      local check_telescope, telescope = pcall(require, "telescope")
      if check_telescope then
        telescope.load_extension "yank_history"
        vim.keymap.set("n", "<c-p>", "<cmd>Telescope yank_history<cr><esc>", { silent = true })
      else
        vim.keymap.set("n", "<c-p>", "<cmd>YankyRingHistory<cr>", { silent = true })
      end

      vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
      -- vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      -- vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    end,
  },
}
