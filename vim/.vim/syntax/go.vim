" Vim syntaxtax file
" Language:     Go
" Maintainer:   David Daub <david.daub@googlemail.com>
" Last Change:  2009 Nov 15
" Version:      0.1
"
" Early version. Took some (ok, most) stuff from existing syntaxtax files like
" c.vim or d.vim.
"
"
" Todo:
" - very much

" Quit when a (custom) syntaxtax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif


syn keyword         goPackage       package
syn keyword         goImport        import
hi def link         goPackage       Statement
hi def link         goImport        Statement

" A bunch of useful Go keywords
syn keyword  goStatement select
syn keyword  goStatement defer
syn keyword  goStatement fallthrough range type
syn keyword  goStatement return
hi def link goStatement     Statement


syn keyword     goConditional    if else switch
hi def link goConditional   Conditional

syn keyword     goBranch         goto break continue
hi def link goBranch        Conditional

syn keyword     goLabel          case default
hi def link goLabel         Label

syn keyword     goRepeat         for
hi def link goRepeat        Repeat

syn keyword     goType           struct const interface func
syn keyword     goType           var map
syn keyword     goType           uint8 uint16 uint32 uint64
syn keyword     goType           int8 int16 int32 int64
syn keyword     goType           float32 float64
syn keyword     goType           float32 float64
syn keyword     goType           byte
syn keyword     goType           uint int float uintptr string
hi def link goType          Type

syn keyword     goConcurrent     chan go
hi def link goConcurrent    Statement

syn keyword     goValue          nil
hi def link goValue         Constant

syn keyword     goBoolean        true false
hi def link goBoolean       Boolean

syn keyword     goConstant       iota
hi def link goConstant      Constant

" Builtin functions
syn keyword     goBif            len make new close closed cap map
" According to the language specification it is not garanteed to stay in the
" language. See http://golang.org/doc/go_spec.html#Bootstrapping
syn keyword     goBif            print println panic panicln
hi def link goBif           Function

" Commants
syn keyword     goTodo           contained TODO FIXME XXX
syn match       goLineComment    "\/\/.*" contains=@Spell,goTodo
syn match       goCommentSkip    "^[ \t]*\*\($\|[ \t]\+\)"
syn region      goComment        start="/\*"  end="\*/" contains=@Spell,goTodo
hi def link goTodo          Todo
hi def link goLineComment   goComment
hi def link goComment       Comment

" Numerals
syn case ignore
"integer number, or floating point number without a dot and with "f".
syn match       goNumbers        display transparent "\<\d\|\.\d" contains=goNumber,goFloat,goOctError,goOct
syn match       goNumbersCom     display contained transparent "\<\d\|\.\d" contains=goNumber,goFloat,goOct
syn match       goNumber         display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
hi def link goNumbers       Number
hi def link goNumbersCom    Number

" hex number
syn match       goNumber         display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
hi def link goNumber        Number

" oct number
syn match       goOct            display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=goOctZero
syn match       goOctZero        display contained "\<0"
hi def link goOct           Number
hi def link goOctZero       Number

syn match       goFloat          display contained "\d\+\.\d*\(e[-+]\=\d\+\)\="
syn match       goFloat          display contained "\d\+e[-+]\=\d\=\>"
syn match       goFloat          display "\(\.[0-9_]\+\)\(e[-+]\=[0-9_]\+\)\=[fl]\=i\=\>"
hi def link goFloat         Float

" Literals
syn region      goString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell
hi def link goString        String

syn match       goSpecial        display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn match       goCharacter      "L\='[^\\]'"
syn match       goCharacter      "L'[^']*'" contains=goSpecial
hi def link goSpecial       Special
hi def link goCharacter     Character


let b:current_syntax = "go"
