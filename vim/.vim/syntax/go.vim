if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword     goPackage           package
syn keyword     goImport            import    contained
syn keyword     goVar               var       contained
syn keyword     goConst             const     contained

hi def link     goPackage           Statement
hi def link     goImport            Statement
hi def link     goVar               Keyword
hi def link     goConst             Keyword
hi def link     goDeclaration       Keyword

" Keywords within functions
syn keyword     goStatement         defer go goto return break continue fallthrough
syn keyword     goConditional       if else switch select
syn keyword     goLabel             case default
syn keyword     goRepeat            for range

hi def link     goStatement         Statement
hi def link     goConditional       Conditional
hi def link     goLabel             Label
hi def link     goRepeat            Repeat

" Predefined types
syn keyword     goType              chan map bool string error
syn keyword     goSignedInts        int int8 int16 int32 int64 rune
syn keyword     goUnsignedInts      byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword     goFloats            float32 float64
syn keyword     goComplexes         complex64 complex128

hi def link     goType              Type
hi def link     goSignedInts        Type
hi def link     goUnsignedInts      Type
hi def link     goFloats            Type
hi def link     goComplexes         Type

" Predefined functions and values
syn keyword     goBuiltins                 append cap close complex copy delete imag len
syn keyword     goBuiltins                 make new panic print println real recover
syn keyword     goBoolean                  true false
syn keyword     goPredefinedIdentifiers    nil iota

hi def link     goBuiltins                 Identifier
hi def link     goBoolean                  Boolean
hi def link     goPredefinedIdentifiers    goBoolean

" Comments; their contents
syn keyword     goTodo              contained TODO FIXME XXX BUG
syn cluster     goCommentGroup      contains=goTodo

syn region      goComment           start="//" end="$" contains=goGenerate,@goCommentGroup,@Spell
syn region      goComment           start="/\*" end="\*/" contains=@goCommentGroup,@Spell fold
syn match       goComment           "\v(^\s*//.*\n)+" contains=goGenerate,@goCommentGroup,@Spell fold

hi def link     goComment           Comment
hi def link     goTodo              Todo

syn match       goGenerateVariables contained /\%(\$GOARCH\|\$GOOS\|\$GOFILE\|\$GOLINE\|\$GOPACKAGE\|\$DOLLAR\)\>/
syn region      goGenerate          start="^\s*//go:generate" end="$" contains=goGenerateVariables
hi def link     goGenerate          PreProc
hi def link     goGenerateVariables Special

" Go escapes
syn match       goEscapeOctal       display contained "\\[0-7]\{3}"
syn match       goEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       goEscapeX           display contained "\\x\x\{2}"
syn match       goEscapeU           display contained "\\u\x\{4}"
syn match       goEscapeBigU        display contained "\\U\x\{8}"
syn match       goEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     goEscapeOctal       goSpecialString
hi def link     goEscapeC           goSpecialString
hi def link     goEscapeX           goSpecialString
hi def link     goEscapeU           goSpecialString
hi def link     goEscapeBigU        goSpecialString
hi def link     goSpecialString     Special
hi def link     goEscapeError       Error

" Strings and their contents
syn cluster     goStringGroup contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syn region      goString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup,@Spell
syn region      goRawString         start=+`+ end=+`+ contains=@Spell

