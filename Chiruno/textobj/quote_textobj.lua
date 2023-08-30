Chiruno = Chiruno or {}

function Chiruno.is_inside(pos, selections)
  local buffer = require "nvim-surround.buffer"
  return buffer.comes_before(selections.first_pos, pos) and buffer.comes_before(pos, selections.last_pos)
end

function Chiruno.filter_selections_list(selections_list)
  local buffer = require "nvim-surround.buffer"
  local curpos = buffer.get_curpos()
  local best_selections
  for _, cur_selections in ipairs(selections_list) do
    if
      cur_selections
      and cur_selections.first_pos[1] == cur_selections.last_pos[1]
      and cur_selections.first_pos[1] >= curpos[1] - 5
      and cur_selections.first_pos[1] <= curpos[1] + 5
    then
      best_selections = best_selections or cur_selections
      if Chiruno.is_inside(curpos, best_selections) then
        -- Handle case where the cursor is inside the nearest selections
        if
          Chiruno.is_inside(curpos, cur_selections)
          and buffer.comes_before(best_selections.first_pos, cur_selections.first_pos)
          and buffer.comes_before(cur_selections.last_pos, best_selections.last_pos)
        then
          best_selections = cur_selections
        end
      elseif buffer.comes_before(curpos, best_selections.first_pos) then
        -- Handle case where the cursor comes before the nearest selections
        if
          Chiruno.is_inside(curpos, cur_selections)
          or buffer.comes_before(curpos, cur_selections.first_pos)
            and buffer.comes_before(cur_selections.first_pos, best_selections.first_pos)
        then
          best_selections = cur_selections
        end
      else
        -- Handle case where the cursor comes after the nearest selections
        if
          Chiruno.is_inside(curpos, cur_selections)
          or buffer.comes_before(best_selections.last_pos, cur_selections.last_pos)
        then
          best_selections = cur_selections
        end
      end
    end
  end
  return best_selections
end

---@param mode "i"|"a"
function Chiruno.quote_textobj(mode)
  local buffer = require "nvim-surround.buffer"

  if vim.api.nvim_get_mode().mode == "v" then vim.cmd "norm! v" end
  local chars = { '"', "'", "`" }
  local selections_list = {}
  for _, c in ipairs(chars) do
    local cur_selections = require("nvim-surround.motions").get_selection("a" .. c)
    if cur_selections then selections_list[#selections_list + 1] = cur_selections end
  end
  local nearest_selections = Chiruno.filter_selections_list(selections_list)

  if nearest_selections then
    local startQuote, endQuote = nearest_selections.first_pos, nearest_selections.last_pos
    if "i" == mode then
      startQuote = { nearest_selections.first_pos[1], nearest_selections.first_pos[2] + 1 }
      endQuote = { nearest_selections.last_pos[1], nearest_selections.last_pos[2] - 1 }
    end

    if vim.api.nvim_get_mode().mode ~= "v" then
      vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {})
    end

    buffer.set_curpos(startQuote)
    vim.cmd "norm! o"
    buffer.set_curpos(endQuote)
  end
end

return Chiruno.quote_textobj
