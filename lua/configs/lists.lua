-- Shared list/prose settings for markdown and plain-text buffers.
-- Called from after/ftplugin/{markdown,text}.lua so it runs after the
-- built-in ftplugins (which would otherwise overwrite these options).
local M = {}

function M.setup(bufnr)
  local opt = vim.opt_local

  -- Only the blockquote marker is treated as a "comment"; bullets are
  -- handled by bullets.vim so they are not duplicated by 'formatoptions'.
  opt.comments = "fb:*,fb:-,fb:+,n:>"
  -- r: continue "> " on <CR>   n: recognise lists when formatting (gq)
  -- q: allow gq             l: don't break lines that were already long
  -- j: remove leader when joining lines   (no t/c/o: no hard auto-wrap)
  opt.formatoptions = "rnqlj"
  -- Lines matching this are list items: "- ", "* ", "+ ", "1. ", "1) "
  opt.formatlistpat = [[^\s*\%(\d\+[.)]\|[-*+]\)\s\+]]
  opt.autoindent = true
  opt.textwidth = 0

  -- Keep numbering correct after deleting items with dd
  vim.keymap.set("n", "dd", function()
    vim.cmd('normal! "' .. vim.v.register .. vim.v.count1 .. "dd")
    pcall(vim.cmd, "silent! RenumberList")
  end, { buffer = bufnr, desc = "Delete line and renumber list" })
end

return M
