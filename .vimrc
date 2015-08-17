let s:myvimdir ="~/.vim"

if !filereadable(expand(s:myvimdir . "/autoload/plug.vim"))
  echo "Installing Vim-Plug and plugins,"
  echo "restart Vim to finish installation."
  sil! call mkdir(expand(s:myvimdir . "/autoload"), 'p')
  sil! execute "!curl -fLo ".expand(s:myvimdir . "/autoload/plug.vim")
        \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction

""""""""""""""""""""
" User Plugins
""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
Plug 'rking/ag.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ARM9/arm-syntax-vim'
Plug 'benekastah/neomake'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/deoplete.nvim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-unimpaired'
Plug 'euclio/vim-markdown-composer', { 'for' : 'Markdown', 'do': function('BuildComposer') }
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'ehamberg/vim-cute-python', { 'branch' : 'moresymbols' }

call plug#end()

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
set clipboard+=unnamedplus

"stop annoying snap to top of block on yank
vmap y ygv<Esc>

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
nmap <Leader>[ <Plug>(EasyAlign)

"""""" ListToggle """""
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'


"""""" Git """"""
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>


"""""" Ag """"""
nnoremap <Leader>a :Ag 

let g:multi_cursor_quit_key='<C-j>'

""""" ARM9 Syntax """"
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm= armv6/7ARM9/arm-syntax-vim

command! -range Vis call setpos('.', [0,<line1>,0,0]) |
                    \ exe "normal V" |
                    \ call setpos('.', [0,<line2>,0,0])

"""" Supertab """"
let g:SuperTabDefaultCompletionType = "<c-n>"

"""" Use deoplete """"
let g:deoplete#enable_at_startup = 1

""" Neomake """"
autocmd! BufWritePost * Neomake
let g:neomake_error_sign = {
            \ 'text': '❯❯',
            \ 'texthl': 'ErrorMsg',
            \ }
hi MyWarningMsg ctermbg=3 ctermfg=0
let g:neomake_warning_sign = {
            \ 'text': '❯❯',
            \ 'texthl': 'MyWarningMsg',
            \ }
let g:neomake_python_enabled_makers = ['pep8']
let g:neomale_c_enabled_makers = ['clang']
