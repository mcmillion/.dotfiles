vim.api.nvim_create_user_command("CommentHeader", function(opts)
  local text = string.upper(opts.args)
  local padding = " "
  local padded_text = padding .. text .. padding
  local border_length = #padded_text
  local border = string.rep("-", border_length)

  -- Get comment string for current filetype
  local commentstring = vim.bo.commentstring
  local comment_char = commentstring:match("^(.-)%s*%%s") or "//"

  local header = {
    comment_char .. border,
    comment_char .. padded_text,
    comment_char .. border,
  }

  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, header)
end, {
  nargs = 1,
  desc = "Create a comment header with dashes border",
})

-- Run Godot GUT tests in a tmux popup. Uses the current working directory
-- as the Godot project path and runs tests from all directories in test_dirs array.
-- Each directory gets its own -gdir argument in the Godot command.
vim.api.nvim_create_user_command("GutTest", function()
  local cwd = vim.fn.getcwd()
  local godot_path = "/Applications/Godot.app/Contents/MacOS/Godot"
  local test_dirs = {
    "res://test/unit/",
    "res://test/integration/",
  }

  local gdir_args = ""
  for _, dir in ipairs(test_dirs) do
    gdir_args = gdir_args .. " -gdir " .. dir
  end

  local cmd = string.format("%s -d --path %s -s res://addons/gut/gut_cmdln.gd%s -gexit", godot_path, cwd, gdir_args)

  local tmux_cmd = string.format("tmux display-popup -w 80%% -h 80%% -E '%s; $SHELL'", cmd)

  vim.fn.system(tmux_cmd)
end, {
  desc = "Run GUT tests in tmux popup (80% x 80%)",
})
