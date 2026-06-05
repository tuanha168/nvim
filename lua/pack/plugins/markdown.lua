local lazy = require "pack.lazy-load"

local function resolve_firefox_profile_dir()
  local root = vim.fn.expand "~/.mozilla/firefox"
  local profiles_ini = root .. "/profiles.ini"

  if vim.fn.filereadable(profiles_ini) ~= 1 then
    return nil
  end

  local profiles = {}
  local install_default
  local current

  local function flush()
    if current and current.path then
      current.abs_path = current.is_relative and (root .. "/" .. current.path) or current.path
      profiles[#profiles + 1] = current
    end

    current = nil
  end

  for _, line in ipairs(vim.fn.readfile(profiles_ini)) do
    local section = line:match "^%[(.-)%]$"

    if section then
      flush()

      if section:match "^Profile" then
        current = {
          section = section,
          is_relative = true,
        }
      elseif section:match "^Install" then
        current = {
          section = section,
          is_install = true,
        }
      end
    elseif current then
      local key, value = line:match "^([%w]+)=(.*)$"

      if key == "Path" then
        current.path = value
      elseif key == "IsRelative" then
        current.is_relative = value == "1"
      elseif key == "Default" and current.is_install then
        install_default = value
      elseif key == "Default" then
        current.default = value == "1"
      end
    end
  end

  flush()

  if install_default then
    for _, profile in ipairs(profiles) do
      if profile.path == install_default then
        return profile.abs_path
      end
    end
  end

  for _, profile in ipairs(profiles) do
    if profile.default then
      return profile.abs_path
    end
  end

  return profiles[1] and profiles[1].abs_path or nil
end

local function writefile_if_changed(lines, path)
  local old = vim.fn.filereadable(path) == 1 and vim.fn.readfile(path) or {}

  if vim.deep_equal(old, lines) then
    return
  end

  vim.fn.writefile(lines, path)
end

local function ensure_firefox_pref(lines, pref)
  local updated = {}
  local seen = false
  local pref_name = pref:match '^user_pref%("([^"]+)"'
  local pref_prefix = pref_name and ('user_pref("' .. pref_name .. '"') or nil

  for _, line in ipairs(lines) do
    if pref_prefix and line:sub(1, #pref_prefix) == pref_prefix then
      if not seen then
        updated[#updated + 1] = pref
        seen = true
      end
    else
      updated[#updated + 1] = line
    end
  end

  if not seen then
    updated[#updated + 1] = pref
  end

  return updated
end

local function upsert_marked_block(lines, start_marker, end_marker, block)
  local updated = {}
  local in_block = false

  for _, line in ipairs(lines) do
    if line == start_marker then
      in_block = true
    elseif in_block and line == end_marker then
      in_block = false
    elseif not in_block then
      updated[#updated + 1] = line
    end
  end

  if #updated > 0 and updated[#updated] ~= "" then
    updated[#updated + 1] = ""
  end

  vim.list_extend(updated, block)
  return updated
end

local function ensure_firefox_peek_userstyle()
  local profile_dir = resolve_firefox_profile_dir()

  if not profile_dir then
    return
  end

  local user_js = profile_dir .. "/user.js"
  local chrome_dir = profile_dir .. "/chrome"
  local user_css = chrome_dir .. "/userContent.css"
  local firefox_pref = 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);'
  local css_start_marker = "/* peek.nvim userstyle:start */"
  local css_end_marker = "/* peek.nvim userstyle:end */"
  local css_block = {
    css_start_marker,
    '@-moz-document url-prefix("http://localhost"), url-prefix("http://127.0.0.1") {',
    "  body.peek-body .markdown-body {",
    "    max-width: 80vw !important;",
    "    padding: 24px !important;",
    "  }",
    "}",
    css_end_marker,
  }
  local user_js_lines = vim.fn.filereadable(user_js) == 1 and vim.fn.readfile(user_js) or {}
  writefile_if_changed(ensure_firefox_pref(user_js_lines, firefox_pref), user_js)

  local css_lines = vim.fn.filereadable(user_css) == 1 and vim.fn.readfile(user_css) or {}
  vim.fn.mkdir(chrome_dir, "p")
  writefile_if_changed(upsert_marked_block(css_lines, css_start_marker, css_end_marker, css_block), user_css)
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "peek.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = ev.data.path })
      ensure_firefox_peek_userstyle()
    end
  end,
})

local peek_plugin = "https://github.com/toppair/peek.nvim"

local function setup_peek()
  require("peek").setup {
    app = "browser",
  }
  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

lazy.on_key(peek_plugin, {
  { "<leader>mp", function() require("peek").open() end, desc = "Markdown Preview Open" },
}, setup_peek)
