local util = require "lspconfig.util"

local function get_eslint_server_path(root_dir)
  local global_bin = require("mason-registry").get_package("eslint"):get_install_path()
  Print(global_bin)

  local found_bin = ""

  local function check_dir(path)
    found_bin = util.path.join(path, "node_modules", ".bin", "eslint")
    if util.path.exists(found_bin) then return path end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return { found_bin }
  else
    return { "~/.local/share/nvim/mason/bin/vscode-eslint-language-server", "--stdio" }
  end
end

return {
  -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "json" },
  root_dir = util.root_pattern(
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.ts",
    ".eslintrc.json",
    ".eslintrc.yml",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.ts"
  ),
  on_new_config = function(new_config, new_root_dir) new_config.cmd = get_eslint_server_path(new_root_dir) end,
}
