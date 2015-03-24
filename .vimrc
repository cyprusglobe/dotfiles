"let $PATH = '/Users/koder/usr/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bi iMproved
set nocompatible

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" required!
Bundle 'gmarik/vundle'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bundles from GitHub repos:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smartpairs 
Bundle 'gorkunov/smartpairs.vim' 

" Tmux navigation
Bundle 'derekprior/tmux-vim-select-pane'
Bundle 'christoomey/vim-tmux-navigator'

" Base16 color scheme
Bundle 'chriskempson/base16-vim'

" Airline
Bundle 'bling/vim-airline'

" Class/module browser
Bundle 'majutsushi/tagbar'

" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Bundle 'fisadev/vim-ctrlp-cmdpalette'

" Surround
Bundle 'tpope/vim-surround'

" Autoclose
"Bundle 'Townk/vim-autoclose'
Bundle 'Raimondi/delimitMate'

" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
Bundle 'kevinw/pyflakes-vim'

" Better you complete me
Bundle 'Valloric/YouCompleteMe'
Bundle 'marijnh/tern_for_vim'

" Git diff icons on the side of the file lines
Bundle 'airblade/vim-gitgutter'

" my fixes to nathanaelkane/vim-indent-guides
"Bundle 'sheldonwjones/vim-indent-guides'
Bundle 'Yggdroot/indentLine'

" javascript syntax and indent
Bundle "pangloss/vim-javascript"
Bundle "othree/javascript-libraries-syntax.vim"
Bundle "othree/html5.vim"

" mako template indentation and syntax
" Bundle "sophacles/vim-bundle-mako"

" Auto close html tags
Bundle "ervandew/sgmlendtag"

" local vim file support
Bundle "MarcWeber/vim-addon-local-vimrc"

" Git integration
Bundle 'motemen/git-vim'

" Less syntax
Bundle 'groenewege/vim-less'

" Snippet Manager
Bundle 'sirver/ultisnips'

" Supertab
Bundle 'ervandew/supertab'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bundles from vim-scripts repos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search results counter
Bundle 'IndexedSearch'

" XML/HTML tags navigation
Bundle 'vim-scripts/matchit.zip'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on

" allow qoutes to be shown in json

set conceallevel=0

" Set to auto read when a file is changed from the outside
set autoread

" Turn backup off
set nobackup
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs and spaces handling
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" tablength exceptions
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType mako setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Auto indent
set autoindent
set cino=:0,g0

" Don't Wrap lines
set nowrap

""Encoding
set encoding=utf8
try
    lang en_US
catch
endtry


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader key
let mapleader = ","

"Toggle line numbers
nnoremap <leader>n :set nu!<cr>

" Move between buffers
noremap <space> :bnext<cr>
noremap <s-space> :bprev<cr>
noremap <leader>. :tabnew<cr>

" Console-style navigation
inoremap <C-a> <home>
inoremap <C-e> <end>
nnoremap <C-a> 0
nnoremap <C-e> $

" Toggle line numbers
nnoremap <leader>n :set nu!<cr>

" Folding
nnoremap f za
nnoremap F zA
nnoremap <C-f> :call ToggleFold()<CR>

function! ToggleFold()
    if !exists("b:folded")
        let b:folded = 1
    endif
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
        if (&ft=='python')
            :set foldlevel=1
        endif
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

" Switch CWD based on current file
nnoremap <leader>cd cd %:p:h<CR>
"Switch CWD based on current file only for current buffer
nnoremap <leader>lcd lcd %:p:h<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd FileType python IndentLinesToggle
" Override pymod's show numbers option
autocmd FileType python set nonumber
autocmd FileType python set colorcolumn=81
autocmd FileType python set foldlevel=1

"Refresh syntax highlighting when buffer is entered or written
autocmd BufEnter * syntax sync fromstart
autocmd BufWritePost * syntax sync fromstart

" Have Vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif "

"Html files are sometimes Mako files
" autocmd BufEnter,BufNewFile *.html set ft=mako.html.javascript

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set terminal title
set title

