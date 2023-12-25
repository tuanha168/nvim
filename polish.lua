-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    config.border = "rounded"
    if not (result and result.contents) then return end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then return end
    for k, v in pairs(markdown_lines) do
      markdown_lines[k] = string.gsub(v, "^(%s*.-)%s*$", "%1")
    end
    local floating_bufnr, _ = vim.lsp.util.open_floating_preview(markdown_lines, "", config)
    vim.api.nvim_buf_set_option(floating_bufnr, "filetype", "markdown")
  end

  local autocmd = vim.api.nvim_create_autocmd

  autocmd("BufRead", {
    pattern = "*",
    callback = function()
      Chiruno.autocmd.auto_reload_cmp()
      Chiruno.autocmd.null_window()
      vim.diagnostic.config { virtual_text = true }
    end,
    once = true,
  })

  autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(--[[ event ]])
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

  autocmd({ "BufWritePre" }, {
    pattern = "*.norg",
    callback = function() Chiruno.func.auto_push "~/neorg" end,
  })

  autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function(event)
      local home = os.getenv "HOME"

      local autoPushDir = {
        home .. "/.config/nvim/lua/user",
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
    callback = function() vim.diagnostic.disable(0) end,
    group = disable_node_modules_eslint_group,
  })

  local buf_large_group = vim.api.nvim_create_augroup("BufLarge", { clear = true })

  autocmd({ "BufReadPre" }, {
    callback = function()
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
      if ok and stats and (stats.size > 1000000) then
        vim.b.large_buf = true
        vim.cmd "syntax off"
        vim.cmd "IlluminatePauseBuf" -- disable vim-illuminate
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.spell = false
      else
        vim.b.large_buf = false
      end
    end,
    group = buf_large_group,
    pattern = "*",
  })
end
