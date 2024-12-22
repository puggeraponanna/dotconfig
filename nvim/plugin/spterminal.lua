vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

local state = {
  spterm = {
    buf = -1,
    win = -1
  }
}

local function my_sp_term(opts)
  -- Get the current window dimensions
  local total_lines = vim.o.lines
  local total_cols = vim.o.columns

  -- Calculate the height and position of the split (20% from the bottom)
  local split_height = math.floor(total_lines * 0.2)
  local row_position = total_lines - split_height

  -- Create a new buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = state.spterm.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end
  -- Configure window options
  local win_opts = {
    relative = "editor",
    width = total_cols,
    height = split_height,
    row = row_position,
    col = 0,
    style = "minimal",
    border = { "", "-", "", "", "", "", "", "" },
  }

  -- Open the window
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_win_set_option(win, "winhighlight", "Normal:MyHighlight,FloatBorder:MyHighlight")

  -- Return the buffer and window handle
  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if vim.api.nvim_win_is_valid(state.spterm.win) then
    vim.api.nvim_win_hide(state.spterm.win)
  else
    state.spterm = my_sp_term({ buf = state.spterm.buf })
    if vim.bo[state.spterm.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end
    vim.fn.feedkeys('a')
  end
end

vim.api.nvim_create_user_command(
  'MySpTerm',
  toggle_terminal,
  {}
)
vim.keymap.set("n", "<space>tt", "<cmd>MySpTerm<cr>")
