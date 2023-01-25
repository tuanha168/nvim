local M = {}

M.setup = function()
  local ok, cmp = pcall(require, "cmp")
  if not ok then
    return
  end

  cmp.setup {
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
    mapping = {
      ["<C-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    -- experimental = {
    --   ghost_text = true,
    -- },
  }
end
return M
