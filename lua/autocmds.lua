local home = os.getenv "HOME"

local autoPushDir = {
  home .. "/.config/nvim",
  home .. "/.dotfile/super%-secret",
  home .. "/.dotfile",
}
local excludeDir = { "scratch/src" }
local uv = vim.uv or vim.loop

local function swapToVtsls(client, buf)
  -- if current file is vue file, and tsgo are enabled, disable it and swap to vtsls
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf or 0 })
  if filetype ~= "vue" then return end
  local tsgo_active = false
  for _, cap in pairs(client.server_capabilities) do
    Print(_)
    if cap == true and string.find(_, "tsgo") then
      tsgo_active = true
      break
    end
  end
  Print(tsgo_active, client.name)
  if not tsgo_active then return end
  client.stop()

  vim.lsp.start { name = "vtsls" }
end

---@class LegendaryAutoCmd
---@field [1] any (string|array)
---@field [2] string|(fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?)

---@type (LegendaryAutoCmd)[]
return {
  {
    { "VimEnter", "VimLeave", "FocusGained" },
    function()
      if vim.env.TMUX_PLUGIN_MANAGER_PATH then
        uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
      end
    end,
  },
  {
    "LspAttach",
    function(e)
      require("lsp.mappings").setup(e.buf)

      local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
      if client:supports_method "textDocument/foldingRange" then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      end

      swapToVtsls(client)
    end,
  },
  {
    { "FocusGained", "BufReadPost" },
    function()
      vim.cmd "checktime"
      local ok, _ = pcall(require, "git-conflict")
      if not ok then return end
      vim.cmd "GitConflictRefresh"
    end,
  },
  {
    { "BufRead", "BufNewFile" },
    function() vim.cmd "setf dosini" end,
  },
  {
    { "BufRead", "BufNewFile" },
    function() vim.cmd "setf c" end,
    opts = {
      pattern = "*.keymap",
    },
  },
  {
    { "BufWritePre" },
    function() Chiruno.func.auto_push "~/neorg" end,
    opts = {
      pattern = "*.norg",
    },
  },
  {
    { "BufWritePre" },
    function(event)
      local ok, userConfig = pcall(require, "config")
      if ok and not userConfig.auto_push_config then return end

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
  },

  -- lazygit with snacks_terminal
  {
    { "BufRead", "BufEnter" },
    function(event)
      -- close lazygit terminal when leave
      if Snacks then
        if vim.api.nvim_get_option_value("filetype", { buf = event.buf }) ~= "snacks_terminal" then
          local instance = Snacks.terminal.get({ "lazygit" }, { create = false })
          if instance then instance.hide(instance) end
        end
      end

      -- quickfix delete entry
      if vim.bo[event.buf].buftype == "quickfix" then
        vim.keymap.set("n", "dd", function()
          local items = vim.fn.getqflist()
          local line = vim.fn.line "."
          table.remove(items, line)
          vim.fn.setqflist(items, "r")
          vim.api.nvim_win_set_cursor(0, { line, 0 })
        end, { silent = true, buffer = event.buf, desc = "Remove entry from QF" })
      end
    end,
  },

  {
    "FileType",
    function() vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" }) end,
    opts = {
      pattern = { "json" },
    },
  },

  -- disable inlay hint for vue files
  {
    "FileType",
    function(event) vim.lsp.inlay_hint.enable(false, { bufnr = event.buf }) end,
    opts = {
      pattern = { "vue" },
    },
  },

  -- {
  --   { "ModeChanged" },
  --   function() vim.api.nvim_exec_autocmds("User", { pattern = "VisualEnter" }) end,
  --   opts = {
  --     pattern = { "*:[vV\x16]*" },
  --   },
  -- },
  -- {
  --   { "ModeChanged" },
  --   function() vim.api.nvim_exec_autocmds("User", { pattern = "VisualLeave" }) end,
  --   opts = {
  --     pattern = { "[vV\x16]*:*" },
  --   },
  -- },

  {
    "TabNew",
    function() vim.cmd "tabclose" end,
  },
}
