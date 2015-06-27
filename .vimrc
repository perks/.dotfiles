set nocompatible	" required
filetype off  " required

" set runtimepath to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

""""""""""""""""""""
" User Plugins
""""""""""""""""""""
Plugin 'kien/ctrlp.vim'
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
"Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rking/ag.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'kristijanhusak/vim-multiple-cursors'
Plugin 'tpope/vim-markdown'
Plugin 'shime/vim-livedown'
Plugin 'othree/html5.vim'
Plugin 'morhetz/gruvbox'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'dahu/bisectly'
Plugin 'Valloric/YouCompleteMe'

" All plugins most be loaded by this point
call vundle#end()		" required
filetype plugin indent on	" required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


""""""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""""""
let mapleader=","
let localmapleader=","

map <Leader>/ :nohlsearch<cr>
:nnoremap <CR> :nohlsearch<CR>/<BS>
:inoremap jk <ESC>    " Easy escape insert mode

" Toggles
"set pastetoggle=<F1>

"Auto toggle paste
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" set osx buffer to be same as Vims
set clipboard^=unnamed


" nmap for powerline feedback
nmap <silent> <F1>    :set invpaste<CR>
nmap          <F2>    :setlocal spell!<CR>
imap          <F2> <C-o>:setlocal spell!<CR>
" Movement across splits
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Resize window splits
" TODO Fix mousewheel
nnoremap <Up>    3<C-w>-
nnoremap <Down>  3<C-w>+
nnoremap <Left>  3<C-w><
nnoremap <Right> 3<C-w>>

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

nnoremap <C-w>s :echo "Use _"<CR>
nnoremap <C-w>v :echo "Use \|"<CR>


" Buffer movement
map <silent> <C-J> :bnext<CR>
map <silent> <C-K> :bprev<CR>
map <silent> <C-\|> :bd<CR>

" Location list traversal
map <C-l>j :lnext<CR>
map <C-l>k :lprev<CR>

""""""""""""""""""""""""""""""
" Display Options
""""""""""""""""""""""""""""""
syntax on
set number
set encoding=utf-8
set list!		" Display unprintable characters
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«
if $TERM =~ '256color'
	set t_Co=256
elseif $TERM =~ '^xterm$'
	set t_Co=256
endif

"let g:rehash256=1
if !has("gui_running")
   let g:gruvbox_italic=0
endif
"set background=dark
colorscheme PaperColor
let g:airline_theme='papercolor'

""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""
filetype plugin indent on      " Filetype detection and custom file plugins + syntax
set hidden                     " Don't abandon buffers moved to the background
set wildmenu                   " Enhanced completion hints in the command line
set wildmode=list:longest,full " Complete longest common match and show possible and wildmenu
set backspace=eol,start,indent " Allow backspacing over indent, eol, start
set complete=.,w,b,u,U,t,i,d   " Scans for tab completion
set updatecount=100            " Write swap file to disk every 100 chars
set directory=~/.vim/swap      " Directory to use for swap file
set diffopt=filler,iwhite      " Diff mode ignores whitespace and align unchanged lines
set history=1000               " Remember 1000 commands
set scrolloff=3                " Start scrolling 3 lines before horizontal window border
set autochdir                  " Automatically cd into directory of file
set visualbell t_vb=           " Disable visual bells
set shortmess+=A               " Always edit file, even with swapfile
set ttimeoutlen=50
set lazyredraw

" Save/restore view on close/open (folds, cursor, etc)
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Change directory to open file
au BufEnter * if expand('%:p') !~ '://' | cd %:p:h | endif

" Save file on lose focus
au FocusLost * :wa

" After 4s inactivity, check external file modifications on next keypress
au CursorHold * checktime

" up/down on displayed lines, not real lines
noremap k gk
noremap j gj

"""""""""""""""""""""""""""""""""
" Formatting, Indentation, Tabbing
"""""""""""""""""""""""""""""""""
set autoindent smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=2
set textwidth=80
set formatoptions-=t formatoptions+=croql

""""""""""""""""""""""""""""""""
" Undo
""""""""""""""""""""""""""""""""
set undolevels=10000
if has("persistent_undo")
	set undodir=~/.vim/undo		" Allow undo to persist even after a file is closed
	set undofile
endif

"""""""""""""""""""""""""""""""
" Search settings
"""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

"""""""""""""""""""""""""""""""
" HTML settings
"""""""""""""""""""""""""""""""
let html_number_lines=1
let html_ignore_folding=1
let html_use_css=1
let xml_use_xhtml=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wild settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable image files
set wildignore+=*.psd,*.png,*.jpg,*.gif,*.jpeg

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*,*/tmp/*,.DS_Store

" Node and JS stuff
set wildignore+=*/node_modules/*,*.min.js

" WP Language files
set wildignore+=*.pot,*.po,*.mo

" Fonts and such
set wildignore+=*.eot,*.eol,*.ttf,*.otf,*.afm,*.ffil,*.fon,*.pfm,*.pfb,*.woff,*.svg,*.std,*.pro,*.xsf

"""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""
" TODO Merge the NERDTreeFind with Toggle inteilligently.
" nnoremap <C-g> :NERDTreeToggle<cr>
" let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                    " \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
" let NERDTreeHighlightCursorline=1
" let NERDTreeShowBookmarks=1
" let NERDTreeShowFiles=1

" " Put a space around comment markers
" let g:NERDSpaceDelims = 1

""""" Ctrl p """"""
let g:ctrlp_map = '<Leader>,'
map <Leader>. :CtrlPBuffer<CR>

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set directory
let g:ctrlp_working_path_mode = 'a'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif

if executable('matcher')
    let g:ctrlp_match_func = { 'match': 'GoodMatch' }

    function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

      " Create a cache file if not yet exists
      let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
      if !( filereadable(cachefile) && a:items == readfile(cachefile) )
        call writefile(a:items, cachefile)
      endif
      if !filereadable(cachefile)
        return []
      endif

      " a:mmode is currently ignored. In the future, we should probably do
      " something about that. the matcher behaves like "full-line".
      let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
      if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
        let cmd = cmd.'--no-dotfiles '
      endif
      let cmd = cmd.a:str

      return split(system(cmd), "\n")

    endfunction
  end 

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

"""""" Airline """"""
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"""""" Syntastic """"""
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['scss', 'html'] }
let g:syntastic_c_compiler = 'clang'
"" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
""Use jshint (uses ~/.jshintrc)
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'

"""""" Easy Motion """"""
map <Leader> <Plug>(easymotion-prefix)
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}
" Need one more keystroke, but on average, it may be more comfortable.
nmap t <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Find replace mappings
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)


"""""" Easy-Align """"""
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>l <Plug>(EasyAlign)


"""""" Git """"""
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>


"""""" Ag """"""
nnoremap <Leader>a :Ag 

let g:multi_cursor_quit_key='<C-j>'