syn match       goFormatSpecifier   /\
                \%([^%]\%(%%\)*\)\
                \@<=%[-#0 +]*\
                \%(\%(\%(\[\d\+\]\)\=\*\)\|\d\+\)\=\
                \%(\.\%(\%(\%(\[\d\+\]\)\=\*\)\|\d\+\)\=\)\=\
                \%(\[\d\+\]\)\=[vTtbcdoqxXUeEfFgGspw]/ contained containedin=goString,goRawString
hi def link     goFormatSpecifier   goSpecialString
                                  

hi def link     goString            String
hi def link     goRawString         String

" Characters; their contents
syn cluster     goCharacterGroup    contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU
syn region      goCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

hi def link     goCharacter         Character

" Regions
syn region      goParen             start='(' end=')' transparent
syn region      goBlock             start="{" end="}" transparent fold


" Import
syn region      goImport            start='import (' end=')' transparent fold contains=goImport,goString,goComment

" var, const
syn region      goVar               start='var (' end='^\s*)$' transparent fold
                                    \ contains=ALLBUT,goParen,goBlock,goFunction,goTypeName,goReceiverType,goReceiverVar,goParamName,goParamType,goSimpleParams,goPointerOperator
syn region      goConst             start='const (' end='^\s*)$' transparent fold
                                    \ contains=ALLBUT,goParen,goBlock,goFunction,goTypeName,goReceiverType,goReceiverVar,goParamName,goParamType,goSimpleParams,goPointerOperator

" Single-line var, const and import.
syn match       goSingleDecl        /\%(import\|var\|const\) [^(]\@=/ contains=goImport,goVar,goConst

" Integers
syn match       goDecimalInt        "\<-\=\(0\|[1-9]_\?\(\d\|\d\+_\?\d\+\)*\)\%([Ee][-+]\=\d\+\)\=\>"
syn match       goDecimalError      "\<-\=\(_\(\d\+_*\)\+\|\([1-9]\d*_*\)\+__\(\d\+_*\)\+\|\([1-9]\d*_*\)\+_\+\)\%([Ee][-+]\=\d\+\)\=\>"
syn match       goHexadecimalInt    "\<-\=0[xX]_\?\(\x\+_\?\)\+\>"
syn match       goHexadecimalError  "\<-\=0[xX]_\?\(\x\+_\?\)*\(\([^\t0-9A-Fa-f_]\|__\)\S*\|_\)\>"
syn match       goOctalInt          "\<-\=0[oO]\?_\?\(\o\+_\?\)\+\>"
syn match       goOctalError        "\<-\=0[0-7oO_]*\(\([^\t0-7oOxX_/)\]\}\:]\|[oO]\{2,\}\|__\)\S*\|_\|[oOxX]\)\>"
syn match       goBinaryInt         "\<-\=0[bB]_\?\([01]\+_\?\)\+\>"
syn match       goBinaryError       "\<-\=0[bB]_\?[01_]*\([^\t01_]\S*\|__\S*\|_\)\>"

hi def link     goDecimalInt        Integer
hi def link     goDecimalError      Error
hi def link     goHexadecimalInt    Integer
hi def link     goHexadecimalError  Error
hi def link     goOctalInt          Integer
hi def link     goOctalError        Error
hi def link     goBinaryInt         Integer
hi def link     goBinaryError       Error
hi def link     Integer             Number

" Floating point
syn match       goFloat             "\<-\=\d\+\.\d*\%([Ee][-+]\=\d\+\)\=\>"
syn match       goFloat             "\<-\=\.\d\+\%([Ee][-+]\=\d\+\)\=\>"

hi def link     goFloat             Float

" Imaginary literals
syn match       goImaginary         "\<-\=\d\+i\>"
syn match       goImaginary         "\<-\=\d\+[Ee][-+]\=\d\+i\>"
syn match       goImaginaryFloat    "\<-\=\d\+\.\d*\%([Ee][-+]\=\d\+\)\=i\>"
syn match       goImaginaryFloat    "\<-\=\.\d\+\%([Ee][-+]\=\d\+\)\=i\>"

hi def link     goImaginary         Number
hi def link     goImaginaryFloat    Float

" Spaces after "[]"
syn match       goSpaceError        display "\%(\[\]\)\@<=\s\+"

" Spacing errors around the 'chan' keyword
syn match       goSpaceError        display "\%(\%(\<chan\>\)\@<!<-\)\@<=\s\+\%(\<chan\>\)\@="
syn match       goSpaceError        display "\%(\%(<-\)\@<!\<chan\>\)\@<=\s\+\%(<-\)\@="

syn match       goSpaceError        display "\%(\%(^\|[={(,;]\)\s*<-\)\@<=\s\+"

" Extra types commonly seen
syn match       goExtraType         /\<bytes\.\%(Buffer\)\>/
syn match       goExtraType         /\<context\.\%(Context\)\>/
syn match       goExtraType         /\<io\.\%(Reader\|ReadSeeker\|ReadWriter\|ReadCloser\|ReadWriteCloser\|Writer\|WriteCloser\|Seeker\)\>/
syn match       goExtraType         /\<reflect\.\%(Kind\|Type\|Value\)\>/
syn match       goExtraType         /\<unsafe\.Pointer\>/

" Space-tab error
syn match       goSpaceError        display " \+\t"me=e-1

" Trailing white space error
syn match       goSpaceError        display excludenl "\s\+$"

hi def link     goExtraType         Type
hi def link     goSpaceError        Error

" Comments; their contents
syn keyword     goTodo              contained NOTE
hi def link     goTodo              Todo

syn match       goVarArgs           /\.\.\./

" Operators
syn match       goOperator          /[-+%<>!&|^*=]=\?/
syn match       goOperator          /\/\%(=\|\ze[^/*]\)/
syn match       goOperator          /\%(<<\|>>\|&^\)=\?/
syn match       goOperator          /:=\|||\|<-\|++\|--/
hi def link     goPointerOperator   goOperator
hi def link     goVarArgs           goOperator
hi def link     goOperator          Operator

" Functions
syn match       goDeclaration       /\<func\>/ nextgroup=goReceiver,goFunction,goSimpleParams skipwhite skipnl
syn match       goReceiverVar       /\w\+\ze\s\+\%(\w\|\*\)/ nextgroup=goPointerOperator,goReceiverType skipwhite skipnl contained
syn match       goPointerOperator   /\*/ nextgroup=goReceiverType contained skipwhite skipnl
syn match       goFunction          /\w\+/ nextgroup=goSimpleParams contained skipwhite skipnl
syn match       goReceiverType      /\w\+/ contained
syn match       goSimpleParams      /(\%(\w\|\_s\|[*\.\[\],\{\}<>-]\)*)/ contained contains=goParamName,goType nextgroup=goFunctionReturn skipwhite skipnl
syn match       goFunctionReturn    /(\%(\w\|\_s\|[*\.\[\],\{\}<>-]\)*)/ contained contains=goParamName,goType skipwhite skipnl
syn match       goParamName         /\w\+\%(\s*,\s*\w\+\)*\ze\s\+\%(\w\|\.\|\*\|\[\)/ contained nextgroup=goParamType skipwhite skipnl
syn match       goParamType         /\%([^,)]\|\_s\)\+,\?/ contained nextgroup=goParamName skipwhite skipnl
                                    \ contains=goVarArgs,goType,goSignedInts,goUnsignedInts,goFloats,goComplexes,goDeclType,goBlock
hi def link     goReceiverVar       goParamName
hi def link     goParamName         Identifier

syn match       goReceiver          /(\s*\w\+\%(\s\+\*\?\s*\w\+\)\?\s*)\ze\s*\w/ contained nextgroup=goFunction contains=goReceiverVar skipwhite skipnl

hi def link     goFunction          Function

" Function calls
syn match       goFunctionCall      /\w\+\ze(/ contains=goBuiltins,goDeclaration
hi def link     goFunctionCall      Type

" Fields
syn match       goField             /\.\w\+\
                                    \%(\%([\/\-\+*%]\)\|\
                                    \%([\[\]{}<\>\)]\)\|\
                                    \%([\!=\^|&]\)\|\
                                    \%([\n\r\]\)\|\
                                    \%([,\:.]\)\)\@=/hs=s+1
hi def link     goField             Identifier

" Structs & Interfaces
syn match       goTypeConstructor   /\<\w\+{\@=/
syn match       goTypeDecl          /\<type\>/ nextgroup=goTypeName skipwhite skipnl
syn match       goTypeName          /\w\+/ contained nextgroup=goDeclType skipwhite skipnl
syn match       goDeclType          /\<\%(interface\|struct\)\>/ skipwhite skipnl
hi def link     goReceiverType      Type
hi def link     goTypeConstructor   Type
hi def link     goTypeName          Type
hi def link     goTypeDecl          Keyword
hi def link     goDeclType          Keyword

" Variable Assignments
syn match       goVarAssign         /\v[_.[:alnum:]]+(,\s*[_.[:alnum:]]+)*\ze(\s*([-^+|^\/%&]|\*|\<\<|\>\>|\&\^)?\=[^=])/
hi def link     goVarAssign         Special

" Variable Declarations
syn match       goVarDefs           /\v\w+(,\s*\w+)*\ze(\s*:\=)/
hi def link     goVarDefs           Special

" Build Constraints
syn match       goBuildKeyword      display contained "+build"
syn keyword     goBuildDirectives   contained
                                    \ android darwin dragonfly freebsd linux nacl netbsd openbsd plan9
                                    \ solaris windows 386 amd64 amd64p32 arm armbe arm64 arm64be ppc64 
                                    \ ppc64le mips mipsle mips64 mips64le mips64p32 mips64p32le ppc 
                                    \ s390 s390x sparc sparc64 cgo ignore race 
syn region      goBuildComment      matchgroup=goBuildCommentStart
                                    \ start="//\s*+build\s"rs=s+2 end="$"
                                    \ contains=goBuildKeyword,goBuildDirectives
hi def link     goBuildCommentStart Comment
hi def link     goBuildDirectives         Type
hi def link     goBuildKeyword        PreProc

exe 'syn region goPackageComment start=/\v(\/\/.*\n)+\s*package/'
    \ . ' end=/\v\n\s*package/he=e-7,me=e-7,re=e-7'
    \ . ' contains=@goCommentGroup,@Spell fold'
exe 'syn region goPackageComment start=/\v^\s*\/\*.*\n(.*\n)*\s*\*\/\npackage/'
    \ . ' end=/\v\*\/\n\s*package/he=e-7,me=e-7,re=e-7'
    \ . ' contains=@goCommentGroup,@Spell fold'

hi def link     goPackageComment        Comment

syn sync minlines=500

let b:current_syntax = "go"
