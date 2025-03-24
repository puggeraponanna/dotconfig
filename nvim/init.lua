require("config.lazy")

local set = vim.opt
set.shiftwidth = 4
set.tabstop = 4
set.clipboard = "unnamedplus"
set.number = true
set.background = "dark"
set.termguicolors = true
set.whichwrap = "<,>,h,l,[,]"
set.mouse = 'a'
set.ignorecase = true
set.smartcase = true
set.completeopt = { "menu", "menuone", "noselect" }
set.scrolloff = 8

local kmap = vim.keymap.set
kmap("i", "jj", "<Esc>")
kmap("n", ";", ":")
kmap("n", "<space><space>x", "<cmd>source %<CR>")
kmap("n", "<space>x", ":.lua<CR>")
kmap("v", "<space>x", ":lua<CR>")
kmap("n", "<tab>", ":bn<CR>", { silent = true })
kmap("n", "<S-tab>", ":bp<CR>", { silent = true })
