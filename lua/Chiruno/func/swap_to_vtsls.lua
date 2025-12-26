function Chiruno.func.swapToVtsls(client, buf)
  if client.name ~= "tsgo" and client.name ~= "vtsls" then return end

  -- Use vim.fs.root to find root directory by searching for markers from current file outward
  local root_dir = vim.fs.root(buf or 0, { "package.json", ".git" })
  if not root_dir then return end

  local package_json = vim.fs.joinpath(root_dir, "package.json")
  local f = io.open(package_json, "r")
  if not f then
    return "tsgo"
  end

  local content = f:read "*a"
  f:close()

  local ok, package_data = pcall(vim.fn.json_decode, content)
  if not ok then
    return "tsgo"
  end

  local has_vue = (package_data.dependencies and (package_data.dependencies.vue or package_data.dependencies.nuxt))
    or (package_data.devDependencies and (package_data.devDependencies.vue or package_data.devDependencies.nuxt))
  if not has_vue then
    return "tsgo"
  end

  return "vtsls"
end

return Chiruno.func.swapToVtsls
