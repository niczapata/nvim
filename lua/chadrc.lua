-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ayu_light",
  transparency = true,
  hl_override = {
    -- Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["@operator"] = { fg = "orange" },
  },
  changed_themes = {
    ayu_light = {
      base_16 = {
        base05 = "#e06c75",
        base02 = "#e1e1e1",
        base08 = "#eba400",
      },
    },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    enable = true,
    order = { "buffers", "tabs" },
    lazyload = false,
  },
  statusline = {
    overriden_modules = nil,
    separator_style = "round",
  },
}

return M
