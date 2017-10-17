" Elvin's vim config: 2015/9/18
"
" Put this under ~/.vim folder
" Add below codes into the original _vimrc if necessary
" source ~/.vim/_vimrc
" Copy all files in Exe folder into the vim74 folder if using MS-Vim
"
set nocompatible
" Tag files generation
if has('win32') || has('win64')
    let g:iswindows="1"
else
    let g:iswindows="0"
endif

" Auto reload your Vimrc
"
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

 
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set bomb

"
" Setup folder structure
"
if !isdirectory(expand('~/.vim/undo/', 1))
    silent call mkdir(expand('~/.vim/undo', 1), 'p')
endif

if !isdirectory(expand('~/.vim/backup/', 1))
    silent call mkdir(expand('~/.vim/backup', 1), 'p')
endif

if !isdirectory(expand('~/.vim/swap/', 1))
    silent call mkdir(expand('~/.vim/swap', 1), 'p')
endif

" No backup file
set nobackup
" set backup
" set writebackup

" Use a specified swap folder
" Source
"   http://stackoverflow.com/a/15317146
set directory=~/.vim/swap//

" Turn on persistent undo
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" The default 20 isn't nearly enough
set history=9999

" Set fileencodings=utf-8,chinese,latin-1
"
set fileencodings=ucs-bom,utf-8,GB2312,cp936,gb18030,big5,euc-jp,euc-kr,latin1,chinese
set fileencoding=utf-8
" Use UTF-8 encoding
set encoding=utf-8

" Solve menu messy code
"
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Change the <Leader> key
let mapleader = ","

" Solve messy code of Chinese. Don't do this if using English OS
"
if (g:iswindows==1)
    language messages zh_CN.utf-8
endif

" File format
"
set fileformats=unix,dos
nmap <silent>fd :se ff=dos<cr>
nmap <silent>fu :se ff=unix<cr>

" Parentheses pairing
"
"set sm

" vim uncompatible
"
set nocp

" Tab width
"
set sw=4
set tabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
set smarttab "use shiftwidth when inserting tab
set expandtab "replace tab with space

" Change tab/indent/shift width to 2
"
nmap t2 :se sw=2 ts=2 cindent shiftwidth=2 autoindent shiftwidth=2<CR>
" Change tab/indent/shift width to 4
"
nmap t4 :se sw=4 ts=4 cindent shiftwidth=4 autoindent shiftwidth=4<CR>

" Add mouse support
"
set mouse=a

" Auto load file if it is changed by other process
"
set autoread

" Status line
"
set laststatus=2

" Status line color
"
highlight StatusLine guifg=SlateBlue guibg=White
highlight StatusLineNC guifg=Gray guibg=White


" Make case-sensitive search intelligently
"
set ignorecase
set smartcase

" GUI font

if g:iswindows == 1
    set guifont=Monospace\ 10
    "set guifont=Envy_Code_R_VS:h12:cANSI
    "set guifont=Courier_New:h10:cANSI
endif

filetype plugin indent on " Auto completion
set autoindent
set nocp                  " Close Vi compatible mode
set completeopt=longest,menu


" Highlight charactor, make them not limited to 100 colums
"
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%101v.*'


" Parentheses pairing, incuding brace
"
" ()need to remove echofunc.vim
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>

" Jump to the line when it exited last time
"
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif


" Highlight current line
if has("gui_running")
    autocmd InsertLeave * se nocul
    autocmd InsertEnter * se cul
endif

" Maxmize window
if g:iswindows == 1
    autocmd GUIEnter * simalt ~x
endif

" Hide menu and tool bar
set guioptions-=m
set guioptions-=T
map <silent> menu :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

" Save global parameters
"
set viminfo+=!

" Show blank space between splitted windows
set fillchars=vert:\ ,stl:\ ,stlnc:\

" Don't change line number on below chars
set iskeyword+=_,$,@,%,#,-

" Don't blink
set novisualbell


