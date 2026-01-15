-- Neovim colorscheme (Catppuccin-style organization)
local flavors = {
  colorme = {
    base = "#282828",
    text = "#ebdbb2",
    surface0 = "#504945",
    overlay0 = "#928374",
    blue = "#458588",
    magenta = "#b16286",
    cyan = "#689d6a",
    green = "#98971a",
    yellow = "#d79921",
    red = "#cc241d",
    maroon = "#fb4934",
    teal = "#8ec07c",
    sky = "#83a598",
    pink = "#d3869b",
  }
}

local cp = flavors["colorme"]

-- Transparency toggle (default to false, but easy to change)
local transparent = false
local bg = transparent and "NONE" or cp.base

vim.cmd("highlight clear")
vim.o.termguicolors = true
vim.g.colors_name = "colorme"

local groups = {
  -- Base highlights
  Normal = { fg = cp.text, bg = bg },
  NormalNC = { fg = cp.text, bg = bg },
  SignColumn = { bg = bg },
  MsgArea = { fg = cp.text, bg = bg },
  EndOfBuffer = { fg = bg }, -- Hide the ~ symbols
  
  CursorLine = { bg = cp.surface0 },
  Visual = { bg = cp.surface0, bold = true },
  Search = { fg = cp.base, bg = cp.yellow },
  IncSearch = { fg = cp.base, bg = cp.pink },
  
  -- Syntax
  Comment = { fg = cp.overlay0, italic = true },
  Constant = { fg = cp.pink },
  String = { fg = cp.green },
  Identifier = { fg = cp.sky },
  Function = { fg = cp.blue },
  Statement = { fg = cp.magenta },
  PreProc = { fg = cp.pink },
  Type = { fg = cp.yellow },
  Special = { fg = cp.pink },
  Error = { fg = cp.red, bold = true },
  Todo = { fg = cp.base, bg = cp.yellow, bold = true },

  -- UI
  Pmenu = { fg = cp.text, bg = cp.surface0 },
  PmenuSel = { fg = cp.text, bg = cp.overlay0, bold = true },
  LineNr = { fg = cp.overlay0 },
  CursorLineNr = { fg = cp.blue, bold = true },
  VertSplit = { fg = cp.surface0 },
  StatusLine = { fg = cp.text, bg = cp.surface0 },
  StatusLineNC = { fg = cp.overlay0, bg = cp.surface0 },

  -- Cursor & Mode
  Cursor = { fg = cp.base, bg = cp.text },
  TermCursor = { fg = cp.base, bg = cp.text },
  ModeMsg = { fg = cp.text, bold = true },

  -- Lualine (ensure dark text on colored backgrounds)
  lualine_a_normal = { fg = cp.base, bg = cp.blue, bold = true },
  lualine_a_insert = { fg = cp.base, bg = cp.green, bold = true },
  lualine_a_visual = { fg = cp.base, bg = cp.magenta, bold = true },
  lualine_a_replace = { fg = cp.base, bg = cp.red, bold = true },
  lualine_a_command = { fg = cp.base, bg = cp.yellow, bold = true },

  -- Lualine CamelCase variants
  LualineANormal = { fg = cp.base, bg = cp.blue, bold = true },
  LualineAInsert = { fg = cp.base, bg = cp.green, bold = true },
  LualineAVisual = { fg = cp.base, bg = cp.magenta, bold = true },
  LualineAReplace = { fg = cp.base, bg = cp.red, bold = true },
  LualineACommand = { fg = cp.base, bg = cp.yellow, bold = true },

  -- Diff groups (used by Lualine 'auto' theme for mode indicators)
  DiffAdd = { fg = cp.base, bg = cp.green },
  DiffChange = { fg = cp.base, bg = cp.yellow },
  DiffDelete = { fg = cp.base, bg = cp.red },
  DiffText = { fg = cp.base, bg = cp.blue },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end

-- Explicit Lualine theme table
local lualine_theme = {
  normal = {
    a = { fg = cp.base, bg = cp.blue, gui = "bold" },
    b = { fg = cp.text, bg = cp.surface0 },
    c = { fg = cp.text, bg = cp.base },
  },
  insert = {
    a = { fg = cp.base, bg = cp.green, gui = "bold" },
    b = { fg = cp.text, bg = cp.surface0 },
    c = { fg = cp.text, bg = cp.base },
  },
  visual = {
    a = { fg = cp.base, bg = cp.magenta, gui = "bold" },
    b = { fg = cp.text, bg = cp.surface0 },
    c = { fg = cp.text, bg = cp.base },
  },
  replace = {
    a = { fg = cp.base, bg = cp.red, gui = "bold" },
    b = { fg = cp.text, bg = cp.surface0 },
    c = { fg = cp.text, bg = cp.base },
  },
  command = {
    a = { fg = cp.base, bg = cp.yellow, gui = "bold" },
    b = { fg = cp.text, bg = cp.surface0 },
    c = { fg = cp.text, bg = cp.base },
  },
  inactive = {
    a = { fg = cp.overlay0, bg = cp.base },
    b = { fg = cp.overlay0, bg = cp.base },
    c = { fg = cp.overlay0, bg = cp.base },
  },
}

-- Return the theme table so it can be used in lualine config
return {
  colors = cp,
  lualine_theme = lualine_theme,
}
