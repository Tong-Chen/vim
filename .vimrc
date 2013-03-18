" $VIM/.vimrc
" vim: set ts=4 sw=4 expandtab enc=utf-8: 
" Python programming with Vim (vim7.2 + python2.6) config file.
" Last modified: 2009-2-10 10:25:39 [HERO-5C126C0F8C]

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" {{{ Face theme part
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" My best gui face
"color desertEx
" FIXED: can running on gentoo now
if has("win32")
    set guifont=NSimSun:h14:cGB2312
else
    set guifont=SimSun\ 14
endif

" FIXED: can running on gentoo now
if has("win32")
    language mes en
    lang en
else
    language mes zh_CN.utf8
    lang zh_CN.utf8
endif

set path=''
set langmenu=en_US.UTF-8



set guioptions-=T
set guioptions-=t
set guioptions-=L
set guioptions-=r
set guioptions-=B
set guioptions-=e
set guioptions+=c

let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

" statusline show info
set laststatus=2
set statusline=%<%F%m%r%h\ %=\ [%{&ff}]\ [%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ [%l/%L:%c]\ %P

if has('gui_running')
    " Always show file types in menu
    let do_syntax_sel_menu=1
endif

if has('multi_byte')
    " Legacy encoding is the system default encoding
    let legacy_encoding=&encoding
endif

if has('gui_running') && has('multi_byte')
    " Set encoding (and possibly fileencodings)
    if $LANG !~ '\.' || $LANG =~? '\.UTF-8$'
        set encoding=utf-8
    else
        let &encoding=matchstr($LANG, '\.\zs.*')
        let &fileencodings='ucs-bom,utf-8,' . &encoding
        let legacy_encoding=&encoding
    endif
endif

" utf-8 for cross platform
"set bomb
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,utf-bom,iso8859-1
set ambiwidth=double
" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" }}}


" {{{ Shell part
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" Personal setting for working with Windows NT/2000/XP (requires tee in path)
if &shell =~? 'cmd'
    "set shellxquote=\"
    set shellpipe=2>&1\|\ tee
endif

" Quote shell if it contains space and is not quoted
if &shell =~? '^[^"].* .*[^"]'
    let &shell='"' . &shell . '"'
endif

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" }}}


" {{{ Misc part
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

"
set whichwrap=h,l,~,b,s,<,>,[,]

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set linespace=2         " 
set smarttab            " 
set history=400         " lines of Ex commands, search history ...
set browsedir=buffer    " use the directory of the related buffer
set clipboard+=unnamed  " use register '*' for all y, d, c, p ops
set autoread            " auto read when a file is changed outside
set isk+=$,%,#          " none of these should be word dividers
set wildmenu            " :h and press <Tab> to see what happens
set wig=*.o,*.pyc       " type of file that will not in wildmenu
"set nowrap              " don't break line
set cursorline          " show current line
set number              " show line number
"set autoindent          " always set autoindenting on
set cindent             " add 20100228
filetype indent on      " add 20100728
set report=0            " tell us when anything is changed via :...
"if has("vms")
"    set nobackup          " do not keep a backup file, use versions instead
"else
"    set backup            " keep a backup file
"    set backupdir=$VIM/backup
"endif
set nobackup            " do not keep backup file.
"set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set backspace=2         " make backspace work normal
set whichwrap+=<,>,h,l  " allow backspace and cursor keys to wrap
set shortmess=atI       " shorten to avoid 'press a key' prompt
set completeopt=menu    " use popup menu to show possible completions
set foldenable          " enable folding, I find it very useful
set foldmethod=syntax   " manual, marker, syntax, try set foldcolumn=2
set foldcolumn=2        " add 20100106
set foldlevel=4         " add 20100302
set tabstop=4           " add 20100225
set shiftwidth=4        " add 20100228
set textwidth=70        " add 20100302

set tw=70 fo+=Mm        " add 20100829
" set tw=78 fo+=Mm
" DO NOT BELL!
set novisualbell        " use visual bell instead of beeping
set noerrorbells        " do not make noise

" Don't use Ex mode, use Q for formatting
map Q gq

"set guifont=Courier_New\ 20\ Negreta\ b
"set guifont=Bitstream_Vera_Sans_Mono\ 14
set guifont=Monospace\ 14
colorscheme peachpuff

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Set mapleader
let mapleader = ","
let g:mapleader = ","

" save file
nmap <leader>w :w!<cr><ESC>:!ctags %<cr><cr><leader>t<leader>t
nmap <leader>f :find<cr>
map <F9> :!python<cr> 
map <F12> :!rm -f *.pyc<ESC>:w<cr><ESC>:!python %<cr>
map <leader>v :!valgrind --tool=memcheck myc >&~/tmp<cr>