" Show line number
"
set nu!
" Show relative number
set rnu!

" Remap <C-h,j,k,l> to navigate up, down, left, right among windows
" Nav up
noremap <C-K> <C-W>k
" Nav down
noremap <C-J> <C-W>j
" Nav left
noremap <C-H> <C-W>h
" Nav right
noremap <C-L> <C-W>l
" Expand left
noremap <C-Left>    <C-W><
" Expand right
noremap <C-Right>   <C-W>>
" Expand up
noremap <C-Up>      :resize -5<cr>
" Expand down
noremap <C-Down>    :resize +5<cr>

if (g:iswindows==1)
" Alpha Window
    map tw : call libcallnr("vimtweak.dll", "SetAlpha",220)<cr>
    map tW : call libcallnr("vimtweak.dll","SetAlpha",255)<cr>

" Maximize Window
    map mW : call libcallnr("vimtweak.dll", "EnableMaximize", 1)<cr>
    map mw : call libcallnr("vimtweak.dll", "EnableMaximize", 0)<cr>
endif "g:iswindows==1


" Add file type
" Add inf, dec, fdf, dsc, hfr, vfr, hfi, vfi file type
au BufNewFile,BufRead *.asl,*.asi,*.itp               setf cpp
au BufNewFile,BufRead *.hfr,*.hfi,*.vfr,*.vfi         setf cpp
au BufNewFile,BufRead *.inf,*.dec,*.fdf,*.dsc         setf make
au BufNewFile,BufRead *.conf                          setf make


" Quicker Escaping
inoremap jj <ESC>

" Drop Vim's crazy regex charactors and use normal regex similar with
" Perl/Python
nnoremap / /\v
vnoremap / /\v

" map ','+space to canel hightlight
nnoremap <leader><space> :noh<cr>

" Save on losing focus
au FocusLost * :wa!

" Syntax complete
if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
    \   if &omnifunc == "" |
    \    setlocal omnifunc=syntaxcomplete#Complete |
    \   endif
endif

" Highlight column
"set cc=81

" Quickly replace current word
"nmap <A-s> :%s/\<<C-r><C-w>\>//g<Left><Left>
nmap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Quickly replace the trailing space char
nmap cS :%s/\s\+$//g<CR>:noh<CR>

" Quickly replace the trailing ^M char 
nmap cM :%s/\r$//g<CR>:noh<CR>

" Disable popup menu when mouse hovering
" It is really annoying and always crash... :)
if (g:iswindows==1)
    set balloondelay=1000000
    setlocal balloonexpr=
endif

"
" Custom Functions
"

