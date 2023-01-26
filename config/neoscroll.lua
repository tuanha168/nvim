local M = {}

M.setup = function()
  require("neoscroll").setup {
    post_hook = function()
      vim.cmd "norm! zz"
    end,
  }
  local t = {}
  t["{"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
  t["}"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
  require("neoscroll.config").set_mappings(t)
end

return M
