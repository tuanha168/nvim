local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local exec_event = require("utils").event
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")

autocmd({ "VimEnter", "ColorScheme" }, {
  desc = "Load custom highlights from user configuration",
  group = augroup("apply highlights", { clear = true }),
  callback = function()
    if vim.g.colors_name then
      for _, module in ipairs { "init", vim.g.colors_name } do
        local ok, mod = pcall(require, "highlights." .. module)
        if not ok then return end
        if type(mod) == "function" then mod = mod() end
        for group, spec in pairs(mod) do
          vim.api.nvim_set_hl(0, group, spec)
        end
      end
    end
  end,
})

local bufferline_group = augroup("bufferline", { clear = true })
autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
  desc = "Update buffers when adding new buffers",
  group = bufferline_group,
  callback = function(args)
    local buf_utils = require "utils.buffer"
    if not vim.t.bufs then vim.t.bufs = {} end
    if not buf_utils.is_valid(args.buf) then return end
    if args.buf ~= buf_utils.current_buf then
      buf_utils.last_buf = buf_utils.is_valid(buf_utils.current_buf) and buf_utils.current_buf or nil
      buf_utils.current_buf = args.buf
    end
    local bufs = vim.t.bufs
    if not vim.tbl_contains(bufs, args.buf) then
      table.insert(bufs, args.buf)
      vim.t.bufs = bufs
    end
    vim.t.bufs = vim.tbl_filter(buf_utils.is_valid, vim.t.bufs)
    exec_event "BufsUpdated"
  end,
})

autocmd("BufDelete", {
  desc = "Update buffers when deleting buffers",
  group = bufferline_group,
  callback = function(args)
    local removed
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            removed = true
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
    vim.t.bufs = vim.tbl_filter(require("utils.buffer").is_valid, vim.t.bufs)
    if removed then exec_event "BufsUpdated" end
    vim.cmd.redrawtabline()
  end,
})

autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  group = augroup("q_close_windows", { clear = true }),
  callback = function(event)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
    if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
      vim.keymap.set("n", "q", "<cmd>close<cr>", {
        desc = "Close window",
        buffer = event.buf,
        silent = true,
        nowait = true,
      })
    end
  end,
})

autocmd("BufRead", {
  pattern = "*",
  callback = function() require "Chiruno" end,
  once = true,
})

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    -- vim.cmd "set laststatus&"
    vim.cmd "syntax sync fromstart"
  end,
})

autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function() vim.cmd "checktime" end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.conf",
  callback = function() vim.cmd "setf dosini" end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*.norg",
  callback = function() Chiruno.auto_push "~/neorg" end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  callback = function(event)
    if string.match(event.file, os.getenv "HOME" .. "/.config/nvim/lua/user") then
      Chiruno.auto_push "~/.config/nvim/lua/user"
    end

    if string.match(event.file, os.getenv "HOME" .. "/.dotfile") then Chiruno.auto_push "~/.dotfile" end
  end,
})