" Remove trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<cr>
        normal `z
        retab
    endif
endfunction
nmap <leader>tW :cal StripTrailingWhitespace()<cr>

" Auto load tags file(upward recursively)
"
set tags=tags;
if (g:iswindows==1)
    set tags+=E:\Elvin\Code\fx3_sdk_1_3_3_src\tags
endif
"set tags+=./addtags/qt5_h
set autochdir

" Create tags file
nnoremap tag :call CreateCtags()<CR>
" Create cscope file
nnoremap cs :call CreateCscope()<CR>
" Shortcut for 'cs find'
nnoremap cf :cs find 

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 0
" if you want the reverse search order.
set csto=1

" show msg when any other cscope db added
set cscopeverbose

"cs find c|d|e|f|g|i|s|t name
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
nmap <C-\>? :map <C-\><cr>
nmap <C-\>c :ec 'Find all calls to function' <bar> cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :ec 'Find functions that call this function' <bar> cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :ec 'egrep search for the word under cursor' <bar> cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :ec 'Open filename under cursor' <bar> cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>g :ec 'Find all global definitions' <bar> cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>i :ec 'Find files that include the filename' <bar> cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>s :ec 'Find all references' <bar> cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :ec 'Find all instances to text' <bar> cs find t <C-R>=expand("<cword>")<CR><CR>

" Create cscope.out
function! CreateCscope()
    let dir       = getcwd()
    let save_path = getcwd()
    let last_path = ""
    let cur_path  = getcwd()
    " Assume that '.git' is the root path, try to find it
    " If can't find, use the previous working path 
    while last_path != cur_path
        if isdirectory(".git")
            let dir = cur_path
            break
        endif
        let last_path = cur_path
        silent! execute "lcd .."
        let cur_path = getcwd()
    endwhile
    " Switch to the directory to run cscope
    silent! execute 'cd ' . dir
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if has("cscope")
            silent! execute "cs kill -1"
        endif
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if (csoutdeleted!=0)
            if (g:iswindows==1)
                silent! execute "!taskkill /F /IM cscope.exe"
            else
                " TODO, add linux command here
            endif
            if(g:iswindows==1)
                let csoutdeleted=delete(dir."\\"."cscope.out")
            else
                let csoutdeleted=delete("./"."cscope.out")
            endif
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows==1)
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.cc,*.asm,*.S,*.inc,"
                        \"*.java,*.cs,*.py,*.php,"
                        \"*.asl,*.asi,"
                        \"*.dec,*.dsc,*.inf,*.fdf,"
                        \"*.ino,"
                        \"*.hfr,*.hfi,*.vfr,*.vfi > cscope.files"
        else
            silent! execute "!find ".dir." -name '*.h' "
                        \"-o -name '*.hpp' "
                        \"-o -name '*.c' "
                        \"-o -name '*.asm' "
                        \"-o -name '*.S' "
                        \"-o -name '*.cpp' "
                        \"-o -name '*.cc' "
                        \"-o -name '*.php' "
                        \"-o -name '*.java' "
                        \"-o -name '*.cs' > cscope.files"
        endif
        if(g:iswindows==1)
            silent! exec '!start /min cmd /c "cscope -b'
                \ ' & vim --servername '.v:servername.' --remote-expr "LoadCscopeVimStart()"'
                \ ' "'
        else
            execute "!cscope -b"
            call AddCscope()
        endif
    endif
    silent! execute 'cd ' . save_path
endfunction

" Generate Cscope database and ctags
function! CreateCsTag()
    call CreateCtags()
    call CreateCscope()
endfunction

" Generate ctags
function! CreateCtags()
    let dir       = getcwd()
    let save_path = getcwd()
    let last_path = ""
    let cur_path  = getcwd()
    " Assume that '.git' is the root path, try to find it
    " If can't find, use the previous working path 
    while last_path != cur_path
        if isdirectory(".git")
            let dir = cur_path
            break
        endif
        let last_path = cur_path
        silent! execute "lcd .."
        let cur_path = getcwd()
    endwhile
    " Switch to the directory to run cscope
    silent! execute 'cd ' . dir
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        if(g:iswindows==1)
            silent! exec '!start /min cmd /c '
                \ '"ctags -R --c++-kinds=+p --fields=+iaS '
                \ '--exclude=.git '
                \ '--exclude=*.exe '
                \ '--exclude=*.bin '
                \ '--exclude=*.obj '
                \ '--exclude=*.efi'
                \ '--exclude=*.txt'
                \ '--exclude=*.dll'
                \ '--exclude=*.lib'
                \ '--exclude=*.so'
                \ '--exclude=*.so.*'
                \ '--extra=+q .'
                \ ' & vim --servername '.v:servername.' --remote-expr "AddCtags()"'
                \ ' "'
        else
            execute "!ctags -R --c++-kinds=+p --fields=+iaS "
                        \"--exclude=.git "
                        \"--exclude=*.exe "
                        \"--exclude=*.bin "
                        \ '--exclude=*.txt'
                        \ '--exclude=*.dll'
                        \ '--exclude=*.lib'
                        \ '--exclude=*.so'
                        \"--exclude=*.obj "
                        \"--extra=+q ."
            call AddCtags()
        endif
    endif
    silent! execute 'cd ' . save_path
endfunction


" Add ctags
function! AddCtags()
    if filereadable("tags")
        set tags+=tags
    endif
endfunction

" Load cscope.out if the file exists in CWD
function! AddCscope()
    execute "normal :"
    if filereadable("cscope.out")
        execute "cs add cscope.out"
    endif
endfunction

" Auto load cscope.out when entering Gvim
autocmd GUIEnter * call LoadCscopeVimStart()
command! -nargs=* -complete=file LoadCscopeRecur
            \ call LoadCscopeVimStart()

function! LoadCscopeVimStart()
    let last_path = ""
    let cur_path = getcwd()
    let store_path = cur_path
    while last_path != cur_path
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
            "execute "cs add cscope.out"
            break
        endif
        let last_path = cur_path
        silent! execute "lcd .."
        let cur_path = getcwd()
    endwhile
    silent! execute 'cd ' . store_path
endfunction


"autocmd! BufEnter * nested call InTabBar()
func! InTabBar()
if bufname("%") == "-MiniBufExplorer-"
    wincmd j " jump down
endif
endfunction

" Clear all buffers except the current one
if !exists(':ClearBuf')
  command! ClearBuf call ClearBuffer()
endif
" Clear the buffers except the current one
function! ClearBuffer()
    let i = 1
    while i <= bufnr('$')
            if buflisted(i) && (bufnr('%') != i)
                    \ && (bufwinnr(i) == -1)
                    exe "bdel!" i
            endif
            let i += 1
    endwhile
endfunction

" ***************************************************
"               Hex Edit
" ***************************************************
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex,*.ROM,*.cap setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
" Hex Edit End

" Load EDK2 build log file
function! LoadBuildLog()
    let defLogFile = "build.log"
    let logFile = input("Log file name: ", defLogFile)
    let lastPath = ""
    let curPath = getcwd()
    let storePath = curPath
    while lastPath != curPath
        if filereadable(logFile)
            break
        endif
        let lastPath = curPath
        execute "lcd .."
        let curPath = getcwd()
    endwhile

    if exists(":cgetfile")
        execute "silent! cgetfile " . logFile
    else
        execute "silent! cfile " . logFile
    endif
    botright copen
    execute "cd " . storePath
endfunction
command! -nargs=* -complete=file LoadLogFile
            \ call LoadBuildLog()

" Load and open the build log file
nmap <leader>log :LoadLogFile <cr>


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/desertEx'
Plugin 'mbbill/echofunc'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'Shougo/neocomplcache.vim'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
"Plugin 'vim-scripts/mru.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/DirDiff.vim'
Plugin 'oplatek/Conque-Shell'
Plugin 'klen/python-mode'
Plugin 'vim-scripts/matrix.vim--Yang'
Plugin 'sjl/gundo.vim'
Plugin 'mrtazz/DoxygenToolkit.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/SearchComplete'
Plugin 'tomasr/molokai'
Plugin 'mkarmona/colorsbox'
Plugin 'easymotion/vim-easymotion'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-speeddating'
"Plugin 'jceb/vim-orgmode'
Plugin 'Yggdroot/indentLine'
"Plugin 'vim-scripts/YankRing.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'stevearc/vim-arduino'
Plugin 'gregsexton/gitv'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'file://~/.vim/bundle/myplugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
syntax on
" Syntax highlight
colorscheme desertEx
"colorscheme molokai
"colorscheme  blackdust

" ***************************************************
"               ervandew/supertab
" ***************************************************
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-N>"
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>" 0

" ***************************************************
"               neocomplcache-8.0
" ***************************************************
"let g:neocomplcache_enable_at_startup = 1
""let g:neocomplcache_enable_auto_select = 1
"if !exists('g:neocomplcache_omni_patterns')
  "let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" Define dictionary.

"" TXT English word completion
"let g:neocomplcache_dictionary_filetype_lists = {
    "\ 'default' : '',
    "\ 'txt' : $VIMRUNTIME.'/dict/english.dic',
    "\ }
"" The menu style of auto-complete
"set wildmenu
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType java set omnifunc=javacomplete#Complet
"autocmd FileType cs set omnifunc=ccomplete#Complete

" ***************************************************
" neocomplete.vim
" ***************************************************
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" ***************************************************
"              majutsushi/tagbar
" ***************************************************
" TarBar, a better plugin than Taglist
nnoremap tl :TagbarToggle<CR>
let g:tagbar_sort = 0
" ***************************************************
"              kien/ctrlp.vim
" ***************************************************
" Ctrl-P plug in
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
if(g:iswindows==1)
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
else
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
endif
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
if(g:iswindows==1)
    let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
else
    let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
endif
" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
" ***************************************************
"           scrooloose/nerdtree
" ***************************************************
" Use NERD to replace WinManager now!
nmap wm :NERDTreeToggle<cr>
let NERDTreeShowHidden=1
" ***************************************************
"           powerline/powerline
" ***************************************************
" Disable Powerline cache, otherwise WIN8/WIN8.1 would report error
let g:Powerline_cache_enabled = 0
" ***************************************************
"           vim-scripts/DirDiff.vim
" ***************************************************
"# DirDiff settings
"# Don't compare directories or filenames that match conditions like CVS,*.swp
let g:DirDiffExcludes = "system,CVS,*.class,*.exe,.*.swp"
"# Ignore lines that Id:,Revision: etc.
let g:DirDiffIgnore = "Id:,Revision:,Date:"
"# Don't flag files as different based on whitespace
let g:DirDiffAddArgs = "-w"
"# au FilterWritePre * if &diff is to properly catch the transition to diff mode
"# When in diff mode map space bar to go down to next diff and center the page (z.). Shift-space to go up a diff
au FilterWritePre * if &diff | exe 'noremap <space> ]cz.' | exe 'noremap <S-space> [cz.' | endif
"# When in diff mode convenience map diffput and diffget
au FilterWritePre * if &diff | exe 'noremap <leader>g :diffget<CR>' | exe 'noremap <leader>p :diffput<CR>' | endif
"# When in diff mode convenience map undoing a diffput. Don't go without this one as it is a 3 step process.
au FilterWritePre * if &diff | exe 'nmap <leader>u :wincmd l<CR>:normal u<CR>:wincmd h<CR>' | endif
"# When in diff mode suppress annoying auto-folding (filler,context:1000) and don't check for white space differences
au FilterWritePre * if &diff | exe 'set diffopt=filler,context:1000,iwhite' | exe 'execute "normal \<c-w>\<c-w>"' | endif
" Turn on diff mode
nmap <leader>df :diffthis<cr>
" Turn off diff mode
nmap <leader>de :diffoff<cr>
" ***************************************************
"               oplatek/Conque-Shell
" ***************************************************
" Terminal in vim
"---Conque Shell
"Require Vim7.3 + Python2.7
let g:ConqueTerm_PyVersion = 2
let g:ConqueTerm_FastMode = 0
let g:ConqueTerm_Color = 0
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CloseOnEnd = 0
"let g:ConqueTerm_PromptRegex = '^\w\+@[0-9A-Za-z_.-]\+:[0-9A-Za-z_./\~,:-]\+\$'
let g:ConqueTerm_Syntax = 'conque'
"let g:ConqueTerm_EscKey = '<Esc>'
"let g:ConqueTerm_ColorMode = 'conceal'
nmap term : ConqueTermSplit cmd<cr>
" ***************************************************
"               mbbill/echofunc
" ***************************************************
" echofunc.vim
let g:EchoFuncShowOnStatus = 1
" Status line content, it won't take effect when Plugin Airline was used
"set statusline=[%n]%<%f%y%h%m%r%=[%b\ 0x%B]\ %l\ of\ %L,%c%V\ Page\ %N\ %P
"set statusline=[%n]%<%f%y%h%m%r%=%{EchoFuncGetStatusLine()}\ \ [%b\ 0x%B]\ %l\ of\ %L,%c%V\ Page\ %N\ %P

" ***************************************************
"               sjl/gundo.vim
" ***************************************************
" Gundo : Visualize your undo tree.
nnoremap <leader>gu :GundoToggle<cr>

" ***************************************************
"         mrtazz/DoxygenToolkit.vim
" ***************************************************
let load_doxygen_syntax = 1
map <leader>dx : Dox<cr>
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_briefTag_pre="@brief  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_authorName="Huang Kangying"
"let g:DoxygenToolkit_licenseTag="My own license"

" ***************************************************
"           vim-scripts/a.vim
" ***************************************************
" a.vim: jump to *.h file
"
"nnoremap <leader> hd :A<CR>
" ***************************************************
"           vim-scripts/mru.vim
" ***************************************************
"nnoremap <leader>mr :Mru<cr>
"nnoremap <leader>bs :Mru<cr>
let MRU_Auto_Close = 1

" ***************************************************
"           junegunn/vim-easy-align
" ***************************************************
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" ***************************************************
"           bling/vim-airline
" ***************************************************
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Override the section z as 'ascii, row, col' 
let g:airline_section_z = '[0x%B] [%l, %c]'

" Use the fancy font if installed Consolas font in windows
" For compatibility, don't use powerline fonts
let g:use_power_line_fonts = 1
if g:iswindows == 1
    if g:use_power_line_fonts == 1
        let g:airline_powerline_fonts = 1
        set guifont=Consolas\ for\ Powerline\ FixedD:h10
        let g:Powerline_symbols="fancy"
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif

        let g:airline_left_sep = "\u2b80" 
        let g:airline_left_alt_sep = "\u2b81"
        let g:airline_right_sep = "\u2b82"
        let g:airline_right_alt_sep = "\u2b83"
        let g:airline_symbols.branch = "\u2b60"
        let g:airline_symbols.readonly = "\u2b64"
        let g:airline_symbols.linenr = "\u2b61"
        let g:airline#extensions#tabline#left_sep = "\u2b80"
        let g:airline#extensions#tabline#left_alt_sep = "\u2b81"
        set ambiwidth=double
    endif
else
    if g:use_power_line_fonts == 1
        let g:airline_powerline_fonts = 1
        let g:Powerline_symbols="fancy"
    endif
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
endif

" ***************************************************
"           myplugin/mygrep
" ***************************************************
" My Grep function
nnoremap <silent> <C-F> :MyReGrep<CR>
" ***************************************************
"           myplugin/Calendar
" ***************************************************
"let g:calendar_diary=<PATH>
let g:calendar_focus_today = 1
let g:calendar_weeknm = 1 " WK01
nnoremap <F12>   :Calendar<cr>
imap <C-F12>   <C-R>=strftime("<!-- Y%YM%mD%d %X -->")<CR>
" ***************************************************
"       plasticboy/vim-markdown
" ***************************************************
" Set on textwidth when in markdown files
autocmd FileType markdown set textwidth=80

" ***************************************************
"       tpope/vim-fugitive
" ***************************************************
" Simple way to turn off Gdiff splitscreen
" works only when diff buffer is focused
if !exists(":Gdiffoff")
  command Gdiffoff diffoff | q | Gedit
endif
" ***************************************************
"       Valloric/YouCompleteMe
" ***************************************************
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf = 0
if (g:iswindows == 0)
    let g:ycm_server_python_interpreter = '/usr/bin/python2'
endif
let g:ycm_collect_identifiers_from_comments_and_strings = 1
nnoremap <leader>gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" sudo write
command -nargs=? Sudow :w !sudo tee %

" Make in vim
fun! SetMkfile()
  let filemk = "Makefile"
  let pathmk = "./"
  let depth = 1
  while depth < 4
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf

"command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10
command! -nargs=* Make let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10

" ***************************************************
"       terryma/vim-smooth-scroll
" ***************************************************
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
