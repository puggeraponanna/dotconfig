return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = 'v0.*',
    opts = {
      keymap = {
        preset = 'default',
        ['C-y'] = {},
        ['<CR>'] = { 'accept', 'fallback' },
        ['<esc>'] = { 'hide', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true },
      completion = {
        list = {
          selection = { auto_insert = false, preselect = false },
        },
      },
    },
  }
}