" Show the cursor column and cursor line
set cursorcolumn
set cursorline

" When scrolling, keep cursor 5 lines away from screen border
set scrolloff=5

" Turn on Wild Menu
set wildmenu

"Ignore some files
set wildignore+=*.jpg,*.gif,*.png,*.hdr,*.gz,*.ico
set wildignore+=*.o,*.obj,*.so,*.a,*.dll,*.dylib
set wildignore+=.DS_*,*.db,*.bak,.cache,*.lock
set wildignore+=*.svn,*.git,*.swp,*.pyc,*.class,*/__pycache__/*
set wildignore+=*.egg-info*,jquery*,taghl*,*.taghl,.ropeproject,tags
set wildignore+=node_modules,.gitkeep
set wildignore+=platforms,plugins

" Change buffer without saving
set hidden

" Set backspace to work in more situations
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase
set infercase

" Use case-sensitive search if a capital letter is present
set smartcase

" Incremental search
set incsearch

" Don't Highlighted search results
set nohlsearch

"Turn off all sound on errors
set noerrorbells
set novisualbell
set vb t_vb=

" Show matching brackets
set showmatch

" How many tenths of a second to blink
set mat=2

" syntax highlight on
syntax on

if has("gui_running")
    set guifont=Sauce\ Code\ Powerline\ Light:h14
    "Remove a lot of visual effects like scrollbar/menu/tabs from GUI
    set guioptions=a
else
    let base16colorspace=256
    set t_Co=256
endif



" Always show status bar
set ls=2

" Always show current position
set ruler

" Don't show line number
set nonumber

"Set background to dark
set background=dark

" color scheme
colorscheme base16-default

"
" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest,full

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Tmux Navigation
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Airline
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme = 'base16'
    let g:airline#extensions#tabline#fnamemod = ':~:.'
    let g:airline#extensions#whitespace#enabled = 0

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => python-mode
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:pymode_breakpoint = 0
    let g:pymode_lint_hold = 1
    let g:pymode_lint_ignore = "E501"
    let g:pymode_lint_onfly = 0
    let g:pymode_lint_checker = "pep8"
    let g:pymode_lint_cwindow = 0
    let g:pymode_options_other = 0
    let g:pymode_rope = 0
    let g:pymode_rope_completion = 0
    let g:pymode_rope_complete_on_dot = 0



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " => vim-indent-guides
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "if !has("gui_running")
    "    let g:indent_guides_auto_colors = 0
    "    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=19
    "    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=18
    "endif
    "let g:indent_guides_enable_on_vim_startup = 0
    "let g:indent_guides_start_level = 2
    "let g:indent_guides_guide_size = 1
    "let g:indent_guides_color_change_percent = 10
    "let g:indentLine_char = '┆'
    "let g:indentLine_fileTypeExclude = ['text', 'sh', 'javascript']
    let g:indentLine_fileType = ['javascript']
    let g:indentLine_faster = 1
    "let g:indentLine_noConcealCursor = 0


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Ctrl-P settings
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_match_window_reversed = 0
    let g:ctrlp_max_height = 20
    let g:ctrlp_use_caching = 0
    nnoremap <leader>f :CtrlP<cr>
    nnoremap <leader>d :CtrlP %:h<cr>
    nnoremap <leader>v :CtrlP views<cr>
    nnoremap <leader>m :CtrlP models<cr>
    nnoremap <leader>t :CtrlP templates<cr>
    nnoremap <leader>p :CtrlP panels<cr>
    nnoremap <leader>j :CtrlP js<cr>
    nnoremap <leader>o :CtrlPMRUFiles<cr>
    nnoremap <leader>b :CtrlPBuffer<cr>

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => javascript-libraries-syntax.vim
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:used_javascript_libs = 'underscore,jquery,angularjs'

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Autoclose
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Fix to let ESC work as espected with Autoclose plugin
    let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => TagBar
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:tagbar_autofocus = 1
    nnoremap <silent> <S-t> :TagbarOpenAutoClose<CR>

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Syntastic
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Ultisnips
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"

