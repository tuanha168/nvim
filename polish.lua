local function nullWindow()
  local Split = require "nui.split"

  local highlights = require "neo-tree.ui.highlights"
  local split = Split {
    ns_id = highlights.ns_id,
    relative = "editor",
    position = "left",
    size = "20%",
    buf_options = {
      buftype = "nofile",
      modifiable = false,
      swapfile = false,
      filetype = "neo-tree",
      undolevels = -1,
    },
    win_options = {
      colorcolumn = "",
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  }

  -- mount/open the component

  vim.api.nvim_create_autocmd("User", {
    pattern = "ChirunoNeotreeToggle",
    callback = function(e)
      if vim.api.nvim_buf_is_valid(e.buf) then
        local bufName = vim.api.nvim_buf_get_name(e.buf)
        if string.find(bufName, "neo-tree", 1, true) ~= nil then
          split:unmount()
        else
          split:mount()
          vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), e.buf)
        end
      end
    end,
    group = vim.api.nvim_create_augroup("NeoTree", { clear = true }),
  })
end

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
      require "user.Chiruno"
      Chiruno.auto_reload_cmp()
      vim.diagnostic.config { virtual_text = true }
    end,
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
    callback = function() Chiruno.auto_push "~/neorg" end,
  })

  autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function(event)
      if string.match(event.match, os.getenv "HOME" .. "/.config/nvim/lua/user") then
        Chiruno.auto_push "~/.config/nvim/lua/user"
      end

      if string.match(event.match, os.getenv "HOME" .. "/.dotfile") then Chiruno.auto_push "~/.dotfile" end
    end,
  })

  nullWindow()
end
