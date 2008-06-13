" Basic settings
set runtimepath=~/.vim,$VIMRUNTIME
set nocompatible showmatch showmode showcmd
set ignorecase smartcase wrapscan incsearch 
set cindent expandtab 
set ruler autoread linebreak
set wildmenu hidden gdefault number
set virtualedit=all
"set backup backupdir=c:\\backup
set shiftwidth=4 tabstop=4
set backspace=indent,eol,start
set shortmess+=I
set scrolloff=5 
set clipboard+=unnamed
set listchars=tab:>-,trail:-
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set vb t_vb=
set spelllang=ru,en
set foldmethod=syntax
set display+=lastline

" GUI settings
set mousehide
set guioptions-=m
set guioptions-=T
"set guifont=Lucida_Console:h11:cRUSSIAN
set guifont=Terminus\ 12,Courier_New:h10:cRUSSIAN
colorscheme ps_color
map <silent> <M-Space> :simalt ~<cr>

" I18N settings
set langmenu=none
set langmap=éöóêåíãøùçõúôûâàïğîëäæıÿ÷ñìèòüáş;qwertyuiop[]asdfghjkl\;'zxcvbnm\,.,ÉÖÓÊÅHÃØÙÇÕÚÔÛÂÀÏĞÎËÄÆİß×ÑÌÈÒÜÁŞ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>
set isk=@,48-57,_
language C

" Program editing
set makeprg=nmake
set tags=.\tags,.\..\tags,.\**\tags
set cinoptions+=,:0,l1,g0
set formatoptions+=roc
set path+=c:/Program\\\ Files/Microsoft\\\ Visual\\\ Studio\\\ 8/Vc/include
set path+=c:/Program\\\ Files/Microsoft\\\ Visual\\\ Studio\\\ 8/Vc/PlatformSDK/include
set path+=c:/Development/WINDDK/3790.1830/inc/ddk/wxp/

syntax enable
filetype plugin indent on

let g:haddock_browser="C:\\Program Files\\Opera\\Opera.exe"

" Keybindings
map <A-Down> gj
map <A-Up> gk
imap <A-Down> <Esc>gji
imap <A-Up> <Esc>gki

nmap :W :w
nmap :Q :q

imap <silent> <F2> <C-O>:w<cr>
map <silent> <F2> :w<cr>
imap <silent> <C-S> <C-O>:w<cr>
map <silent> <C-S> :w<cr>
map <silent> <F5> :!%:r<cr>
map <silent> <F7> :w<cr>:make<cr>
map <silent> <F9> :clist<cr>
map <silent> <F10> :cprev<cr>
map <silent> <F11> :cnext<cr>

map <silent> ,, :SBufExplorer<cr>
map <silent> ,e :Se .<cr>
map <silent> ,h :nohl<cr>
map <silent> ,m :tabe Makefile<cr>
map <silent> ,s :source $HOME/.vimrc<cr>
map <silent> ,v :tabe $HOME/.vimrc<cr>

map <silent> <ESC><ESC> :q<cr>

" Buffer cycling
" map <silent> <Tab> :bnext<cr>
" map <silent> <S-Tab> :bprevious<cr>
" map <silent> <C-Tab> <C-^>

" Tabs
nmap <C-S-tab> :tabprevious<cr> 
nmap <C-tab> :tabnext<cr> 
map <C-S-tab> :tabprevious<cr> 
map <C-tab> :tabnext<cr> 
imap <C-S-tab> <ESC>:tabprevious<cr>i 
imap <C-tab> <ESC>:tabnext<cr>i 
nmap <C-\> :tabnew<cr> 
imap <C-\> <ESC>:tabnew<cr>
nmap <C-c> :tabclose<cr> 
imap <C-c> <ESC>:tabclose<cr>


func! CppSettings()
    map <F7> :setlocal makeprg=cl\ /EHsc\ %<cr>:w<cr>:make<cr>
    map <C-F7> :setlocal makeprg=cl\ /EHsc\ -O2\ %<cr>:w<cr>:make<cr>
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
au FileType text setlocal textwidth 70
au FileType tex call TexSettings()
au FileType lua setlocal makeprg=lua\ %
au FileType cpp call CppSettings()
au FileType make set noet
au BufEnter *.pl compiler perl
" au BufEnter *.hs compiler ghc

" au GUIEnter * simalt ~ 
" au BufEnter * lcd %:p:h
"au BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'
au VimEnter * tab all 

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
