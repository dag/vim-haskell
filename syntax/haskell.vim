"{{{1 Intro
if exists('b:current_syntax')
  finish
endif

syntax case match

"{{{1 CPP
syntax region haskellCPPComment contained start='\V/*' end='\V*/'
syntax region haskellCPP matchgroup=haskellCPPSymbol start='\v^#' skip='\$' end='$' contains=haskellCPPComment
highlight default link haskellCPPComment haskellComment
highlight default link haskellCPP haskellPreProc
highlight default link haskellCPPSymbol haskellSpecial

"{{{1 Special
syntax match haskellDelim '[(){}[\]]'
syntax match haskellSymbol '\V,\|;\|!\|_\|..\|::\=\|=>\|=\|\\\||\|<-\|->\|@\|~'
syntax cluster haskellSpecials contains=haskellDelim,haskellSymbol
highlight default link haskellDelim haskellDelimiter
highlight default link haskellSymbol haskellSpecial

"{{{1 Type Signatures
syntax region haskellTypeSignature matchgroup=haskellVars start='\v^\S.{-}\n=\s*\ze\:{2}' end='\n\ze\S' contains=TOP,haskellTypeSignature
highlight default link haskellTypeSignature haskellType
highlight default link haskellVars haskellIdentifier

"{{{1 Strings
syntax region haskellStr matchgroup=haskellStrDelim start='"' skip='\v\\\\|\\"' end='\v\"|\\@<!$'
highlight default link haskellStr haskellString
highlight default link haskellStrDelim haskellDelimiter

"{{{1 Comments
syntax region haskellLineComment matchgroup=haskellCommentSymbol start='\v\-{2,}[-!#$%&*+./<=>?@\\^|~]@!' end='$' oneline
syntax region haskellBlockComment matchgroup=haskellCommentDelim start='{-' end='-}' contains=haskellBlockComment
syntax cluster haskellComments contains=haskellLineComment,haskellBlockComment
highlight default link haskellLineComment haskellComment
highlight default link haskellBlockComment haskellComment
highlight default link haskellCommentSymbol haskellSpecial
highlight default link haskellCommentDelim haskellDelimiter

"{{{1 Templates
syntax region haskellSplice matchgroup=haskellSpliceDelim start='\V$(' skip='(.\{-})' end=')' contains=TOP keepend
highlight default link haskellSplice haskellMacro
highlight default link haskellSpliceDelim haskellDelimiter

"{{{1 Pragmas
syntax region haskellPragma matchgroup=haskellPragmaDelim start='{-#' end='#-}' keepend
highlight default link haskellPragma haskellPreProc
highlight default link haskellPragmaDelim haskellDelimiter

syntax match haskellPragmaLanguage contained containedin=haskellPragma '\v<LANGUAGE>\zs\_.*' contains=haskellSymbol
highlight default link haskellPragmaLanguage haskellIdentifier

syntax match haskellPragmaOptions contained containedin=haskellPragma '\v<OPTIONS%(_GHC|_HADDOCK)=>\zs\_.*'
highlight default link haskellPragmaOptions haskellString

" syntax keyword haskellPragmaINCLUDE contained containedin=haskellPragma INCLUDE
" highlight default link haskellPragmaINCLUDE haskellInclude

" WARNING DEPRECATED

syntax match haskellInline contained containedin=haskellPragma '\v<%(INLINE|NOINLINE|NOTINLINE|INLINABLE)>\zs.*'
highlight default link haskellInline haskellIdentifier

" syntax keyword haskellPragmaCONLIKE contained containedin=haskellPragma CONLIKE
" highlight default link haskellPragmaCONLIKE haskellKeyword

" LINE

syntax match haskellRules contained containedin=haskellPragma '\v<RULES>\zs\_.*' contains=TOP

syntax match haskellSpecializeKeyword contained containedin=haskellPragma '\v<SPECIALI[ZS]E>\s*\zs%(INLINE>)=' nextgroup=haskellSpecializeVars
syntax match haskellSpecializeVars contained '\v\_.{-}\ze\:{2}' nextgroup=haskellSpecializeTypeSignature
syntax match haskellSpecializeTypeSignature contained '\v\:{2}\_.*' contains=TOP
highlight default link haskellSpecializeKeyword haskellKeyword
highlight default link haskellSpecializeVars haskellVars
highlight default link haskellSpecializeTypeSignature haskellTypeSignature

