return {
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        notification = {
          window = {
            winblend = 0,
          },
        }
      })
    end
  }
}
