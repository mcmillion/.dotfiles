require('Comment').setup({
  pre_hook = function(ctx)
    return require('Comment.jsx').calculate(ctx)
  end,
})
