require "nvchad.options"

-- add yours here!

local o = vim.o
o.clipboard = "unnamedplus"
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
o.wrap = true
o.linebreak = true
o.number = true
o.breakindent = true
o.showbreak = "↪ "
-- vim.o returns plain strings; use vim.opt for list-style options.
-- Note: filetype plugins override formatoptions per buffer (see after/ftplugin/).
vim.opt.formatoptions:append "ron"
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Treat plain .txt files as Markdown (highlighting + list behaviour)
vim.filetype.add { extension = { txt = "markdown" } }
