-- Directional window resize. The arrow says which side of the *current* window
-- moves:
--   grow(dir):   the current window expands towards `dir`, taking space from the
--                neighbour on that side.
--   shrink(dir): the edge of the current window on side `dir` retracts, giving
--                space to the neighbour on that side.
-- Does nothing when there is no neighbour on that side. Works with fixed-size
-- windows (nvim-tree) by lifting winfixwidth/winfixheight on the two windows
-- around the border while resizing.
local M = {}

local KEY = { left = "h", right = "l", up = "k", down = "j" }

-- Window id of the neighbour in direction `dir`, or nil if none.
local function neighbor(dir)
  local nr = vim.fn.winnr(KEY[dir])
  if nr == vim.fn.winnr() then
    return nil
  end
  return vim.fn.win_getid(nr)
end

-- `first` is the left/top window of the border, `second` the right/bottom one.
-- Positive `delta` moves the border right/down.
local function move_border(first, second, delta, vertical)
  local get = vertical and vim.api.nvim_win_get_height or vim.api.nvim_win_get_width
  local set = vertical and vim.api.nvim_win_set_height or vim.api.nvim_win_set_width
  local opt = vertical and "winfixheight" or "winfixwidth"

  if get(first) + delta < 1 or get(second) - delta < 1 then
    return
  end

  local fix_first, fix_second = vim.wo[first][opt], vim.wo[second][opt]
  vim.wo[first][opt] = false
  vim.wo[second][opt] = false
  set(first, get(first) + delta)
  vim.wo[first][opt] = fix_first
  vim.wo[second][opt] = fix_second
end

local function resize(dir, step, grow)
  local cur = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(cur).relative ~= "" then
    return
  end
  local other = neighbor(dir)
  if not other then
    return
  end

  local vertical = dir == "up" or dir == "down"
  local forward = dir == "right" or dir == "down" -- neighbour is after the current window
  -- The border moves towards `dir` when growing, away from it when shrinking.
  local delta = (grow == forward) and step or -step
  if forward then
    move_border(cur, other, delta, vertical)
  else
    move_border(other, cur, delta, vertical)
  end
end

function M.grow(dir, step)
  resize(dir, step or 2, true)
end

function M.shrink(dir, step)
  resize(dir, step or 2, false)
end

return M