map <F7> :w<cr><ESC>:!cc -Wall -g -o myc % && ./myc<cr>
map <F8> :w<cr><ESC>:!g++ -o myc % && ./myc<cr>
map <leader>e :e c/exercise/
map <leader>p :e python/hexin/exercise/
map <leader>mc :w<cr><ESC>:!mpicc -g -o myc % && mpirun -np 2 ./myc
map <leader>mx :w<cr><ESC>:!mpicxx -g -o myc % && mpirun -np 2 ./myc
map <leader>mp :w<cr><ESC>:!nohup mpd&
map <leader>latex :w<CR><ESC>:!xelatex %<cr>

"nmap <:>W :w<cr>
:command WQ wq
:command Wq wq
:command W w
:command Q q

"()[]{}''""
inoremap ( ()<ESC>i
"inoremap < '<''>'<ESC>i
inoremap { {}<ESC>i
inoremap [ []<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i 
"inoremap , ,,<ESC>a
"inoremap = =\s<ESC>a
"inoremap ; ;<cr>
inoremap , ,<Space>


if 0
    "设置= + - * 前后自动空格
    let g:equ=1
    if exists("g:equ")
        inoremap = <c-r>=EqualSign('=')<CR>
        au FileType python inoremap + <c-r>=EqualSign('+')<CR>
        inoremap - <c-r>=EqualSign('-')<CR>
        au FileType python inoremap * <c-r>=EqualSign('*')<CR>
        inoremap / <c-r>=EqualSign('/')<CR>
        inoremap > <c-r>=EqualSign('>')<CR>
        inoremap < <c-r>=EqualSign('<')<CR>
        
    endif

    function! EqualSign(char)
        if a:char  =~ '='  && getline('.') =~ ".*("
            return a:char
        endif
        let ex1 = getline('.')[col('.') - 3]
        let ex2 = getline('.')[col('.') - 2]

        if ex1 =~ "[-=+><>\/\*]"
            if ex2 !~ "\s"
                return "\<ESC>i".a:char."\<SPACE>"
            else
                return "\<ESC>xa".a:char."\<SPACE>"
            endif
        else
            if ex2 !~ "\s"
                return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
            else
                return a:char."\<SPACE>\<ESC>a"
            endif
        endif
    endf
endif


" Console window open in the current file's directory, by Tokigun
if has("win32")
    fu! s:Console()
        let l:path = iconv(expand("%:p:h"), &enc, &tenc)
        silent exe "! start /d \"" . l:path . "\""
    endf
    nmap <silent> <Leader>x :call <SID>Console()<CR>
endif

" floding key binding
if version >= 600
    " Reduce folding
    map <F2> zr
    map <S-F2> zR
    " Increase folding
    map <F3> zm
    map <S-F3> zM
endif

" Reduce folding
map <F2> zr
map <S-F2> zR
" Increase folding
map <F3> zm
map <S-F3> zM

set lines=20
set columns=80
winpos 0 0

"pydiction 1.2 python auto complete
filetype plugin on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
"defalut g:pydiction_menu_height == 15
let g:pydiction_menu_height = 20 


" Show TAB char and end space
"set list
set listchars=tab:>-,trail:~
syntax match Trail " +$"
highlight def link Trail Todo

" bash
autocmd BufNewFile *.sh 0r ~/.vim/skeleton/skeleton.sh

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " For all text files set 'textwidth' to 71 characters.
    autocmd FileType text setlocal textwidth=71

    " zope dtml
    autocmd BufNewFile,BufRead *.dtml setf dtml
    
    " python fold
    autocmd fileType py set foldmethod=marker
    
    " shell script
    autocmd fileType sh setlocal sw=4 | setlocal sta
    
    " latex
    " autocmd fileType tex
    " RedHat spec file
    autocmd BufNewFile,BufReadPost *.spec setf spec

    " Brainfuck file
    autocmd BufNewFile,BufReadPost *.b setf brainfuck

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

endif " has("autocmd")

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" }}}




" {{{ Plugin part
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" vimfiles/plugin/autocomplpop.vim
let g:AutoComplPop_MappingDriven=1
let g:AutoComplPop_BehaviorKeywordLength=2

" vimfiles/plugin/taglist.vim

" FIXED: can running on gentoo now
if has("win32")
    let g:Tlist_Ctags_Cmd=$VIMRUNTIME . '/ctags.exe'
else
    let g:Tlist_Ctags_Cmd='/usr/bin/ctags'
endif

let g:Tlist_Use_Right_Window=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_Sort_Type=1
let g:Tlist_Enable_Fold_Colum=0
let g:Tlist_WinWidth=18
let g:Tlist_Show_One_File=1
let g:Tlist_Process_File_Always=1
let g:Tlist_File_Fold_Auto_Close=1

" visible mode use ,t to open and close Tlist
nmap <leader>t :TlistToggle<CR>

" be able to move between the tabs with ALT+LeftArrow and ALT+RightArrow
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left>  :tabprevious<CR>

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" }}}




" {{{ Python part
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " python, not use <tab>
    autocmd FileType python setlocal et | setlocal sta | setlocal sw=4 | setlocal st=4
    " python omnifunc
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    " make set with pyunit
    autocmd BufRead *.py setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
    autocmd BufRead *.py setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

    " FIXED: can running on gentoo now
    if has("win32")
        " :!ctags -R -f python.tags C:/Toolkit/Python26/include
        " Now set the python.tags to vim tags.
        autocmd FileType python set tags+=$VIM/python.tags

        " python auto-complete code(Ctrl-n or Ctrl-p)
        " Typing the following (in insert mode):
        "   os.lis<Ctrl-n>
        " will expand to:
        "   os.listdir(
        autocmd FileType python set complete+=k$VIM/vimfiles/tools/pydiction
        
        " Auto using the skeleton python template file
        autocmd BufNewFile test*.py 0r $VIM/vimfiles/skeleton/test.py
        autocmd BufNewFile alltests.py 0r $VIM/vimfiles/skeleton/alltests.py
        autocmd BufNewFile *.py 0r $VIM/vimfiles/skeleton/skeleton.py
    else
        " :!ctags -R -f python.tags /usr/include/python2.5/
        " Now set the python.tags to vim tags.
	autocmd FileType python set tags+=$HOME/.vim/tools/python.tags

        " python auto-complete code(Ctrl-n or Ctrl-p)
        " Typing the following (in insert mode):
        "   os.lis<Ctrl-n>
        " will expand to:
        "   os.listdir(
        autocmd FileType python set complete+=k$HOME/.vim/tools/pydiction
        autocmd FileType python set complete+=k$HOME/.vim/tools/pydiction/complete-dict
        
        " Auto using the skeleton python template file
        autocmd BufNewFile test*.py 0r $HOME/.vim/skeleton/test.py
        autocmd BufNewFile alltests.py 0r $HOME/.vim/skeleton/alltests.py
        autocmd BufNewFile *.py 0r $HOME/.vim/skeleton/skeleton.py
    endif
endif

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" }}}



" {{{ Quickfix part
" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
map  <leader>q :copen<CR>
nmap <leader>c :cclose<CR>

" <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" }}}

