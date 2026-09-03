local lazy = require "pack.lazy-load"

local plugin = {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/m-demare/attempt.nvim",
}

local scratch_dir = os.getenv "HOME" .. "/.config/nvim/scratch/src"

local function setup_attempt()
  require("attempt").setup {
    dir = scratch_dir,
    ext_options = { "lua", "mts", "py", "php" },
    list_buffers = true,
  }

  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function(e)
      if vim.b[e.buf].scratch_entered then return end
      if not string.find(vim.api.nvim_buf_get_name(e.buf), "scratch/src/scratch", 1, true) then return end
      vim.b[e.buf].scratch_entered = true

      ---@diagnostic disable-next-line: param-type-mismatch
      local haveCodi = pcall(vim.cmd, "Codi")
      ---@diagnostic disable-next-line: param-type-mismatch
      local haveTsw = pcall(vim.cmd, "Tsw")
      if haveCodi then
        vim.keymap.set("n", "<leader>K", "<cmd>CodiExpand<CR>", { buffer = e.buf })
        vim.api.nvim_create_autocmd("BufWritePost", {
          ---@diagnostic disable-next-line: param-type-mismatch
          callback = function() pcall(vim.cmd, "Codi") end,
          buffer = e.buf,
        })
        vim.api.nvim_create_autocmd("InsertEnter", {
          ---@diagnostic disable-next-line: param-type-mismatch
          callback = function() pcall(vim.cmd, "Codi!") end,
          buffer = e.buf,
        })
      elseif haveTsw then
        vim.api.nvim_create_autocmd("BufWritePost", {
          ---@diagnostic disable-next-line: param-type-mismatch
          callback = function() pcall(vim.cmd, "silent! Tsw show_variables=true show_order=true") end,
          buffer = e.buf,
        })
      else
        ---@diagnostic disable-next-line: param-type-mismatch
        pcall(vim.cmd, "Lab code run")
      end
    end,
  })
end

lazy.on_key(plugin, {
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
    function()
      Snacks.picker.files {
        cwd = scratch_dir,
        prompt = "Attempt: ",
        ignored = true,
      }
    end,
    desc = "Snacks Attempt",
  },
}, setup_attempt)
