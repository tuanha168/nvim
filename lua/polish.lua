-- Create autocmds
local autocmds = require "autocmds"
for _, autocmd in pairs(autocmds) do
  vim.api.nvim_create_autocmd(
    autocmd[1],
    vim.tbl_deep_extend("force", autocmd.opts or {}, {
      callback = autocmd[2],
    })
  )
end

-- Create commands
local commands = require "commands"
for _, command in pairs(commands) do
  vim.api.nvim_create_user_command(command[1], command[2], vim.tbl_deep_extend("force", command.opts or {}, {}))
end

-- Add filetype
vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}
vim.filetype.add {
  pattern = { [".*%.env.*"] = "sh" },
}

-- -- https://github.com/neovim/neovim/issues/27240#issuecomment-2053854899
-- local ellipsis = "..."
-- local methods = vim.lsp.protocol.Methods
-- local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
-- local lsp_inlay_hint_key = {
--   "vue_ls",
--   "ts_ls",
--   "vtsls",
-- }

-- vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
--   local client = vim.lsp.get_client_by_id(ctx.client_id)
--   local maxLength = 20

--   for _, lsp in pairs(lsp_inlay_hint_key) do
--     if client and result and (client.name == lsp) then
--       result = vim
--         .iter(result)
--         :map(function(hint)
--           local label = hint.label
--           if not label then return hint end

--           -- string
--           if type(label) == "string" then
--             if label:len() >= maxLength then label = label:sub(1, maxLength - 1) .. ellipsis end
--             hint.label = label
--           -- table
--           elseif type(label) == "table" then
--             local temp = ""
--             for _, lb in ipairs(label) do
--               if type(lb.value) == "string" then temp = temp .. lb.value end
--             end
--             if temp and temp:len() >= maxLength then temp = temp:sub(1, maxLength - 1) .. ellipsis end
--             hint.label = temp
--           end

--           return hint
--         end)
--         :totable()
--     end
--   end

--   inlay_hint_handler(err, result, ctx, config)
-- end
