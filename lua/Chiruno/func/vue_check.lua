function Chiruno.func.vueCheck(client, buf)
  if client.name ~= "tsgo" and client.name ~= "vtsls" then return end

  -- -- Use vim.fs.root to find root directory by searching for markers from current file outward
  -- local root_dir = vim.fs.root(buf or 0, { "package.json", ".git" })
  -- if not root_dir then return "tsgo" end

  -- local package_json = vim.fs.joinpath(root_dir, "package.json")
  -- local f = io.open(package_json, "r")
  -- if not f then return "tsgo" end

  -- local content = f:read "*a"
  -- f:close()

  -- local ok, package_data = pcall(vim.fn.json_decode, content)
  -- if not ok then return "tsgo" end

  -- local function has_vue_pkg(deps)
  --   if not deps then return false end
  --   for name in pairs(deps) do
  --     if name:find("vue", 1, true) or name:find("nuxt", 1, true) then return true end
  --   end
  --   return false
  -- end
  -- local has_vue = has_vue_pkg(package_data.dependencies) or has_vue_pkg(package_data.devDependencies)

  -- if not has_vue then return "tsgo" end

  return "vtsls"
end

return Chiruno.func.vueCheck
