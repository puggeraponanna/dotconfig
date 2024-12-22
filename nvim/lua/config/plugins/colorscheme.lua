-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   config = function()
--     vim.cmd("colorscheme rose-pine")
--   end
-- }
--
-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     config = function()
--       vim.cmd.colorscheme("gruvbox")
--     end
--   }
-- }
--
return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.cmd.colorscheme('gruvbox-material')
  end
}
