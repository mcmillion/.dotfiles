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

local godot_path = "/Applications/Godot.app/Contents/MacOS/Godot"

-- Run the GUT test suite in a tmux popup. The test dirs, prefixes, and exit
-- behavior come from res://.gutconfig.json so this stays in sync with the
-- project's `make test`; no directories are hardcoded here.
vim.api.nvim_create_user_command("GutTest", function()
  local cwd = vim.fn.getcwd()
  local cmd = string.format("%s -d --headless --path %s -s res://addons/gut/gut_cmdln.gd -gexit", godot_path, cwd)
  local tmux_cmd = string.format("tmux display-popup -w 80%% -h 80%% -E '%s; $SHELL'", cmd)
  vim.fn.system(tmux_cmd)
end, {
  desc = "Run GUT tests in tmux popup (reads .gutconfig.json)",
})

-- Run the current GUT test file in headed mode (Godot GUI visible), so you can
-- watch a single scene-tree test. Only runs the file in the current buffer.
vim.api.nvim_create_user_command("GutTestHeaded", function()
  local cwd = vim.fn.getcwd()
  local current_file = vim.fn.expand("%")

  if not current_file:match("%.gd$") then
    vim.notify("GutTestHeaded: current file is not GDScript", vim.log.levels.WARN)
    return
  end

  local res_path = "res://" .. current_file
  local cmd = string.format("%s --path %s -s res://addons/gut/gut_cmdln.gd -gtest=%s -gexit", godot_path, cwd, res_path)
  local tmux_cmd = string.format("tmux display-popup -w 80%% -h 80%% -E '%s; $SHELL'", cmd)
  vim.fn.system(tmux_cmd)
end, {
  desc = "Run current GUT test file in headed mode",
})