" doxygen
let g:load_doxygen_syntax=1


" ------------latex------------20100728-----------
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
autocmd FileType latex set complete
autocmd FileType latex set complete+=k$HOME/.vim/ftplugin/latex-suite/dictionaries

"---------------------------------------------------------------------------------

" 保存代码文件前自动修改最后修改时间
"au BufWritePre *.sh           call TimeStamp('#')
"au BufWritePre .vimrc,*.vim   call TimeStamp('"')
"au BufWritePre *.c,*.h        call TimeStamp('\*     ')
"au BufWritePre *.cpp,*.hpp    call TimeStamp('//')
"au BufWritePre *.cxx,*.hxx    call TimeStamp('//')
"au BufWritePre *.java         call TimeStamp('//')
"au BufWritePre *.rb           call TimeStamp('#')
"au BufWritePre *.py           call TimeStamp('#')
"au BufWritePre Makefile       call TimeStamp('#')
"au BufWritePre *.php
"    \call TimeStamp('<?php //', '?>')
"au BufWritePre *.html,*htm
"    \call TimeStamp('<!--', '-->')
    
"Last change用到的函数，返回时间，能够自动调整位置
function! TimeStamp(...)
    let sbegin = ''
    let send = ''
    if a:0 >= 1
        let sbegin = a:1.'\s*'
    endif
    if a:0 >= 2
        let send = ' '.a:2
    endif
    let pattern =  'Last Change: .\+'
        \. send
    let pattern = '^\s*' . sbegin . pattern . '\s*$'
    let now = strftime('%Y-%m-%d %H:%M:%S',
        \localtime())
    let row = search(pattern, 'n')
    if row  == 0
        let now = a:1 .  ' Last Change:  '
            \. now . send
        call append(2, now)
    else
        "let curstr = getline(row)
        "let col = match( curstr , 'Last')
        "let spacestr = repeat(' ',col - 1)
        let now = a:1 . 'Last Change:  '
            \. now . send
        call setline(row, now)
    endif
endfunction

set path=''
"autocmd Filetype tex source ~/.vim/auctex.vim
