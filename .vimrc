set nocompatible
scriptencoding utf-8
" Need to set the leader before defining any leader mappings
let mapleader = "\<Space>"
let maplocalleader = ";"

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.
syntax sync minlines=256   " Makes big files slow
set synmaxcol=2048         " Also long lines are slow
set autoindent             " Indent according to previous line.
set smartindent            " Be smarter about indenting
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.

set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set ignorecase             " Ignore case in searching
set smartcase              " Do not ignore Uppercase
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set clipboard =unnamed     " Copy from external clipboard
set cursorline             " Find the current line quickly.
set cursorcolumn           " Find cursor quickly


set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set number                 " Show line number
set mouse       =a         " Enable mouse for 'all'
set formatoptions=cotqrn   " Smart comments
" row numbering
set number
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber  number
set textwidth   =120
set colorcolumn =80
set nojoinspaces           " Don't add extra space after ., !, etc. when joining
set wm =0                  " Wrap margin set to 0
set diffopt=filler,vertical
set ruler
set termguicolors
set t_Co=256

if exists("termguicolors")     " set true colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


" Dictionary
"set dictionary+=/usr/share/dict/words
"set complete+=k

" Linebreak
if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

"Wildmenu
set wildignore+=*.bak,*.~,*.info,*.swp,*.o,*.pyc,*.zip,*.tar,*.gz
set wildignorecase
set wildmenu
set wildmode=list:longest


if has('linebreak')
  let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif


"============ Mappings ===================
" Hard mode
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" Resize splits with arrows
nnoremap <Left> :vertical resize +2<cr>
nnoremap <Right> :vertical resize -2<cr>
nnoremap <Up> :resize -2<cr>
nnoremap <Down> :resize +2<cr>

" Editing
nnoremap <leader>s :w %<cr>
nnoremap <leader>S :wa<cr>
nnoremap <leader>q :q!<cr>

" Quick sourcing of the current file, allowing for quick vimrc testing
nnoremap <leader>sop :source %<cr>

" Swap 0 and ^. I tend to want to jump to the first non-whitespace character
" so make that the easier one to do.
nnoremap 0 ^
nnoremap ^ 0

" split line with S and remove any trailing space
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$

" use K to join current line with line above, just like J does with line below
nnoremap K kJ

"Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move between visual lines
nnoremap j gj
nnoremap k gk

" Split window
nnoremap <leader>es :sp<cr>
nnoremap <leader>ev :vsp<cr>

" Edit configs
nnoremap ,v  :e ~/.vimrc<cr>
nnoremap ,z  :e ~/.zshrc<cr>

"Toggle spell
noremap <F5> :setlocal spell! spelllang=en_us<CR>

"Buffers
nnoremap <leader>d :bd<cr>
nnoremap <leader>r :bd<cr>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Tab navigation
nnoremap <C-t> :tabedit<CR>
inoremap <C-t> <Esc>:tabedit<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap <C-t>d :tabclose<CR>

"============= Autocommand groups ============
augroup makestuff
    autocmd!
    autocmd filetype python nnoremap <F4> :w <bar> exec '!clear && python '.shellescape('%')<CR>
    autocmd filetype c nnoremap <F4> :w <bar> exec '!clear && gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
    autocmd filetype cpp nnoremap <F4> :w <bar> exec '!clear && g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
    autocmd filetype markdown nnoremap <F4> :w <bar> exec '!clear && pandoc '.shellescape('%').' -o '.shellescape('%:r').'.html && firefox '.shellescape('%:r').'.html'<CR>
augroup END


"=============== File stuff =====================
" Markdown
au BufNewFile,BufReadPost *.md,*.mdown,*.mkd,*.mkdn,*.markdown,*.mdwn set filetype=markdown


" For python
let python_highlight_all =1

" For html, css, js
au BufNewFile,BufRead *.js, *.html, *.css
        \ setlocal tb=2 sts=2 sw=2

" For c, cpp
au BufNewFile,BufRead *.c, *.cpp
        \ setlocal ts=2 sw=2 sts=2 expandtab

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "IndentWidth" : 2 }

" Show unicode
set conceallevel=2
set concealcursor=nvc
let g:tex_conceal=""


"=============== Character lists ================
set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set listchars+=eol:¬



"=============== Vim safety net ==================

set undofile   " Store changes in undo file

set noswapfile " No swap
set nobackup   " No backup"
set backupdir   =/home/morpheus/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =/home/morpheus/.vim/files/swap/
set updatecount =100
set undofile
set undodir =/home/morpheus/.vim/files/undo/
"set viminfo =/home/morpheus/.vim/files/info/viminfo/

" Enable code folding
if has('folding')
  if has('windows')
    set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
endif

" Enable folding with spacebar
nnoremap <space> za
vnoremap <space> zf

"================ Plugins ===============