" UNPACK NOUNPACK SOURCE ANN

"{{{1 Imports
syntax match haskellImport '\v<import>'
syntax region haskellImportDecl matchgroup=haskellImport start='\v^import>' end='\n\ze\S' contains=haskellImportKeyword,haskellImportSpec,@haskellComments,@haskellCPP,haskellPragma,haskellStr
syntax region haskellImportSpec matchgroup=haskellImportDelim contained start='(' skip='(.\{-})' end=')' keepend contains=@haskellSpecials
highlight default link haskellImportDelim haskellDelimiter
highlight default link haskellImportSpec haskellIdentifier
highlight default link haskellImport haskellInclude

syntax keyword haskellImportKeyword contained safe qualified hiding
syntax keyword haskellImportKeyword contained as nextgroup=haskellImportName skipwhite skipempty
highlight default link haskellImportKeyword haskellKeyword

syntax match haskellImportName contained '\u\k*'
highlight default link haskellImportName haskellIdentifier

"{{{1 Reserved Keywords
syntax keyword haskellModule module
highlight default link haskellModule haskellDefine

syntax keyword haskellDefault default
highlight default link haskellDefault haskellStatement

syntax keyword haskellInfix infix[l] infixr
highlight default link haskellInfix haskellStatement

syntax keyword haskellCase case of
highlight default link haskellCase haskellConditional

syntax keyword haskellIf if then else
highlight default link haskellIf haskellConditional

syntax keyword haskellDo do mdo
highlight default link haskellDo haskellKeyword

syntax keyword haskellProc proc
highlight default link haskellProc haskellKeyword

syntax keyword haskellRec rec
highlight default link haskellRec haskellRepeat

syntax keyword haskellLet let in
highlight default link haskellLet haskellKeyword

syntax keyword haskellWhere where
highlight default link haskellWhere haskellKeyword

syntax keyword haskellType type newtype
highlight default link haskellType haskellTypedef

syntax keyword haskellData data
highlight default link haskellData haskellStructure

syntax keyword haskellDeriving deriving
highlight default link haskellDeriving haskellKeyword

syntax keyword haskellClass class instance
highlight default link haskellClass haskellStorageClass

syntax keyword haskellForall contained forall containedin=haskellTypeSignature,haskellSpecializeTypeSignature,haskellRules
highlight default link haskellForall haskellKeyword

"{{{1 Highlighting groups
highlight default link haskellComment Comment

highlight default link haskellConstant Constant
highlight default link haskellString String
highlight default link haskellCharacter Character
highlight default link haskellNumber Number
highlight default link haskellBoolean Boolean
highlight default link haskellFloat Float

highlight default link haskellIdentifier Identifier
highlight default link haskellFunction Function

highlight default link haskellStatement Statement
highlight default link haskellConditional Conditional
highlight default link haskellRepeat Repeat
highlight default link haskellLabel Label
highlight default link haskellOperator Operator
highlight default link haskellKeyword Keyword
highlight default link haskellException Exception

highlight default link haskellPreProc PreProc
highlight default link haskellInclude Include
highlight default link haskellDefine Define
highlight default link haskellMacro Macro
highlight default link haskellPreCondit PreCondit

highlight default link haskellType Type
highlight default link haskellStorageClass StorageClass
highlight default link haskellStructure Structure
highlight default link haskellTypedef Typedef

highlight default link haskellSpecial Special
highlight default link haskellSpecialChar SpecialChar
highlight default link haskellTag Tag
highlight default link haskellDelimiter Delimiter
highlight default link haskellSpecialComment SpecialComment
highlight default link haskellDebug Debug

highlight default link haskellUnderlined Underlined

highlight default link haskellIgnore Ignore

highlight default link haskellError Error

highlight default link haskellTodo Todo

"{{{1 Outro
let b:current_syntax = 'haskell'
