vim.g.UltiSnipsExpandTrigger = "<TAB>"
vim.g.UltiSnipsJumpForwardTrigger = "<TAB>"
vim.g.UltiSnipsEditSplit = "vertical"

-- Automatically reload snippets when edited
vim.cmd([[ autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets ]])
