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


return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }
    },
    config = function()
      local lsp_servers = {
        "bashls",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "pyright",
        "hls",
        "zls"
      }

      for _, server in ipairs(lsp_servers) do
        vim.lsp.enable(server)
      end

      vim.lsp.config("*", {
        on_attach = on_attach,
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormattingGroup', { clear = true }),
        callback = function(args)
          vim.lsp.buf.format({ bufnr = args.buf, async = false })
        end,
      })
    end
  }
}
