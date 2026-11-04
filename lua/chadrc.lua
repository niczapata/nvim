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
    -- Same as NvChad's default `mode` and `cursor` modules, plus a rounded
    -- cap on the outer edge of the bar (like the tmux status bar).
    modules = {
      mode = function()
        local utils = require "nvchad.stl.utils"
        if not utils.is_activewin() then
          return ""
        end

        local m = utils.modes[vim.api.nvim_get_mode().mode]
        local mode_hl = "St_" .. m[2] .. "Mode"
        local cap_hl = "St_" .. m[2] .. "ModeCapL"
        vim.api.nvim_set_hl(0, cap_hl, { fg = vim.api.nvim_get_hl(0, { name = mode_hl, link = false }).bg })

        return "%#" .. cap_hl .. "#\u{e0b6}" -- left cap
          .. "%#" .. mode_hl .. "#\u{e7c5} " .. m[1]
          .. "%#St_" .. m[2] .. "ModeSep#\u{e0b4}"
          .. "%#ST_EmptySpace#\u{e0b4}"
      end,

      cursor = function()
        vim.api.nvim_set_hl(0, "St_pos_capR", {
          fg = vim.api.nvim_get_hl(0, { name = "St_pos_text", link = false }).bg,
        })
        return "%#St_pos_sep#\u{e0b6}%#St_pos_icon#\u{e612} %#St_pos_text# %l/%v %#St_pos_capR#\u{e0b4}"
      end,
    },
  },
}

return M
