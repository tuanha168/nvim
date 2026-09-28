local inline_plugin = "https://github.com/blackhat-7/vellum.nvim"
local browser_plugins = {
  "https://github.com/selimacerbas/live-server.nvim",
  "https://github.com/selimacerbas/markdown-preview.nvim",
}

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name ~= "vellum.nvim" then return end
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then return end

    dofile(ev.data.path .. "/build.lua")
  end,
})

local choices = {
  {
    label = "Browser",
    open = function()
      vim.pack.add(browser_plugins, { load = true })
      require("markdown_preview").setup {
        instance_mode = "takeover",
        port = 0,
        open_browser = true,
        default_theme = "dark",
        debounce_ms = 300,
      }
      vim.cmd.MarkdownPreview()
    end,
  },
  {
    label = "Inline",
    open = function()
      vim.pack.add({ inline_plugin }, { load = true })
      require("vellum").setup()
      vim.cmd.Vellum()
    end,
  },
}

vim.keymap.set("n", "<leader>mp", function()
  vim.ui.select(choices, {
    prompt = "Markdown preview",
    format_item = function(choice) return choice.label end,
  }, function(choice)
    if choice then choice.open() end
  end)
end, { desc = "Markdown Preview" })
