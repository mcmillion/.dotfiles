set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='onedark'

hi @annotation                     guifg=#e5c07b guibg=NONE    gui=NONE
hi @attribute                      guifg=#56b6c2 guibg=NONE    gui=NONE
hi @boolean                        guifg=#d19a66 guibg=NONE    gui=NONE
hi @character                      guifg=#98c379 guibg=NONE    gui=NONE
hi @conditional                    guifg=#c678dd guibg=NONE    gui=NONE
hi @constant                       guifg=#61afef guibg=NONE    gui=NONE
hi @constant.builtin               guifg=#d19a66 guibg=NONE    gui=NONE
hi @constant.macro                 guifg=#56b6c2 guibg=NONE    gui=NONE
hi @constructor                    guifg=#56b6c2 guibg=NONE    gui=NONE
hi @emphasis                       guifg=NONE    guibg=NONE    gui=NONE
hi @error                          guifg=#f44747 guibg=NONE    gui=NONE
hi @exception                      guifg=#c678dd guibg=NONE    gui=NONE
hi @field                          guifg=#e06c75 guibg=NONE    gui=NONE
hi @float                          guifg=#98c379 guibg=NONE    gui=NONE
hi @function                       guifg=#61afef guibg=NONE    gui=NONE
hi @function.builtin               guifg=#61afef guibg=NONE    gui=NONE
hi @function.macro                 guifg=#e5c07b guibg=NONE    gui=NONE
hi @include                        guifg=#c678dd guibg=NONE    gui=NONE
hi @keyword                        guifg=#c678dd guibg=NONE    gui=NONE
hi @keyword.function               guifg=#c678dd guibg=NONE    gui=NONE
hi @keyword.operator               guifg=#c678dd guibg=NONE    gui=NONE
hi @label                          guifg=#61afef guibg=NONE    gui=NONE
hi @literal                        guifg=#ffff00 guibg=NONE    gui=NONE
hi @method                         guifg=#61afef guibg=NONE    gui=NONE
hi @namespace                      guifg=#56b6c2 guibg=NONE    gui=NONE
hi @number                         guifg=#d19a66 guibg=NONE    gui=NONE
hi @operator                       guifg=#abb2bf guibg=NONE    gui=NONE
hi @parameter                      guifg=#56b6c2 guibg=NONE    gui=NONE
hi @parameter.reference            guifg=#56b6c2 guibg=NONE    gui=NONE
hi @property                       guifg=#e5c07b guibg=NONE    gui=NONE
hi @punctuation.bracket            guifg=#abb2bf guibg=NONE    gui=NONE
hi @punctuation.delimiter          guifg=#abb2bf guibg=NONE    gui=NONE
hi @punctuation.special            guifg=#abb2bf guibg=NONE    gui=NONE
hi @repeat                         guifg=#c678dd guibg=NONE    gui=NONE
hi @string                         guifg=#98c379 guibg=NONE    gui=NONE
hi @string.escape                  guifg=#56b6c2 guibg=NONE    gui=NONE
hi @string.regex                   guifg=#98c379 guibg=NONE    gui=NONE
hi @strong                         guifg=NONE    guibg=NONE    gui=NONE
hi @structure                      guifg=#e5c07b guibg=NONE    gui=NONE
hi @tag                            guifg=#e06c75 guibg=NONE    gui=NONE
hi @tag.attribute                  guifg=#e5c07b guibg=NONE    gui=NONE
hi @tag.delimiter                  guifg=#5c6370 guibg=NONE    gui=NONE
hi @text                           guifg=#abb2bf guibg=NONE    gui=bold
hi @title                          guifg=#ffff00 guibg=NONE    gui=NONE
hi @type                           guifg=#61afef guibg=NONE    gui=NONE
hi @type.builtin                   guifg=#61afef guibg=NONE    gui=NONE
hi @underline                      guifg=NONE    guibg=NONE    gui=NONE
hi @uri                            guifg=#ffff00 guibg=NONE    gui=NONE
hi @variable                       guifg=#56b6c2 guibg=NONE    gui=NONE
hi @variable.builtin               guifg=#e5c07b guibg=NONE    gui=NONE
hi Boolean                         guifg=#61afef guibg=NONE    gui=NONE
hi Character                       guifg=#98c379 guibg=NONE    gui=NONE
hi CocExplorerBufferFullPath       guifg=#5c6370 guibg=NONE    gui=NONE
hi CocExplorerBufferModified       guifg=#c678dd guibg=NONE    gui=NONE
hi CocExplorerBufferNameVisible    guifg=#98c379 guibg=NONE    gui=NONE
hi CocExplorerBufferReadonly       guifg=#c678dd guibg=NONE    gui=NONE
hi CocExplorerBufferRoot           guifg=#56b6c2 guibg=NONE    gui=NONE
hi CocExplorerFileFullPath         guifg=#5c6370 guibg=NONE    gui=NONE
hi CocExplorerFileHidden           guifg=#5c6370 guibg=NONE    gui=NONE
hi CocExplorerFileModified         guifg=#c678dd guibg=NONE    gui=NONE
hi CocExplorerFileReadonly         guifg=#c678dd guibg=NONE    gui=NONE
hi CocExplorerFileRoot             guifg=#56b6c2 guibg=NONE    gui=NONE
hi CocExplorerHelpLine             guifg=#c678dd guibg=NONE    gui=NONE
hi CocExplorerIndentLine           guifg=#5c6370 guibg=NONE    gui=NONE
hi ColorColumn                     guifg=NONE    guibg=#2c323c gui=NONE
hi Comment                         guifg=#6c727e guibg=NONE    gui=italic
hi Conceal                         guifg=#5c6370 guibg=NONE    gui=NONE
hi Conditional                     guifg=#c678dd guibg=NONE    gui=NONE
hi Constant                        guifg=#e5c07b guibg=NONE    gui=NONE
hi Cursor                          guifg=NONE    guibg=NONE    gui=reverse
hi CursorColumn                    guifg=NONE    guibg=#2c323c gui=NONE
hi CursorLine                      guifg=NONE    guibg=#2c323d gui=NONE
hi CursorLineNr                    guifg=#858b96 guibg=#2c323d gui=NONE
hi Define                          guifg=#c678dd guibg=NONE    gui=NONE
hi DiagnosticError                 guifg=#f44747 guibg=NONE    gui=NONE
hi DiagnosticHint                  guifg=#6c727e guibg=NONE    gui=NONE
hi DiagnosticUnderlineError        gui=undercurl guisp=#f44747
hi DiagnosticUnderlineHint         gui=undercurl guisp=#6c727e
hi DiagnosticUnderlineInfo         gui=undercurl guisp=#6c727e
hi DiagnosticUnderlineWarn         gui=undercurl guisp=#e5c07b
hi DiagnosticWarn                  guifg=#e5c07b guibg=NONE    gui=NONE
hi DiagnsoticInfo                  guifg=#6c727e guibg=NONE    gui=NONE
hi DiffAdd                         guifg=#282c34 guibg=#98c379 gui=NONE
hi DiffChange                      guifg=#e5c07b guibg=NONE    gui=underline
hi DiffDelete                      guifg=#282c34 guibg=#e06c75 gui=NONE
hi DiffText                        guifg=#282c34 guibg=#e5c07b gui=NONE
hi Directory                       guifg=#61afef guibg=NONE    gui=NONE
hi EasyMotionShade                 guifg=NONE    guibg=NONE    gui=NONE
hi EasyMotionTarget                guifg=#f44747 guibg=NONE    gui=bold
hi EasyMotionTarget2First          guifg=#f44747 guibg=NONE    gui=bold
hi EasyMotionTarget2Second         guifg=#f44747 guibg=NONE    gui=bold
hi EndOfBuffer                     guifg=#282c34 guibg=NONE    gui=NONE
hi Error                           guifg=#f44747 guibg=NONE    gui=bold,reverse
hi ErrorMsg                        guifg=#f44747 guibg=NONE    gui=NONE
hi Exception                       guifg=#c678dd guibg=NONE    gui=NONE
hi Float                           guifg=#d19a66 guibg=NONE    gui=NONE
hi FloatBorder                     guifg=#363945 guibg=#222529 gui=NONE
hi FoldColumn                      guifg=NONE    guibg=NONE    gui=NONE
hi Folded                          guifg=#5c6370 guibg=NONE    gui=NONE
hi Function                        guifg=#e5c07b guibg=NONE    gui=NONE
hi GitSignsAdd                     guifg=#98c379 guibg=#282c34
hi GitSignsChange                  guifg=#e5c07b guibg=#282c34
hi GitSignsDelete                  guifg=#e06c75 guibg=#282c34
hi Identifier                      guifg=#61afef guibg=NONE    gui=NONE
hi IncSearch                       guifg=#e5c07b guibg=#5c6370 gui=NONE
hi Include                         guifg=#c678dd guibg=NONE    gui=NONE
hi Keyword                         guifg=#61afef guibg=NONE    gui=NONE
hi Label                           guifg=#61afef guibg=NONE    gui=NONE
hi LineNr                          guifg=#4b5263 guibg=NONE    gui=NONE
hi Macro                           guifg=#c678dd guibg=NONE    gui=NONE
hi MatchParen                      guifg=NONE    guibg=#313e55 gui=NONE
hi MsgArea                         guifg=#abb2bf guibg=NONE    gui=NONE
hi NonText                         guifg=#3b4048 guibg=NONE    gui=NONE
hi Normal                          guifg=#abb2bf guibg=#282c34 gui=NONE
hi NormalFloat                     guifg=NONE    guibg=#222529 gui=NONE
hi Number                          guifg=#d19a66 guibg=NONE    gui=NONE
hi Operator                        guifg=#c678dd guibg=NONE    gui=NONE
hi Pmenu                           guifg=#abb2bf guibg=#222529 gui=NONE
hi PmenuSbar                       guifg=NONE    guibg=#222529 gui=NONE
hi PmenuSel                        guifg=#abb2bf guibg=#2c323d gui=NONE
hi PmenuThumb                      guifg=NONE    guibg=#2c323d gui=NONE
hi PreCondit                       guifg=#61afef guibg=NONE    gui=NONE
hi PreProc                         guifg=#e5c07b guibg=NONE    gui=NONE
hi Question                        guifg=#c678dd guibg=NONE    gui=NONE
hi QuickFixLine                    guifg=#282c34 guibg=#e5c07b gui=NONE
hi Repeat                          guifg=#c678dd guibg=NONE    gui=NONE
hi Scope                           guifg=#5c6370 guibg=NONE    gui=NONE
hi Search                          guifg=#282c34 guibg=#e5c07b gui=NONE
hi SignColumn                      guifg=NONE    guibg=#282c34 gui=NONE
hi Special                         guifg=#61afef guibg=NONE    gui=italic
hi SpecialComment                  guifg=#5c6370 guibg=NONE    gui=italic
hi SpecialKey                      guifg=#3b4048 guibg=NONE    gui=NONE
hi SpellBad                        guifg=#f44747 guibg=NONE    gui=underline
hi SpellCap                        guifg=#e5c07b guibg=NONE    gui=NONE
hi SpellLocal                      guifg=#e5c07b guibg=NONE    gui=NONE
hi SpellRare                       guifg=#e5c07b guibg=NONE    gui=NONE
hi StartifyBracket                 guifg=#61afef guibg=NONE    gui=NONE
hi StartifyFile                    guifg=#e06c75 guibg=NONE    gui=NONE
hi StartifyFooter                  guifg=#98c379 guibg=NONE    gui=NONE
hi StartifyHeader                  guifg=#98c379 guibg=NONE    gui=NONE
hi StartifyNumber                  guifg=#d19a66 guibg=NONE    gui=NONE
hi StartifyPath                    guifg=#61afef guibg=NONE    gui=NONE
hi StartifySection                 guifg=#c678dd guibg=NONE    gui=NONE
hi StartifySelect                  guifg=#98c379 guibg=NONE    gui=NONE
hi StartifySlash                   guifg=#61afef guibg=NONE    gui=NONE
hi StartifySpecial                 guifg=#56b6c2 guibg=NONE    gui=NONE
hi StartifyVar                     guifg=#61afef guibg=NONE    gui=NONE
hi Statement                       guifg=#c678dd guibg=NONE    gui=NONE
hi StatusLine                      guifg=#abb2bf guibg=#2c323c gui=NONE
hi StatusLineNC                    guifg=#5c6370 guibg=NONE    gui=NONE
hi StatusLineTerm                  guifg=#abb2bf guibg=#2c323c gui=NONE
hi StatusLineTermNC                guifg=#2c323c guibg=NONE    gui=NONE
hi StorageClass                    guifg=#61afef guibg=NONE    gui=NONE
hi String                          guifg=#98c379 guibg=NONE    gui=NONE
hi Structure                       guifg=#e5c07b guibg=NONE    gui=NONE
hi TabLine                         guifg=#5c6370 guibg=#2d323d gui=NONE
hi TabLineFill                     guifg=#5c6370 guibg=#2d323d gui=NONE
hi TabLineSel                      guifg=#abb2bf guibg=#3f4452 gui=NONE
hi Terminal                        guifg=#abb2bf guibg=#282c34 gui=NONE
hi Title                           guifg=#abb2bf guibg=NONE    gui=NONE
hi Todo                            guifg=#abb2bf guibg=NONE    gui=bold,italic
hi Type                            guifg=#61afef guibg=NONE    gui=NONE
hi Typedef                         guifg=#e5c07b guibg=NONE    gui=NONE
hi UltestBorder                    guifg=#f44747 guibg=NONE    gui=NONE
hi UltestFail                      guifg=#f44747 guibg=NONE    gui=NONE
hi UltestPass                      guifg=#98c379 guibg=NONE    gui=NONE
hi UltestRunning                   guifg=#e5c07b guibg=NONE    gui=NONE
hi UltestSummaryInfo               guifg=#5c6370 guibg=NONE    gui=bold
hi Underlined                      guifg=#56b6c2 guibg=NONE    gui=underline
hi VertSplit                       guifg=#2d323b guibg=NONE    gui=NONE
hi VimwikiHR                       guifg=#e5c07b guibg=NONE    gui=NONE
hi VimwikiHeader1                  guifg=#d19a66 guibg=NONE    gui=bold
hi VimwikiHeader2                  guifg=#98c379 guibg=NONE    gui=bold
hi VimwikiHeader3                  guifg=#61afef guibg=NONE    gui=bold
hi VimwikiHeader4                  guifg=#56b6c2 guibg=NONE    gui=bold
hi VimwikiHeader5                  guifg=#e5c07b guibg=NONE    gui=bold
hi VimwikiHeader6                  guifg=#c586c0 guibg=NONE    gui=bold
hi VimwikiHeaderChar               guifg=#5c6370 guibg=NONE    gui=NONE
hi VimwikiLink                     guifg=#56b6c2 guibg=NONE    gui=NONE
hi VimwikiList                     guifg=#d19a66 guibg=NONE    gui=NONE
hi VimwikiMarkers                  guifg=#5c6370 guibg=NONE    gui=NONE
hi VimwikiTag                      guifg=#d19a66 guibg=NONE    gui=NONE
hi Visual                          guifg=NONE    guibg=#3e4452 gui=NONE
hi VisualNOS                       guifg=#3e4452 guibg=NONE    gui=NONE
hi WarningMsg                      guifg=#e5c07b guibg=NONE    gui=NONE
hi WhichKey                        guifg=#c678dd guibg=NONE    gui=NONE
hi WhichKeyDesc                    guifg=#61afef guibg=NONE    gui=NONE
hi WhichKeyGroup                   guifg=#61afef guibg=NONE    gui=NONE
hi WhichKeySeperator               guifg=#98c379 guibg=NONE    gui=NONE
hi WildMenu                        guifg=#282c34 guibg=#61afef gui=NONE
hi debugBreakpoint                 guifg=#e06c75 guibg=NONE    gui=reverse
hi debugPc                         guifg=NONE    guibg=#56b6c2 gui=NONE
hi diffAdded                       guifg=#98c379 guibg=NONE    gui=NONE
hi diffFile                        guifg=#3b4048 guibg=NONE    gui=NONE
hi diffFileId                      guifg=#61afef guibg=NONE    gui=bold,reverse
hi diffNewFile                     guifg=#98c379 guibg=NONE    gui=NONE
hi diffOldFile                     guifg=#e06c75 guibg=NONE    gui=NONE
hi diffRemoved                     guifg=#e06c75 guibg=NONE    gui=NONE
hi htmlArg                         guifg=#e5c07b guibg=NONE    gui=NONE
hi htmlBold                        guifg=#e5c07b guibg=NONE    gui=bold
hi htmlEndTag                      guifg=#abb2bf guibg=NONE    gui=NONE
hi htmlH1                          guifg=#61afef guibg=NONE    gui=NONE
hi htmlH2                          guifg=#61afef guibg=NONE    gui=NONE
hi htmlH3                          guifg=#61afef guibg=NONE    gui=NONE
hi htmlH4                          guifg=#61afef guibg=NONE    gui=NONE
hi htmlH5                          guifg=#61afef guibg=NONE    gui=NONE
hi htmlH6                          guifg=#61afef guibg=NONE    gui=NONE
hi htmlItalic                      guifg=#c678dd guibg=NONE    gui=italic
hi htmlLink                        guifg=#56b6c2 guibg=NONE    gui=underline
hi htmlSpecialChar                 guifg=#e5c07b guibg=NONE    gui=NONE
hi htmlSpecialTagName              guifg=#61afef guibg=NONE    gui=NONE
hi htmlTag                         guifg=#abb2bf guibg=NONE    gui=NONE
hi htmlTagN                        guifg=#61afef guibg=NONE    gui=NONE
hi htmlTagName                     guifg=#61afef guibg=NONE    gui=NONE
hi htmlTitle                       guifg=#abb2bf guibg=NONE    gui=NONE
hi markdownBlockquote              guifg=#5c6370 guibg=NONE    gui=NONE
hi markdownBold                    guifg=#e5c07b guibg=NONE    gui=bold
hi markdownCode                    guifg=#98c379 guibg=NONE    gui=NONE
hi markdownCodeBlock               guifg=#98c379 guibg=NONE    gui=NONE
hi markdownCodeDelimiter           guifg=#98c379 guibg=NONE    gui=NONE
hi markdownH1                      guifg=#61afef guibg=NONE    gui=NONE
hi markdownH2                      guifg=#61afef guibg=NONE    gui=NONE
hi markdownH3                      guifg=#61afef guibg=NONE    gui=NONE
hi markdownH4                      guifg=#61afef guibg=NONE    gui=NONE
hi markdownH5                      guifg=#61afef guibg=NONE    gui=NONE
hi markdownH6                      guifg=#61afef guibg=NONE    gui=NONE
hi markdownHeadingDelimiter        guifg=#e06c75 guibg=NONE    gui=NONE
hi markdownHeadingRule             guifg=#5c6370 guibg=NONE    gui=NONE
hi markdownId                      guifg=#c678dd guibg=NONE    gui=NONE
hi markdownIdDeclaration           guifg=#61afef guibg=NONE    gui=NONE
hi markdownIdDelimiter             guifg=#c678dd guibg=NONE    gui=NONE
hi markdownItalic                  guifg=#c678dd guibg=NONE    gui=italic
hi markdownLinkDelimiter           guifg=#c678dd guibg=NONE    gui=NONE
hi markdownLinkText                guifg=#61afef guibg=NONE    gui=NONE
hi markdownListMarker              guifg=#e06c75 guibg=NONE    gui=NONE
hi markdownOrderedListMarker       guifg=#e06c75 guibg=NONE    gui=NONE
hi markdownRule                    guifg=#5c6370 guibg=NONE    gui=NONE
hi markdownUrl                     guifg=#56b6c2 guibg=NONE    gui=underline

hi link @lsp.type.namespace      @namespace
hi link @lsp.type.type           @type
hi link @lsp.type.class          @type
hi link @lsp.type.enum           @type
hi link @lsp.type.interface      @type
hi link @lsp.type.struct         @structure
hi link @lsp.type.parameter      @parameter
hi link @lsp.type.variable       @variable
hi link @lsp.type.property       @property
hi link @lsp.type.enumMember     @constant
hi link @lsp.type.function       @function
hi link @lsp.type.method         @method
hi link @lsp.type.macro          @macro
hi link @lsp.type.decorator      @function
hi link @comment.todo.comment    Todo
hi link @comment.note.comment    Todo
hi link @comment.error.comment   Todo
hi link @comment.warning.comment Todo
hi link @variable.member.tsx     @property

hi link WinSeparator           VertSplit
hi link Floaterm               NormalFloat
hi link FloatermBorder         FloatBorder
hi link UltestSummaryFile      UltestSummaryInfo
hi link UltestSummaryNamespace UltestSummaryInfo

hi link FzfLuaNormal           NormalFloat
hi link FzfLuaBorder           FloatBorder
