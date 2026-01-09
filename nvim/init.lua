vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local set = vim.opt
set.shiftwidth = 4
set.tabstop = 4
set.clipboard = "unnamedplus"
set.number = true
set.termguicolors = true
set.whichwrap = "<,>,h,l,[,]"
set.mouse = 'a'
set.ignorecase = true
set.smartcase = true
set.completeopt = { "menu", "menuone", "noselect" }
set.scrolloff = 8
set.background = "dark"

require("config.lazy")

local kmap = vim.keymap.set
kmap("i", "jj", "<Esc>")
kmap("n", ";", ":")
kmap("n", "<space><space>x", "<cmd>source %<CR>")
kmap("n", "<space>x", ":.lua<CR>")
kmap("v", "<space>x", ":lua<CR>")
kmap("n", "<tab>", ":bn<CR>", { silent = true })
kmap("n", "<S-tab>", ":bp<CR>", { silent = true })
kmap("n", "<leader>q", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  if qf_winid > 0 then
    vim.cmd("cclose")
  else
    vim.diagnostic.setqflist()
    vim.cmd("copen")
  end
end)
kmap("n", "<leader>nt", ":NvimTreeToggle<CR>")
