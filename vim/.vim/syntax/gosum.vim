" gosum.vim: Vim syntax file for go.sum file

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syntax case match

" match vX.Y.Z and their prereleases
syntax match gomodVersion "v\d\+\.\d\+\.\d\+\%(-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\)\?\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?"
"                          ^--- version ---^^------------ pre-release ---------------------^^--------------- metadata ---------------------^
"                          ^--------------------------------------- semantic version ------------------------------------------------------^

" match pseudo versions
" without a major version before the commit (e.g. vX.0.0-yyyymmddhhmmss-abcdefabcdef)
syntax match gomodVersion  "v\d\+\.0\.0-\d\{14\}-\x\+"
" when most recent version before target is a pre-release
syntax match gomodVersion "v\d\+\.\d\+\.\d\+-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?\.0\.\d\{14}-\x\+"
"                          ^--- version ---^^--- ------ pre-release -----------------^^--------------- metadata ---------------------^
"                          ^------------------------------------- semantic version --------------------------------------------------^
" most recent version before the target is X.Y.Z
syntax match gomodVersion "v\d\+\.\d\+\.\d\+\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?-0\.\d\{14}-\x\+"
"                          ^--- version ---^^--------------- metadata ---------------------^

" match incompatible vX.Y.Z and their prereleases
syntax match gomodVersion "v[2-9]\{1}\d*\.\d\+\.\d\+\%(-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\)\?\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?+incompatible"
"                          ^------- version -------^^------------- pre-release ---------------------^^--------------- metadata ---------------------^
"                          ^------------------------------------------- semantic version -----------------------------------------------------------^

" match incompatible pseudo versions
" incompatible without a major version before the commit (e.g. vX.0.0-yyyymmddhhmmss-abcdefabcdef)
syntax match gomodVersion "v[2-9]\{1}\d*\.0\.0-\d\{14\}-\x\++incompatible"
" when most recent version before target is a pre-release
syntax match gomodVersion "v[2-9]\{1}\d*\.\d\+\.\d\+-\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\%(+\%([0-9A-Za-z-]\+\)\(\.[0-9A-Za-z-]\+\)*\)\?\.0\.\d\{14}-\x\++incompatible"
"                          ^------- version -------^^---------- pre-release -----------------^^--------------- metadata ---------------------^
"                          ^----------------------------------------- semantic version ------------------------------------------------------^
" most recent version before the target is X.Y.Z
syntax match gomodVersion "v[2-9]\{1}\d*\.\d\+\.\d\+\%(+\%([0-9A-Za-z-]\+\)\%(\.[0-9A-Za-z-]\+\)*\)\?-0\.\d\{14}-\x\++incompatible"
"                          ^------- version -------^^---------------- metadata ---------------------^

highlight default link gomodVersion Identifier

let b:current_syntax = "gomod"