filetype off    "required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-eunuch'
Plugin 'tmhedberg/SimpylFold'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'suan/vim-instant-markdown'
Plugin 'itchyny/lightline.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Yggdroot/indentLine'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'hdima/python-syntax'
Plugin 'tpope/vim-commentary'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
"Plugin 'ludovicchabant/vim-gutentags'
"Plugin 'majutsushi/tagbar'
Plugin 'jalvesaq/Nvim-R' 



" Colorschemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'morhetz/gruvbox'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'rakr/vim-one'
Plugin 'reedes/vim-colors-pencil'
Plugin 'sjl/badwolf'
Plugin 'w0ng/vim-hybrid'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" IndentLines
let g:indentLine_enabled = 1

" Syntastic
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '☢'
let g:syntastic_style_error_symbol = '✍'
let g:syntastic_style_warning_symbol = '✍'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height= 5

" ALE
let g:ale_fixers = {
    \ 'python': ['autopep8','remove_trailing_lines', 'autopep8', 'isort', 'yapf'],
    \}
let g:ale_linters = {
    \ 'python': ['flake8'],
    \}
let g:ale_completion_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '☢'
let g:ale_sign_style_error = '✍'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter= 0
nnoremap <leader>f :ALEFix<cr>

" Gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'

" Ycm
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_auto_trigger = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/.ycm_extra_conf.py'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_server_use_vim_stdout = 1
let g:ycm_python_binary_path = '/home/morpheus/programs/anaconda2/bin/python2'
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" Goto definition with F3
noremap <leader>g :YcmCompleter GoTo<CR>

" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
nnoremap <leader>ue :UltiSnipsEdit<cr>


" NerdTree
" Open NERDTree with Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" Close Vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP settings
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|_site|output)|(\.(swp|ico|git|svn|pyc))$'

"Vim-markdown
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Nvim R 
"  -- to have Nvim-R insert the assignment operator: <-
let R_assign_map = "--"

" set a minimum source editor width
let R_min_editor_width = 80

" make sure the console is at the bottom by making it really wide
let R_rconsole_width = 1000

" show arguments for functions during omnicompletion
let R_show_args = 1
"
" Don't expand a dataframe to show columns by default
let R_objbr_opendf = 0
"
" " Press the space bar to send lines and selection to R console
nnoremap <Space>p <Plug>RDSendSelection
nnoremap <Space>l <Plug>RDSendLinepress 



" Instant markdown
"let g:livedown_autorun = 0
"
" " should the browser window pop-up upon previewing
"let g:livedown_open = 1 
"
" " the port on which Livedown server will run
"let g:livedown_port = 1337
"
" " the browser to use
"let g:livedown_browser = "firefox"


" Vim-latex-live-preview
let g:livepreview_previewer = 'envince' 


"============== Colorschemes ============
set background=dark


"colorscheme hybrid
"colorscheme PaperColor
"let g:PaperColor_Theme_Options = {
"  \   'themset termguicolorse': {
"  \     'default.dark': {
"  \       'transparent_background': 0,
"  \       'override' : {
"  \         'color00' : ['#000000', '16'],
"  \         'linenumber_bg' : ['#080808', '232']
"  \       }
"  \     }
"  \   },
"  \   'language': {
"  \     'python': {
"  \       'highlight_builtins' : 1
"  \     },
"  \     'cpp': {
"  \       'highlight_standard_library': 1
"  \     },
"  \     'c': {
"  \       'highlight_builtins' : 1
"  \     }
"  \   }
"  \ }
"colorscheme one


"colorscheme jellybeans
"let g:jellybeans_use_term_italics = 1
"let g:jellybeans_use_lowcolor_black = 1

"colorscheme lucius
"let g:lucius_high_contrast =1
"let g:lucius_style ="dark"

"syntax enable
"colorscheme material-theme

let g:gruvbox_italicize_comments=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
let g:gruvbox_termcolors=256
"

"colorscheme moonfly
"let g:moonflySpellInverse=1
"let g:moonflyCursorColor=1
"
"let g:space_vim_dark_background = 234
"colorscheme space-vim-dark
"hi Comment cterm=italic

"colorscheme challenger_deep

"colorscheme badwolf
"" Make the gutters darker than the background.
"let g:badwolf_darkgutter = 1
"" Make the tab line darker than the background.
"let g:badwolf_tabline = 0


highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

"=============== Status line ==================

" Lightline {{{
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'challenger_deep',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '│', 'right': '│' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '●' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⊗' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⌥  '.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}
"
"set statusline=%t   " File name of the file in the buffer
"set statusline+=%m  " Modified flag
"set statusline+=%5{v:register} "Which active register
"set statusline+=%=  " Align to the right from now on
"set statusline+=[%{fugitive#head()}]   " Current branch
"set statusline+=\ \  " Blank space
"set statusline+=%y   " Type of file in the buffer
"set statusline+=%5l  " Current line
"set statusline+=,    " Comma
"set statusline+=%c   " Current Column
"set statusline+=/    " Slash
"set statusline+=%-5L " Total lines
"set statusline+=%p%% " Percentage through the file


"============== Abbreviations ===============
iabbrev flo float
iabbrev pri print
