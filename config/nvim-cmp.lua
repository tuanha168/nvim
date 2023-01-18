-- local cmp = require('cmp')

local M = {
  sources = {
    { name = "nvim_lsp" },
    { name = "cmp_tabnine" },
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
  -- mapping = {
  --   ["<Tab>"] = cmp.mapping(function(fallback)
  --     -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
  --     if cmp.visible() then
  --       local entry = cmp.get_selected_entry()
  --       if not entry then
  --         cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  --       else
  --         cmp.confirm()
  --       end
  --     else
  --       fallback()
  --     end
  --   end, { "i", "s", "c" }),
  -- },
  -- experimental = {
  --   ghost_text = true,
  -- },
}
return M
