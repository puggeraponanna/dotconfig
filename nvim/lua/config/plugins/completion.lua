return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = 'v0.*',
    opts = {
      keymap = {
        preset = 'default',
        ['C-y'] = {},
        ['<tab>'] = { 'accept', 'fallback' },
        ['<esc>'] = { 'hide', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true }
    },
  }
}
