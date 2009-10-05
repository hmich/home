" Basic settings
set runtimepath=~/.vim,$VIMRUNTIME
set showmode showcmd
set ruler autoread linebreak
set hidden gdefault number 
set virtualedit=all

" Jump to corresponding bracket
set showmatch

" Search options
set ignorecase smartcase wrapscan hlsearch incsearch 

" Backup settings
set backup backupdir=~/tmp

" Nice menu completion
set wildmenu
set wildmode=list:longest,full

"Ignore these files when completing names and in Explorer
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp

" Indentation options
set cindent expandtab shiftround
set shiftwidth=4 tabstop=4

" Usual backspace behaviour
set backspace=indent,eol,start

" Avoid welcome message
set shortmess+=I

" Maintain some context around the cursor
set scrolloff=5

" No bells for me
set vb t_vb=

" Characters for tabs and trailing spaces
set listchars=tab:>-,trail:-,eol:$

set clipboard+=unnamed
set laststatus=2
set display+=lastline

set lines=80
set columns=140

" GUI settings
set mousehide
set guioptions-=m
set guioptions-=T
set title
"set guifont=Lucida_Console:h11:cRUSSIAN
set guifont=Terminus\ 12,Courier_New:h10:cRUSSIAN
colorscheme ps_color
map <silent> <M-Space> :simalt ~<cr>

" I18N settings
set spelllang=ru,en
set langmenu=none
set langmap=éöóêåíãøùçõúôûâàïğîëäæıÿ÷ñìèòüáş;qwertyuiop[]asdfghjkl\;'zxcvbnm\,.,ÉÖÓÊÅHÃØÙÇÕÚÔÛÂÀÏĞÎËÄÆİß×ÑÌÈÒÜÁŞ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>
set isk=@,48-57,_
language C

" Program editing
" set makeprg=nmake
set tags=.\tags,.\..\tags,.\**\tags
set cinoptions+=,:0,l1,g0
set formatoptions+=roc

" Syntax highlighting
syntax enable
filetype plugin indent on

" Keybindings
map <A-Down> gj
map <A-Up> gk
imap <A-Down> <Esc>gji
imap <A-Up> <Esc>gki

imap <silent> <F2> <C-O>:w<cr>
map <silent> <F2> :w<cr>
imap <silent> <C-S> <C-O>:w<cr>
map <silent> <C-S> :w<cr>
map <silent> <F5> :!%:r<cr>
map <silent> <F7> :w<cr>:make<cr>
map <silent> <F9> :clist<cr>
map <silent> <F10> :cprev<cr>
map <silent> <F11> :cnext<cr>

let mapleader = ","
nmap <silent> <leader>e :Se .<cr>
nmap <silent> <leader>n :silent :nohlsearch<cr>
nmap <silent> <leader>m :e Makefile<cr>
nmap <silent> <leader>s :source $HOME/.vimrc<cr>
nmap <silent> <leader>v :e $HOME/.vimrc<cr>
nmap <silent> <leader>l :set nolist!<cr>
nmap <silent> <leader>b :FuzzyFinderBuffer<cr>
nmap <silent> <leader>f :FuzzyFinderFile<cr>
nmap <silent> <leader>d :FuzzyFinderDir<cr>

map <silent> <ESC><ESC> :q<cr>

" Buffer cycling
" map <silent> <Tab> :bnext<cr>
" map <silent> <S-Tab> :bprevious<cr>
" map <silent> <C-Tab> <C-^>

func! CppSettings()
    "map <F7> :setlocal makeprg=cl\ /EHsc\ %<cr>:w<cr>:make<cr>
    "map <C-F7> :setlocal makeprg=cl\ /EHsc\ -O2\ %<cr>:w<cr>:make<cr>
    iab <buffer> ll long long
    iab <buffer> dbl double
    iab <buffer> vi vector< int >
    iab <buffer> vd vector< double >
    iab <buffer> vs vector< string >
    iab <buffer> vvi vector< vector< int > >
    iab <buffer> vvd vector< vector< double > >
    iab <buffer> vll vector< long long >
    iab <buffer> pii pair< int, int >
endfunc

func! TexSettings()
    compiler tex
    setlocal makeprg=latex\ --interaction=nonstopmode\ report.tex
    map <buffer><silent><C-f3> :!start yap report.dvi<cr> 
endfunc

" Filetype specific options
au FileType tex call TexSettings()
au FileType lua setlocal makeprg=lua\ %
au FileType cpp call CppSettings()
au FileType make set noet
au BufEnter *.pl compiler perl
" au BufEnter *.hs compiler ghc

" au GUIEnter * simalt ~ 
" au BufEnter * lcd %:p:h
"au BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'
" au VimEnter * tab all 

" Standart extensions
source $VIMRUNTIME/ftplugin/man.vim
source $VIMRUNTIME/macros/matchit.vim

function! DiffWithFileFromDisk()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    exec 'saveas! '.diffname
    diffthis
    vsplit
    exec 'edit '.filename
    diffthis
endfunction

nmap <F6> :call DiffWithFileFromDisk()<cr>
