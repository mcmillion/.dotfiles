vim.api.nvim_create_user_command('CommentHeader', function(opts)
  local text = string.upper(opts.args)
  local padding = ' '
  local padded_text = padding .. text .. padding
  local border_length = #padded_text
  local border = string.rep('-', border_length)
  
  -- Get comment string for current filetype
  local commentstring = vim.bo.commentstring
  local comment_char = commentstring:match('^(.-)%s*%%s') or '//'
  
  local header = {
    comment_char .. border,
    comment_char .. padded_text,
    comment_char .. border
  }
  
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, header)
end, {
  nargs = 1,
  desc = 'Create a comment header with dashes border'
})