local home = os.getenv "HOME"

return {
  root_markers = { ".git", "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json" },
  settings = {
    css = {
      customData = {
        home .. "/.config/nvim/.vscode/tailwind.json",
      },
    },
  },
}
