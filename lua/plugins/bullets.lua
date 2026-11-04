-- Word/Notepad-style list editing: continue bullets and numbered lists on <CR>/o/O
-- and keep numbering in sync.
return {
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "text", "gitcommit" },
    -- bullets.vim reads g: variables at load time, so they must be set in `init`.
    init = function()
      vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
      vim.g.bullets_enable_in_empty_buffers = 0
      -- <CR> on an empty bullet removes it and ends the list (like Word)
      vim.g.bullets_delete_last_bullet_if_empty = 1
      -- Renumber the list when adding items or changing indent level
      vim.g.bullets_renumber_on_change = 1
      -- Don't auto-indent the next bullet just because the line ends in ":"
      vim.g.bullets_auto_indent_after_colon = 0
      -- Nested levels: 1. -> a. -> i. -> "-" (same as Word's default outline)
      vim.g.bullets_outline_levels = { "num", "abc", "rom", "std-" }
    end,
  },
}
