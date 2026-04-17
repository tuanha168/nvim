vim.pack.add { "https://github.com/nickjvandyke/opencode.nvim" }

require("which-key").add {
  {
    "<C-a>",
    function()
      if require("config.opencode_ensure").ensure_server_sync() then
        require("opencode").ask("@this: ")
      end
    end,
    mode = { "n", "x" },
    desc = "Ask opencode…"
  },
  {
    "<C-p>",
    function()
      if require("config.opencode_ensure").ensure_server_sync() then
        require("opencode").select()
      end
    end,
    mode = { "n", "x" },
    desc = "Execute opencode action…"
  },
  { "<Leader>cc", function() require("config.opencode_ensure").ensure_server() end, mode = { "n", "t" }, desc = "Start opencode server" },
  {
    "<Leader>cc",
    function()
      if require("config.opencode_ensure").ensure_server_sync() then
        return require("opencode").operator("@this ")
      end
      return ""
    end,
    mode = { "x" },
    desc = "Add range to opencode",
    expr = true
  },
  {
    "<Leader>goo",
    function()
      if require("config.opencode_ensure").ensure_server_sync() then
        return require("opencode").operator("@this ") .. "_"
      end
      return ""
    end,
    mode = "n",
    desc = "Add line to opencode",
    expr = true
  },
}

vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      events = {
        enabled = false
      }
    }

    local S = require("snacks")
    S.config.picker = S.init.config.merge(S.config.picker, {
      actions = {
        opencode_send = function(...)
          local ok, opencode = pcall(require, "opencode")
          if ok then
            return opencode.snacks_picker_send(...)
          end
        end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
    })

    -- local cfg = require("opencode.config")
    -- cfg.opts.ask.snacks.win.keys.i_cr = {
    --   "<CR>",
    --   function(win)
    --     local text = win:text() .. "\\n"
    --     vim.schedule(function()
    --       vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, { text })
    --       win:execute("confirm")
    --     end)
    --   end,
    --   mode = "i",
    --   desc = "submit with newline",
    -- }

    vim.o.autoread = true -- Required for `opts.events.reload`
  end,
  once = true,
})
