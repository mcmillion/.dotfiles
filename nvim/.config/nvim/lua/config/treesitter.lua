require'nvim-treesitter.configs'.setup({
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'cpp',
    'css',
    'go',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'regex',
    'ruby',
    'tsx',
    'typescript'
  },
  highlight = {
    enable = true,
  },
})
