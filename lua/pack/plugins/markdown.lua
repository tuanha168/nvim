local lazy = require "pack.lazy-load"

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "peek.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = ev.data.path })
    end
  end,
})

lazy.on_event("https://github.com/toppair/peek.nvim", "FileType", function()
  require("peek").setup {
    app = "browser",
  }
  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end, { pattern = "markdown" })

require("which-key").add {
  { "<leader>mp", "<cmd>PeekOpen<cr>", desc = "Markdown Preview Open" },
}
