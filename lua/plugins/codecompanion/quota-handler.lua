local M = {}

---Initialize quota handler with additional setup
function M.init()
  -- Reset fallback model flag on startup
  vim.g.codecompanion_fallback_model = nil

  -- Create user command for quota checking
  vim.api.nvim_create_user_command("CodeCompanionCheckQuota", function()
    local current_model = vim.g.codecompanion_fallback_model or "claude-sonnet-4"
    vim.notify("Current default model: " .. current_model, vim.log.levels.INFO)

    -- Try to get copilot stats if available
    local ok, copilot_adapter = pcall(require, "codecompanion.adapters.copilot")
    if ok and copilot_adapter.show_copilot_stats then copilot_adapter.show_copilot_stats() end
  end, { desc = "Check current CodeCompanion model and quota status" })

  vim.api.nvim_create_user_command("CodeCompanionChangeModel", function()
    -- Try to get current chat instance and switch model
    local current_buf = vim.api.nvim_get_current_buf()

    local switch_to = vim.g.codecompanion_fallback_model == "gpt-4.1" and "claude-sonnet-4" or "gpt-4.1"

    -- Check if we're in a codecompanion chat buffer
    local ok, chat_module = pcall(require, "codecompanion.strategies.chat")
    if ok and chat_module.buf_get_chat then
      local chat = chat_module.buf_get_chat(current_buf)
      if chat and chat.apply_model then
        chat:apply_model(switch_to)
        chat:apply_settings()
        vim.notify(
          "Model switched to "
            .. (switch_to == "claude-sonnet-4" and "Claude Sonnet 4" or "GPT-4.1")
            .. " for current chat.",
          vim.log.levels.WARN
        )
      end
    end

    -- Set fallback model for any new chats
    vim.g.codecompanion_fallback_model = switch_to
  end, { desc = "Check current CodeCompanion model and quota status" })
end

---Handle premium quota exhaustion and switch to GPT-4.1
---@param self CodeCompanion.Adapter
---@param data table
function M.handle_premium_quota_error(self, data)
  -- Handle premium quota exhaustion
  if data and data.status >= 400 then
    local body = data.body or ""

    -- Check for premium quota related errors
    local is_quota_error = body:match "premium"
      or body:match "quota"
      or body:match "limit"
      or body:match "exceeded"
      or body:match "rate limit"
      or body:match "usage limit"
      or body:match "Rate limit"
      or body:match "Usage limit"

    if is_quota_error then
      vim.notify("Premium quota exceeded. Switching to GPT-4.1 model for this session.", vim.log.levels.WARN)

      -- Use vim.schedule to avoid potential race conditions
      vim.schedule(function()
        -- Try to get current chat instance and switch model
        local current_buf = vim.api.nvim_get_current_buf()
        local bufname = vim.api.nvim_buf_get_name(current_buf)

        -- Check if we're in a codecompanion chat buffer
        if bufname:match "codecompanion" then
          local ok, chat_module = pcall(require, "codecompanion.strategies.chat")
          if ok and chat_module.buf_get_chat then
            local chat = chat_module.buf_get_chat(current_buf)
            if chat and chat.apply_model then
              chat:apply_model "gpt-4.1"
              chat:apply_settings()
              vim.notify("Model switched to GPT-4.1 for current chat.", vim.log.levels.INFO)
            end
          end
        end

        -- Set fallback model for any new chats
        vim.g.codecompanion_fallback_model = "gpt-4.1"
      end)
    else
      -- Log other errors
      vim.notify("Copilot error: " .. body, vim.log.levels.ERROR)
    end
  end
end

---Get copilot adapter configuration with premium quota handling
---@return table
function M.get_copilot_adapter_config()
  return {
    handlers = {
      on_exit = M.handle_premium_quota_error,
    },
    schema = {
      model = {
        default = function()
          -- Check if we should use fallback model
          if vim.g.codecompanion_fallback_model then return vim.g.codecompanion_fallback_model end
          return "claude-sonnet-4"
        end,
      },
    },
  }
end

return M
