local util = require "lspconfig.util"

local root_dir = util.root_pattern(
  ".eslintrc.cjs",
  ".eslintrc.js",
  ".eslintrc.ts",
  ".eslintrc.json",
  ".eslintrc.yml",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.ts"
)

local function get_eslint_server_path()
  local found_bin = ""

  local function check_dir(path)
    found_bin = util.path.join(path, "node_modules", ".bin", "eslint")
    if util.path.exists(found_bin) then return path end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_bin
  else
    return {"~/.local/share/nvim/mason/bin/vscode-eslint-language-server", "--stdio"}
  end
end

return {
  -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json" },
  cmd = get_eslint_server_path(),
  root_dir = root_dir,
}
