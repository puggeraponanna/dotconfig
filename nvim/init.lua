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
        { 'rose-pine/neovim',                 name = 'rose-pine' },
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate' },
        { 'nvim-telescope/telescope.nvim',    tag = '0.1.2' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lualine/lualine.nvim' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/nvim-cmp' },
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'nvim-tree/nvim-web-devicons' },
        { 'windwp/nvim-autopairs',            event = "InsertEnter",         opts = {} },
        { 'christoomey/vim-tmux-navigator' },
        { "nvim-neorg/neorg",                 build = ":Neorg sync-parsers", },
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            dependencies = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            }
        },
        { "lewis6991/gitsigns.nvim" },
        { "numToStr/Comment.nvim" },
        { "puggeraponanna/rest.nvim" }
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

-- Colors
require('rose-pine').setup({
    variant = "auto"
})
vim.cmd.colorscheme('rose-pine')

-- Completion
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- LSP
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end


    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    nmap('<leader>fm', vim.lsp.buf.format, 'Format buffer')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

require("mason").setup({})
require("mason-lspconfig").setup({})

local servers = { 'lua_ls', 'gopls', 'hls', 'tsserver', 'pyright' }

for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        },
    }
end

-- Noice
require("noice").setup({
    lsp = {
        progress = {
            enabled = true,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
})

-- Lualine
require("lualine").setup({
    tabline = {
        lualine_a = { 'buffers' },
    },
})

-- Treesitter
require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "haskell" },
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
    },
}

-- Gitsigns
require("gitsigns").setup()

-- Comment
require('Comment').setup()

-- Rest
require("rest-nvim").setup({
    commit = "3db3eed"
})

-- Other config
vim.o.termguicolors = true

vim.o.ignorecase = true
vim.o.smartcase = true

--vim.o.updatetime = 250
--vim.o.timeoutlen = 300

vim.o.mouse = 'a'
vim.wo.number = true

vim.opt.whichwrap = "<,>,h,l,[,]"

vim.o.hlsearch = false

vim.opt.guicursor = "i:hor20"
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.colorcolumn = "80"

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

vim.keymap.set("n", "<tab>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<S-tab>", ":bp<CR>", { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find files" })
vim.keymap.set('n', '<leader>gt', builtin.git_status, { desc = "git status" })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "find buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help tags" })
