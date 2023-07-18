local fs = require "efmls-configs.fs"

local formatter = "pint"
local args = "--quiet ${INPUT}"
local command = string.format("%s %s", fs.executable(formatter, fs.Scope.COMPOSER), args)

return {
  formatCommand = command,
  formatStdin = true,
  rootMarkers = { "pint.json", "composer.json", "composer.lock" },
}
