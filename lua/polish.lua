-- Generate neoconf
local neoconf = os.getenv "HOME" .. "/.config/nvim/neoconf"
if not Chiruno.func.file_exist(neoconf .. ".json") then
  Print("Generate neoconf:", neoconf .. ".json")
  vim.schedule(function() vim.cmd("silent !lua " .. neoconf .. ".lua") end)
end

-- Add filetype
vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufRead", {
  pattern = "*",
  callback = function()
    Chiruno.autocmd.auto_reload_cmp()
    Chiruno.autocmd.null_window()
  end,
  once = true,
})

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function( --[[ event ]])
    -- vim.cmd "set laststatus&"
    vim.cmd "syntax sync fromstart"
    -- if string.match(event.match, "package.json") then require("package-info").show() end
  end,
})

autocmd({ "FocusGained", "BufReadPost" }, {
  pattern = "*",
  callback = function()
    vim.cmd "checktime"
    local ok, _ = pcall(require, "git-conflict")
    if not ok then return end
    vim.cmd "GitConflictRefresh"
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.conf",
  callback = function() vim.cmd "setf dosini" end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.keymap",
  callback = function() vim.cmd "setf c" end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*.norg",
  callback = function() Chiruno.func.auto_push "~/neorg" end,
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  ---@param event AutocmdCallbackEvent
  callback = function(event)
    local ok, userConfig = pcall(require, "config")
    if ok and not userConfig.auto_push_config then return end

    local home = os.getenv "HOME"

    local autoPushDir = {
      home .. "/.config/nvim",
      home .. "/.dotfile/super%-secret",
      home .. "/.dotfile",
    }
    local excludeDir = { "scratch/src" }

    local isBreak = false
    for _, dir in ipairs(autoPushDir) do
      if isBreak then break end

      for _, exclude in ipairs(excludeDir) do
        if string.match(event.match, dir) and not string.match(event.match, exclude) then
          Chiruno.func.auto_push(dir:gsub("%%", ""))
          if string.match(event.match, "nvim/neoconf.lua") then
            vim.schedule(function() vim.cmd("silent !lua " .. event.match) end)
          end
          isBreak = true
          break
        end
      end
    end
  end,
})

local disable_node_modules_eslint_group = vim.api.nvim_create_augroup("DisableNodeModulesEslint", { clear = true })

autocmd({ "BufNewFile", "BufRead", "BufEnter" }, {
  pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
  callback = function() vim.diagnostic.enable(false) end,
  group = disable_node_modules_eslint_group,
})

local buf_large_group = vim.api.nvim_create_augroup("BufLarge", { clear = true })

autocmd({ "BufReadPre" }, {
  ---@param event AutocmdCallbackEvent
  callback = function(event)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and (stats.size > 100000 or vim.api.nvim_buf_line_count(event.buf) > 3000) then
      -- vim.b[event.buf].large_buf = true
      -- vim.cmd "syntax off"
      ---@diagnostic disable-next-line: param-type-mismatch
      -- pcall(vim.cmd, "IlluminatePauseBuf") -- disable vim-illuminate
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      -- else
      --   vim.b[event.buf].large_buf = false
    end
    vim.b[event.buf].large_buf = false
  end,
  group = buf_large_group,
  pattern = "*",
})

autocmd({ "BufWritePost" }, {
  pattern = "*",
  callback = function()
    local fp = vim.fn.expand "%:p"
    local pos = #fp
    local pom = ""
    while pos > 0 do
      if fp:sub(pos, pos) == "/" then
        pom = fp:sub(1, pos) .. "pom.xml"
        if vim.fn.filereadable(pom) == 1 then break end
      end
      pos = pos - 1
    end
    if pom ~= "" then vim.schedule(function() vim.cmd 'silent !tmux new -d "./rebuild"' end) end
  end,
})

local ellipsis = "..."
local methods = vim.lsp.protocol.Methods
local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
local lsp_inlay_hint_key = {
  'volar',
  'ts_ls',
}

vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  for lsp in pairs(lsp_inlay_hint_key) do
    if client and (client.name == lsp) then
      result = vim
        .iter(result)
        :map(function(hint)
          local label = hint.label
          if not label then return hint end

          if type(label) == "string" and label:len() >= 30 then label = label:sub(1, 29) .. ellipsis end

          if type(label) == "table" then
            label.value = label.value:sub(1, 29) .. ellipsis
            return hint
          end

          hint.label = label
          return hint
        end)
        :totable()
    end
  end

  inlay_hint_handler(err, result, ctx, config)
end
