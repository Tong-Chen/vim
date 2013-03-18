" Math UpperCase
syn match UpperCaseCT /[A-Z][A-Z0-9_]*[A-Z]/ 
syn match UpperCaseCT /[A-Z][A-Z0-9_]*/
"hi UpperCaseCT guifg=#F90404 ctermfg=#F90404
hi UpperCaseCT guifg=#F90404

" Math MPI keyword
"syn match	MPItypeCT		display "MPI_Comm" 
"syn match	MPItypeCT		display "MPI_Status"
syn match MPItypeCT         /MPI_[A-Za-z0-9_]*/
hi MPItypeCT    guifg=#088A08

"highlight Functions
"========================================================
"syn match cFuntions display "[a-zA-Z_]\{-1,}\s\{-0,}(\{1}"ms=s,me=e-1
"hi def link cFuntions Title
"hi cFunctions       gui=NONE guifg=#08C2F0
"========================================================
"========================================================
" Highlight All Function
"========================================================
syn match   cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match   cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunction        gui=NONE guifg=#2404F2 term=bold

"========================================================
" Highlight All Math Operator
"========================================================
" C math operators
syn match       cMathOperator     display "[-+\*/%=]"
" C pointer operators
syn match       cPointerOperator  display "->\|\."
" C logical   operators - boolean results
syn match       cLogicalOperator  display "[!<>]=\="
syn match       cLogicalOperator  display "=="
" C bit operators
syn match       cBinaryOperator   display "\(&\||\|\^\|<<\|>>\)=\="
syn match       cBinaryOperator   display "\~"
syn match       cBinaryOperatorError display "\~="
" More C logical operators - highlight in preference to binary
syn match       cLogicalOperator  display "&&\|||"
syn match       cLogicalOperatorError display "\(&&\|||\)="

" Math Operator
hi cMathOperator            guifg=#640404
hi cPointerOperator         guifg=#640404
hi cLogicalOperator         guifg=#640404
hi cBinaryOperator          guifg=#640404
hi cBinaryOperatorError     guifg=#640404
hi cLogicalOperator         guifg=#640404
hi cLogicalOperatorError    guifg=#640404

" Error print
syn match ErrorCT /print(/
" add a ; to #define
syn match ErrorCT /^\#.+?\;$/
" line character more than 80
syn match ErrorCT /\%>80v.\+/
hi ErrorCT  guibg=#000000 guifg=#FF0000
" highlight tab in line
syn match errorMsg /[^\t]\zs\t\+/
" highlight TODO in line to mention
" syn match errorMsg /TODO/
" highlight ATTENTION
hi ATTENTION guibg=#00FF00 guifg=#FF0000
syn match ATTENTION /ATTENTION/
