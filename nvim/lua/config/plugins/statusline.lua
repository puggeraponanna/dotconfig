return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local onedark = require('lualine.themes.onedark')
      -- Match Ghostty's exact Atom One Dark background (#21252a)
      local bg = '#21252a'
      for _, mode in ipairs({ 'normal', 'insert', 'visual', 'replace', 'command', 'inactive' }) do
        if onedark[mode] and onedark[mode].c then
          onedark[mode].c.bg = bg
        end
      end

      require('lualine').setup {
        options = {
          theme = onedark,
          section_separators = { left = '', right = '' },
          component_separators = { left = '|', right = '|' },
          globalstatus = true,
        }
      }
    end
  }
}
