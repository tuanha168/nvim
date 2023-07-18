local fs = require "efmls-configs.fs"

local formatter = "pint"
local command = string.format("%s ${INPUT}", fs.executable(formatter, fs.Scope.COMPOSER))

return {
  formatCommand = command,
  formatStdin = true,
}
