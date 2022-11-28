local M = {
  sources = {
    { name = "cmp_tabnine" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  formatting = {
    format = function(entry, vim_item)
      local icons = require("nvchad_ui.icons").lspkind
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      local menu = ""
      if entry.source.name == "cmp_tabnine" then
        menu = entry.completion_item.data.detail
        vim_item.kind = string.format("%s %s", "", " TabNine")
      end
      -- set a name for each source
      vim_item.menu = menu
      return vim_item
    end,
  },
  -- experimental = {
  --   ghost_text = true,
  -- },
}
return M
