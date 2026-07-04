return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = function()
    require('rose-pine').setup({
      variant = 'auto', -- auto, main, moon, or dawn
      dark_variant = 'main', -- main, moon, or dawn
      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },
    })
    vim.cmd('colorscheme rose-pine')
  end
}
