"Omni"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
"Bundle 'scrooloose/syntastic'
Bundle 'w0rp/ale'
Bundle 'altercation/vim-colors-solarized'
"Bundle 'jodosha/vim-godebug'
Bundle 'ternjs/tern_for_vim'
"Bundle 'python-mode/python-mode'

Bundle 'vim-syntastic/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'honza/vim-snippets'
Bundle 'mileszs/ack.vim'
Bundle 'vimwiki'
Bundle 'bufexplorer.zip'
Bundle 'pydoc.vim'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/indentpython.vim'
Bundle 'rkulla/pydiction'
Bundle 'nvie/vim-flake8'
Bundle 'vim-scripts/pylint.vim'
Bundle 'Chiel92/vim-autoformat'

" Go
Bundle 'fatih/vim-go'

" javascripts
Bundle 'leshill/vim-json'
Bundle 'tpope/vim-markdown'
"Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'othree/html5.vim'
Bundle 'lepture/vim-css'

" Hard to Install
"Bundle 'Valloric/YouCompleteMe'

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set number      "show line numbers

"display tabs and trailing spaces
"set list
set listchars=tab:>-,trail:-,nbsp:.,eol:$

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set maxmempattern=20000

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

"default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set copyindent " copy the previous indentation on autoindenting

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
"set mouse=a
"set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

set nobackup " no *~ backup files
"colors koehler
colors kolor
"syntax enable
"set background=dark
"colorscheme solarized
"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb18030,big5,latin1
if has('win32')
    source $VIMRUNTIME/mswin.vim
    behave mswin
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    "set fileformats=unix
    set guifont=Lucida_Console:h12:cANSI
endif

autocmd FileType ruby set expandtab | set softtabstop=2 | set shiftwidth=2

"statusline setup
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

"set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

set cursorcolumn
set cursorline

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40

"explorer mappings
nnoremap <f1> :BufExplorer<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TagbarToggle<cr>

" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

"source project specific config files
runtime! projects/**/*.vim

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

if has("cscope")
    "set csprg=/usr/bin/cscope
    set csprg=cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

" map CTRL-E to end-of-line (insert mode)
imap <C-e> <esc>$i<right>
" " map CTRL-A to beginning-of-line (insert mode)
imap <C-a> <esc>0i

" Disable completion previews with function prototypes, etc.
set completeopt=menu

let g:UltiSnipsSnippetDirectories=["snippets"]

let g:C_Ctrl_j   = 'off'

"let g:syntastic_c_checkers=['make', 'gcc']
" UltiSnips default to TAB, conflict with YCM, use C-j instead
"let g:UltiSnipsExpandTrigger="<c-j>"

" youcompleteme is still crappy for C++ if no ycm_extra_conf.py is used
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_confirm_extra_conf = 0

"let g:ycm_global_ycm_extra_conf='~/ycm_extra_conf.py'


" ale-setting {{{
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
"nmap <C-f> :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
"nmap <Leader>d :ALEDetail<CR>
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'css': ['stylelint'],
\   'c': ['clang'],
\   'csh': ['shell'],
\   'python': ['flake8'],
\   'go': ['golint', 'gofmt', 'go vet'],
\   'c++': ['clang'],
\}

let b:ale_fixers = {
            \'javascript': ['prettier', 'eslint'],
            \'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8'],
            \'go': ['gofmt'],
            \'css': ['stylelint'],
            \}
let g:ale_fix_on_save = 1
" }}}

"go
"autocmd FileType go nnoremap <C-f> :Autoformat<CR>:w<CR>
autocmd FileType go nnoremap <buffer> <C-d> :GoDef<cr>
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"eslint
let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1

" auto-formatter
"function! ESlintFormatter()
"    let l:npm_bin = ''
"    let l:eslint = 'eslint'
"    if executable('npm')
"        let l:npm_bin = split(system('npm bin'), '\n')[0]
"    endif
"    if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
"        let l:eslint = l:npm_bin . '/eslint'
"    endif
"    let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; ' . l:eslint . ' --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
"endfunction

let g:go_version_warning = 0

"go function refer support"
function! UpdateCscopeGo()
    !find . -name "*.go" > cscope.files
    !cscope -bkq -i cscope.files
endfunction
nmap <F4> :call UpdateCscopeGo()<CR>
autocmd FileType go map <C-f> :ALEToggle<CR>

"python function refer support"
function! UpdateCscopePython()
    !find . -name "*.py" > cscope.files
    !pycscope -i cscope.files
endfunction
nmap <F5> :call UpdateCscopePython()<CR>
autocmd FileType python nmap <C-d> :cs find g <C-d>=expand("<cword>")<CR><CR>
autocmd FileType python map <C-f> :ALEToggle<CR>
"python"
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 20
autocmd FileType python map <C-f> :ALEToggle<CR>
"autocmd FileType python noremap <buffer> <C-f> :call Autopep8()<CR>
"autocmd BufWritePost *.py call Autopep8()

"js
autocmd FileType javascript nnoremap <leader>d :TernDef<CR>
autocmd FileType javascript setlocal omnifunc=tern#Complete
let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
let g:formatters_javascript = ['eslint']
autocmd FileType javascript nnoremap <C-f> :Autoformat<CR>:w<CR>

let Tlist_Ctags_Cmd="/usr/local/bin/ctags"

"VimOrganizer
autocmd! BufRead,BufWrite,BufWritePost,BufNewFile *.org
autocmd  BufEnter *.org call org#SetOrgFileType() | set wrap
