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
call minpac#add('ervandew/supertab')
call minpac#add('sbdchd/neoformat')

" completion/lint
call minpac#add('shougo/deoplete.nvim', {'do': 'UpdateRemotePlugin'})
call minpac#add('dense-analysis/ale')

" utilities
call minpac#add('tpope/vim-vinegar')
call minpac#add('mbbill/undotree')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('junegunn/fzf', {'do' : { -> fzf#install() } })
call minpac#add('junegunn/fzf.vim')

" motion
call minpac#add('ludovicchabant/vim-gutentags')

" visualization
call minpac#add('gruvbox-community/gruvbox')
call minpac#add('itchyny/lightline.vim')

" session
call minpac#add('kassio/neoterm')

" python
call minpac#add('deoplete-plugins/deoplete-jedi')
call minpac#add('davidhalter/jedi-vim')

" scala
call minpac#add('ktvoelker/sbt-vim')
call minpac#add('derekwyatt/vim-scala')

" vim practice
call minpac#add('ThePrimeagen/vim-be-good')

" convenient update plugins commands
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

"""""""""""""""""
" base settings "
"""""""""""""""""
" most essential functionalities are already in place thanks to
" 'vim-better-default'

colorscheme gruvbox

" set default shell to local
set shell=$SHELL

" python config
let g:python3_host_prog = expand('~/.pyenv/versions/neovim/bin/python')

" set leader to space
let mapleader="\<Space>"

" no highlighted, insensitive-case search, smart indent
set nohlsearch
set ignorecase
set smartcase
set smartindent

" split windows right and below
set splitright
set splitbelow

" show sign column
set signcolumn=yes

""""""""""""""""""""""""""""
" bingdings and remappings "
""""""""""""""""""""""""""""

" center the screen when search is found
nnoremap n nzzzv
nnoremap N Nzzzv

" repeat . on selected line
vnoremap . :normal .<CR>

" shortcuts for spliting windows
noremap <leader>hs :<C-u>split<CR>
noremap <leader>vs :<C-u>vsplit<CR>
noremap <leader>ht :<C-u>split \| term<CR>
noremap <leader>vt :<C-u>vsplit \| term<CR>

" tab navigation
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

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
" better default

let g:vim_better_default_enable_folding = 0
let g:vim_better_default_persistent_undo = 1
let g:vim_better_default_fold_key_mapping = 0

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

let g:ale_linters = {
            \ 'python': ['flake8'],
            \ 'scala': ['scalastype']
            \}
let g:ale_python_mypy_options = "–ignore-missing-imports"
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'

" undotree
nnoremap <leader>ut :UndotreeShow<CR>

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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
set grepprg=rg\ --vimgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
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

" lightline
let g:lightline = {
            \ 'colorscheme': 'jellybeans',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ],]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead',
            \ },
            \ }
set noshowmode

" gutentag
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = ['--options=tagsrc']
" Clear Gutentags cache
command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

