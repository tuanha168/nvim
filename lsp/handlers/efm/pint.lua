local fs = require "efmls-configs.fs"

local formatter = "pint"
local command = string.format("%s --no-interaction --quiet ${INPUT}", fs.executable(formatter, fs.Scope.COMPOSER))

return {
  formatCommand = command,
  formatStdin = true,
  rootMarkers = { "pint.json", "composer.json", "composer.lock" },
}
