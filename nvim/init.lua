vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
        { 'folke/neodev.nvim' },
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'puggeraponanna/null-ls.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate' },
        { 'nvim-telescope/telescope.nvim',    tag = '0.1.2' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lualine/lualine.nvim' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'windwp/nvim-autopairs',            event = "InsertEnter",         opts = {} },
        { 'nvim-neorg/neorg',                 build = ":Neorg sync-parsers", },
        { 'lewis6991/gitsigns.nvim' },
        { 'puggeraponanna/rest.nvim',         commit = "3db3eed" },
        { 'norcalli/nvim-colorizer.lua' },
        { "rose-pine/neovim",                 name = "rose-pine" },
        { "nvim-tree/nvim-tree.lua",          lazy = false },
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }
        },
    },
    {
        performance = {
            rtp = {
                disabled_plugins = {
                    "2html_plugin",
                    "tohtml",
                    "getscript",
                    "getscriptPlugin",
                    "gzip",
                    "logipat",
                    "netrw",
                    "netrwPlugin",
                    "netrwSettings",
                    "netrwFileHandlers",
                    "matchit",
                    "tar",
                    "tarPlugin",
                    "rrhelper",
                    "spellfile_plugin",
                    "vimball",
                    "vimballPlugin",
                    "zip",
                    "zipPlugin",
                    "tutor",
                    "rplugin",
                    "syntax",
                    "synmenu",
                    "optwin",
                    "compiler",
                    "bugreport",
                    "ftplugin",
                },
            },
        },
    })

-- Colorscheme
require("rose-pine").setup({
    variant = "moon",
})
vim.cmd.colorscheme("rose-pine")

-- Neodev
require('neodev').setup()

-- Completion
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<tab>'] = cmp.mapping.select_next_item(),
        ['<S-tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = "buffer" }
    })
})

-- LSP
local on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local servers = { 'lua_ls', 'gopls', 'hls', 'pyright', 'rust_analyzer', 'texlab' }

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = servers
})

local builtins = require("null-ls").builtins
require("null-ls").setup({
    sources = {
        builtins.formatting.autopep8,
        builtins.formatting.rustfmt,
        builtins.formatting.gofmt,
    }
})

for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    disable = { "missing-fields" }
                }
            }
        },
    }
end

-- Lualine
require("lualine").setup({
    options = {
        section_separators = "",
        component_separators = "|"
    },
})

-- Treesitter
require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "vim", "vimdoc", "query", "go", "haskell", "python", "rust" },
    highlight = { enable = true },
}

-- Neorg
require("neorg").setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/Workspace/notes",
                },
            },
        },
        ["core.ui"] = {},
    },
}

-- Gitsigns
require("gitsigns").setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        map('n', '<leader>gd', gs.diffthis)
    end
}

-- Notify
require("notify").setup({
    background_colour = "#000000"
})

-- Noice
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
})

-- Rest
require("rest-nvim").setup({
    result_split_in_place = true
})

-- Nvim Tree
require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
    }
})

vim.opt.termguicolors = true
require('colorizer').setup()

-- Other config
vim.opt.list = true
vim.opt.listchars = { eol = "\\u23CE", tab = "  " }
vim.opt.fillchars = vim.opt.fillchars + 'diff: '
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.wo.number = true
vim.opt.whichwrap = "<,>,h,l,[,]"
vim.opt.hlsearch = false
vim.opt.guicursor = "i:hor20"
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
-- vim.opt.colorcolumn = '100'

-- Keymaps
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "C-h", vim.cmd.TmuxNavigateLeft)
vim.keymap.set("n", "C-j", vim.cmd.TmuxNavigateDown)
vim.keymap.set("n", "C-k", vim.cmd.TmuxNavigateUp)
vim.keymap.set("n", "C-l", vim.cmd.TmuxNavigateRight)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<A-j>", "ddp")
vim.keymap.set("n", "<A-k>", "ddkP")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<tab>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<S-tab>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim", { silent = true })
vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<cr>", { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fa', "<cmd> Telescope find_files hidden=true <CR>")
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>gt', builtin.git_status)
vim.keymap.set('n', '<leader>fw', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
