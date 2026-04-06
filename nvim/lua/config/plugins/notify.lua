return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#21252a",
      })
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
