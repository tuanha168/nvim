-- Close null window
---@param table table<string | number, any>
---@param keys_or_values "keys" | "values"
---@return nil
function Chiruno.func.parse_from_table(table, keys_or_values)
  keys_or_values = keys_or_values or "keys"
  local result = {}
  local n = 0

  for k, v in pairs(table) do
    n = n + 1
    result[n] = keys_or_values == "keys" and k or v
  end

  return result
end
