""""""""""""""""""""""""""""""""""""""""""""""""""""
" 用于判断平台的函数，由于下面会用到，所以把函数放在
" 顶部，因为vim的配置是一个顺序读取的脚本。
""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MySys()
    if has("win32")
        return "windows"
    else
        return "linux"
    endif
endfunction

function! SwitchToBuf(filename)
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        exec "tabnew " . a:filename
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set mapleader
let mapleader = ","
let g:mapleader = ","
set history=700
filetype plugin on
filetype indent on

set autoread
" Fast Saving
nmap <leader>w :w!<cr>
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7

set wildmenu

set ruler

set cmdheight=2

set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

set hlsearch
set incsearch
set nolazyredraw

set magic

set showmatch
set mat=2

set noerrorbells
set novisualbell

"colorschem two2tango

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

" Persistent undo
try
    if MySys() == "windows"
        set undodir=C:\Windows\Temp
    else
        set undodir=~/.vim_runtime/undodir
    endif
catch
endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai
set si
set wrap

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project, Session related setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable("workspace.vim")
    source workspace.vim
endif
if filereadable("tags")
    set tags=tags
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快速修改.vimrc文件的配置
""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == 'linux'
    map <silent> <leader>ss :source ~/.vimrc<cr>
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    set helplang=cn
    map <silent> <leader>ss :source ~/_vimrc<cr>
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key setting 
""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>j <C-W><C-J>
nmap <leader>k <C-W><C-K>
nmap <leader>h <C-W><C-H>
nmap <leader>l <C-W><C-L>
nmap <leader>n :tabn<cr>
nmap <leader>p :tabp<cr>
nmap <leader>c :tabc<cr>
nmap <leader>u <C-W><C-H><C-W><C-K>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
" 这时华丽的查检分界线，下面的配置都为各个查检的配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist plugin setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == "windows"
    let Tlist_Ctags_Cmd = 'ctags'
elseif MySys() == "linux"
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif

let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 1
let Tlist_Process_File_Always = 1

map <silent> <F9> :TlistToggle<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" BufExplorer setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy='mru'
let g:bufExplorerSplitRight = 0
let g:bufExplorerSplitVertical = 1
let g:bufExplorerSplitVertSize = 30
let g:bufExplorerUseCurrentWindow = 1
autocmd BufWinEnter \[Buf\ List\] setl nonumber

""""""""""""""""""""""""""""""""""""""""""""""""""""
" WinManager setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "BufExplorer|FileExplorer"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lookupFile_MinPatLength = 2
let g:lookupFile_PreserveLastPattern = 0
let g:lookupFile_PreservePatternHistory = 1
let g:lookupFile_AlwaysAcceptFirst = 1
let g:lookupFile_AllowNewFiles = 0
if filereadable("./tags")
    let g:lookupFile_TagExpr = '"./tags"'
endif

nmap <silent> <leader>lk :LUTags<cr>
nmap <silent> <leader>ll :LUBufs<cr>
nmap <silent> <leader>lw :LUWalk<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动补全设置
""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <C-J>   pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
inoremap <expr> <C-K>   pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>   pumvisible()?"\<C-E>":"\<C-U>"
inoremap <C-]>      <C-X><C-]>
inoremap <C-F>      <C-X><C-F>
inoremap <C-D>      <C-X><C-D>
inoremap <C-L>      <C-X><C-L>
