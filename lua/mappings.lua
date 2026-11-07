require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Moving through the nvim spaces
map("n", "zj", "o<ESC>k")
map("n", "zk", "O<ESC>j")

-- Example: keymap for custom prompt
-- Multiple cursors
map({ "n", "x" }, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })
map({ "n", "x" }, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })
map({ "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })
map({ "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })

-- Window resize (Ctrl + arrows, no plugins)
-- Ctrl+arrow: the current window expands towards that side (takes space from the
-- neighbour there). Ctrl+Shift+arrow: that side retracts (gives space back).
-- Errors are appended to stdpath("state")/winresize.log (copy-friendly) as well as notified.
local function safe_resize(fn_name, d)
  return function()
    local ok, err = xpcall(function()
      require("winresize")[fn_name](d, 2)
    end, debug.traceback)
    if not ok then
      local wins = {}
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local b = vim.api.nvim_win_get_buf(w)
        wins[#wins + 1] = string.format(
          "%d[ft=%s bt=%s rel=%s w=%d h=%d]",
          w,
          vim.bo[b].filetype,
          vim.bo[b].buftype,
          vim.api.nvim_win_get_config(w).relative,
          vim.api.nvim_win_get_width(w),
          vim.api.nvim_win_get_height(w)
        )
      end
      local f = io.open(vim.fn.stdpath "state" .. "/winresize.log", "a")
      if f then
        f:write(os.date "%F %T", " ", fn_name, " ", d, "\n", tostring(err), "\nwindows: ", table.concat(wins, " "), "\n\n")
        f:close()
      end
      vim.notify("winresize error (see " .. vim.fn.stdpath "state" .. "/winresize.log)", vim.log.levels.ERROR)
    end
  end
end

for _, dir in ipairs { "Up", "Down", "Left", "Right" } do
  local d = dir:lower()
  map("n", "<C-" .. dir .. ">", safe_resize("grow", d), { desc = "Expand window " .. d })
  map("n", "<C-S-" .. dir .. ">", safe_resize("shrink", d), { desc = "Shrink window from " .. d })
end

map({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", { desc = "Add or remove cursor" })
map("x", "<Leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", { desc = "Add cursors to the lines of the visual area" })
map({ "n", "x" }, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", { desc = "Add cursors to cword" })
map(
  { "n", "x" },
  "<Leader>A",
  "<Cmd>MultipleCursorsAddMatchesV<CR>",
  { desc = "Add cursors to cword in previous area" }
)
map(
  { "n", "x" },
  "<Leader>d",
  "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
  { desc = "Add cursor and jump to next cword" }
)
map({ "n", "x" }, "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", { desc = "Jump to next cword" })
map({ "n", "x" }, "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", { desc = "Lock virtual cursors" })

-- Opencode AI mappings
map("n", "<leader>ot", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })
map("n", "<leader>oA", function()
  require("opencode").ask()
end, { desc = "Ask opencode" })
map("n", "<leader>oa", function()
  require("opencode").ask "@cursor: "
end, { desc = "Ask opencode about this" })
map("v", "<leader>oa", function()
  require("opencode").ask "@selection: "
end, { desc = "Ask opencode about selection" })
map("n", "<leader>on", function()
  require("opencode").command "session_new"
end, { desc = "New opencode session" })
map("n", "<leader>oy", function()
  require("opencode").command "messages_copy"
end, { desc = "Copy last opencode response" })
map("n", "<S-C-u>", function()
  require("opencode").command "messages_half_page_up"
end, { desc = "Messages half page up" })
map("n", "<S-C-d>", function()
  require("opencode").command "messages_half_page_down"
end, { desc = "Messages half page down" })
map({ "n", "v" }, "<leader>os", function()
  require("opencode").select()
end, { desc = "Select opencode prompt" })
-- Example: keymap for custom prompt
map("n", "<leader>oe", function()
  require("opencode").prompt "Explain @cursor and its context"
end, { desc = "Explain this code" })

-- windsurf
-- Change '<C-g>' here to any keycode you like.
map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
map("i", "<c-;>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })
map("i", "<c-,>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })
map("i", "<c-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
