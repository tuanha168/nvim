local js_debuggers = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    restart = true,
    justMyCode = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    restart = true,
    justMyCode = true,
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "Launch & Debug Chrome",
    url = function()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = "URL: ", default = "http://localhost:3000" }, function(url)
          if url == nil or url == "" then return end

          coroutine.resume(co, url)
        end)
      end)
    end,
    port = 9222,
    webRoot = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**", "**/**/*.js" },
    protocol = "inspector",
    sourceMaps = true,
    userDataDir = false,
    justMyCode = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach Program (port 9229)",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    restart = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    port = 9229,
    justMyCode = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach Program From Docker (port 9229)",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    restart = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    port = 9229,
    localRoot = "${workspaceFolder}",
    remoteRoot = "/var/www",
    justMyCode = true,
  },
}

return {
  setup = function(dap)
    dap.configurations = {
      javascript = js_debuggers,
      typescript = js_debuggers,
      javascriptreact = js_debuggers,
      typescriptreact = js_debuggers,
      vue = js_debuggers,
      rust = {
        {
          name = "Launch Rust executable",
          type = "codelldb",
          request = "launch",
          program = function()
            -- Build the project
            Print "Building project..."
            local build_output = vim.fn.system "cargo build"
            if vim.v.shell_error ~= 0 then
              Print(build_output)
              error "Cargo build failed"
            end

            -- Get metadata from cargo
            local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps"
            if vim.v.shell_error ~= 0 then error "Failed to run `cargo metadata`" end

            local metadata = vim.fn.json_decode(metadata_json)
            local target_dir = metadata["target_directory"]
            local packages = metadata["packages"]

            -- Try to find a binary by the current file name first
            local current_file_name = vim.fn.expand "%:t:r" -- Get the current file name without extension
            local found_binary = false

            for _, pkg in ipairs(packages) do
              if pkg["manifest_path"]:find(vim.fn.getcwd(), 1, true) == 1 then
                local targets = pkg["targets"]
                for _, target in ipairs(targets) do
                  if vim.tbl_contains(target["kind"], "bin") then
                    local binary_name = target["name"]
                    -- Check if the binary name matches the current file name
                    if binary_name == current_file_name then
                      found_binary = true
                      return target_dir .. "/debug/" .. binary_name
                    end
                  end
                end
              end
            end

            -- If no matching binary is found, check all binaries in the project
            if not found_binary then
              Print "No binary matching the current file name. Trying all binaries..."
              for _, pkg in ipairs(packages) do
                if pkg["manifest_path"]:find(vim.fn.getcwd(), 1, true) == 1 then
                  local targets = pkg["targets"]
                  for _, target in ipairs(targets) do
                    if vim.tbl_contains(target["kind"], "bin") then
                      local binary_name = target["name"]
                      -- If multiple binaries exist, return the first one (you can modify this logic if needed)
                      return target_dir .. "/debug/" .. binary_name
                    end
                  end
                end
              end
            end

            error "No binary target found in Cargo project."
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {}, -- You can also make this dynamic
        },
      },
      cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          env = "ASPNETCORE_ENVIRONMENT=Development",
          args = {
            "/p:EnvironmentName=Development", -- this is a msbuild jk
            --  this is set via environment variable ASPNETCORE_ENVIRONMENT=Development
            "--urls=http://localhost:5091",
            "--environment=Development",
          },
          program = function()
            local dir = vim.fn.getcwd() .. "/" .. vim.fn.glob "bin/Debug/net*/"
            local name = dir .. vim.fn.glob("*.csproj"):gsub("%.csproj$", ".dll")
            if not Chiruno.func.file_exist(name) then os.execute "dotnet build" end
            return name
          end,
        },
        {
          type = "coreclr",
          name = "attach - netcoredbg",
          request = "attach",
          env = "ASPNETCORE_ENVIRONMENT=Development",
          args = {
            "/p:EnvironmentName=Development", -- this is a msbuild jk
            --  this is set via environment variable ASPNETCORE_ENVIRONMENT=Development
            "--urls=http://localhost:5091",
            "--environment=Development",
          },
          processId = require("dap.utils").pick_process,
        },
      },
    }
  end,
}
