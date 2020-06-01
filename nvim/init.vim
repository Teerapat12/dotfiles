"""""""""""""""""""
" plugin settings "
"""""""""""""""""""
set runtimepath^=~/.config/nvim

packadd minpac

call minpac#init()

" plugin manager
call minpac#add('k-takata/minpac', {'type': 'opt'})

" better than default
call minpac#add('liuchengxu/vim-better-default')

" editing
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('junegunn/vim-easy-align')

" completion/lint
call minpac#add('shougo/deoplete.nvim', {'do': 'UpdateRemotePlugin'})
call minpac#add('dense-analysis/ale')

" utilities
call minpac#add('preservim/nerdtree')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('junegunn/fzf', {'do' : { -> fzf#install() } })
call minpac#add('junegunn/fzf.vim')

" motion
call minpac#add('ludovicchabant/vim-gutentags')
call minpac#add('majutsushi/tagbar')

" visualization
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('yggdroot/indentline')
call minpac#add('airblade/vim-gitgutter')

" session
call minpac#add('kassio/neoterm')

" python
call minpac#add('deoplete-plugins/deoplete-jedi')
call minpac#add('davidhalter/jedi-vim')
call minpac#add('sbdchd/neoformat')

" scala
call minpac#add('ktvoelker/sbt-vim')
call minpac#add('derekwyatt/vim-scala')

" convenient update commands
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()


"""""""""""""""""
" base settings "
"""""""""""""""""
" most essential functionalities are already in place thanks to
" 'vim-better-default'

" set default shell to local
set shell=$SHELL

" python config
let g:python3_host_prog = expand('~/.pyenv/versions/neovim/bin/python')

" set leader to space
let mapleader="\<Space>"

" no highlighted, insensitive-case search
set nohlsearch
set ignorecase
set smartcase

" split windows right and below
set splitright
set splitbelow

" show sign column
set signcolumn=yes

""""""""""""""""""""""""""""
" bingdings and remappings "
""""""""""""""""""""""""""""

" page up/down with center
nnoremap <C-u> <S-up>zz
nnoremap <C-d> <S-down>zz

" center the screen when search is found
nnoremap n nzzzv
nnoremap N Nzzzv

" repeat . on selected line
vnoremap . :normal .<CR>

" buffer navigation
noremap <silent> [b :bprevious<CR>
noremap <silent> ]b :bnext<CR>
noremap <silent> [B :bfirst<CR>
noremap <silent> ]B :blast<CR>

" switching windows
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h

" shortcuts for spliting windows
noremap <leader>hs :<C-u>split<CR>
noremap <leader>vs :<C-u>vsplit<CR>

" tab navigation
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" copy/paste/cut to system clipboard
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>
if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" move selected lines around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" alias to current directory path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"""""""""""""""""""
" plugin settings "
"""""""""""""""""""

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.scala = ['buffer', 'tags', 'omni']
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala = ['[^. *\t0-9]\.\w*',': [A-Z]\w', '[\[\t\( ][A-Za-z]\w*']
let g:deoplete#sources#jedi#server_timeout = 60

let g:ale_linters = {
      \ 'python': ['flake8'],
      \ 'scala': ['scalastype']
      \}
let g:ale_python_mypy_options = "–ignore-missing-imports"
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_conceallevel = 2
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" nerdtree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" nerdtree mapping
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
" open nerdtree when starting with directort
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" close if the window left open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" toggle tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" shortcuts for git
noremap <leader>ga :Gwrite<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gsh :Gpush<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gvdiff<CR>
noremap <leader>gr :Gremove<CR>

" fzf
let $FZF_DEFAULT_COMMAND="find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif
" fzf mapping
nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>H :Helptags!<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>F :GFiles<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>l :Blines<CR>
nnoremap <silent> <leader>L :Lines<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>/ :Rg<CR>
nnoremap <silent> <leader>C :Commands<CR>
nnoremap <silent> <leader>M :Maps<CR>
nnoremap <silent> <leader>s :Filetypes<CR>

" neoterm
let g:neoterm_shell='zsh'
let g:neoterm_eof='\r'
let g:neoterm_default_mod='vertical'
nnoremap <leader><cr> :TREPLSendLine<cr>j
vnoremap <leader><cr> :TREPLSendSelection<cr>

" Neoformat
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#goto_assignments_command = '<leader>g'
let g:jedi#goto_definitions_command = '<leader>d'
let g:jedi#documentation_command = 'K'
let g:jedi#usages_command = '<leader>n'
let g:jedi#rename_command = '<leader>r'
let g:jedi#show_call_signatures = '0'
let g:jedi#completions_command = '<C-Space>'
let g:jedi#smart_auto_mappings = 0

" airline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#gutentag#enabled = 1
let g:airline_skip_empty_sections = 1
set noshowmode

" gutentag
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
" Clear Gutentags cache
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

