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
map({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up" })
map({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down" })
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
