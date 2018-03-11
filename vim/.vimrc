let skip_defaults_vim=1

" ---- Plug {{{
runtime vim-plug/plug.vim

call plug#begin('~/.vim/plugged')

" themes
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'chriskempson/base16-vim'
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'

" interface
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'bimlas/vim-high'
Plug 'edkolev/tmuxline.vim'
Plug 'majutsushi/tagbar'

" util
Plug 'junegunn/fzf', {'dir': '~/.local/src/fzf', 'do': './install --bin'}
Plug 'scrooloose/nerdtree'
Plug 'embear/vim-localvimrc'
Plug 'thaerkh/vim-workspace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jpalardy/vim-slime'

" edit
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-expand-region'
Plug 'editorconfig/editorconfig-vim'

" prog
Plug 'w0rp/ale'
Plug 'tpope/vim-dispatch'

" lang
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

" install missing plugins
autocmd VimEnter *
    \   if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \ |     PlugInstall --sync | q
    \ | endif

"}}}
" ---- Functions {{{

" set the colorscheme highlight values
function! SetHighlight()
    "highlight GitGutterAdd ctermfg=2 ctermbg=none
    "highlight GitGutterChange ctermfg=3 ctermbg=none
    "highlight GitGutterDelete ctermfg=1 ctermbg=none
    "highlight GitGutterChangeDelete ctermfg=3 ctermbg=none
endfunction

" commands
command! ToggleSyntax
\   if exists("g:syntax_on")
\ |     syntax off
\ | else
\ |     syntax enable
\ | endif

command! -nargs=1 -complete=dir FilesNoVCS
\   let s:cmd = g:ctrlp_user_command
\ | let b:ctrlp_user_command = g:files_find_no_vcs_cmd
\ | CtrlP <q-args>
\ | let b:ctrlp_user_command = s:cmd

command! -nargs=1 -complete=dir Files
\   call fzf#run(fzf#wrap('files', {
\                         'source': g:fzf_files_source,
\                         'dir': <q-args>}, 0))

command! Buffers
\   call fzf#run(fzf#wrap('buffers', {
\                         'source': map(range(1, bufnr('$')),
\                         'bufname(v:val)')}))

"}}}
" ---- Colours {{{
filetype plugin on
syntax enable

let g:seoul256_background = 233
let g:base16colorspace = 256
"set background=dark

" highlight options are under 'SetHighlight()'
autocmd ColorScheme * call SetHighlight()

let g:airline_theme='base16_spacemacs'
colorscheme base16-spacemacs

"}}}
" ---- Indentation {{{
set tabstop=4     " ts
set softtabstop=4 " sts
set expandtab     " et
set shiftwidth=4  " sw

augroup indent
    au!
    au FileType asm      setl noet ts=6 sw=6 sts=0
    au FileType make     setl noet ts=8 sw=8 sts=0
    au FileType go       setl noet
    au FileType *tex     setl tw=79
    au FileType markdown setl tw=79
    au FileType yaml     setl ts=2 sts=2 sw=2
augroup END

"}}}
" ---- Interface {{{
filetype indent on

set number " line numbers
set cursorline " highlight line under cursor
set laststatus=2 " open statusline

set noshowmatch " highlight matching bracket
set incsearch " search while typing
set hlsearch " highlight search

set splitbelow " open below instead of above

set mouse=a " mouse movement

"}}}
" ---- Keybinds {{{

let mapleader = "\<Space>"
let maplocalleader = "\\"

map Y y$
imap jk <esc>
xmap <Leader>+ <Plug>(expand_region_expand)
xmap <Leader>- <Plug>(expand_region_shrink)
nnoremap <C-w>- <C-w>s
nnoremap <C-w>\ <C-w>v

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <A-f> <S-Right>
cnoremap <A-b> <S-Left>

nmap <Leader>ea <Plug>(EasyAlign)
xmap <Leader>ea <Plug>(EasyAlign)

" not $MYVIMRC because of nvim
nmap <Leader>ce :edit ~/.vimrc<CR>
nmap <Leader>cr :source ~/.vimrc<CR>
nmap <Leader>cc :CtrlPClearCache<CR>

nmap <Leader>ff :CtrlP .<CR>
nmap <Leader>fF :FilesNoVCS .<CR>
nmap <Leader>fp :CtrlP<CR>
nmap <Leader>ft :NERDTreeToggle<CR>
nmap <Leader>fs :write<CR>
nmap <Leader>fS :wall<CR>

nmap <Leader>qq :qall<CR>
nmap <Leader>qs :wqall<CR>
nmap <Leader>qQ :qall!<CR>

map <Leader>j <Plug>(easymotion-prefix)

nmap <Leader>tn :set number!<CR>
nmap <Leader>tr :set relativenumber!<CR>
nmap <Leader>tc :ToggleSyntax<CR>
nmap <Leader>tl <Plug>(ale_toggle)
nmap <Leader>ts :ToggleWorkspace<CR>
nmap <Leader>th :TagbarToggle<CR>

nmap <Leader>w <C-w>

nmap <Leader>bb :CtrlPBuffer<CR>
nmap <Leader>bd :bdelete<CR>
nmap <Leader>b[ :1bprevious<CR>
nmap <Leader>b] :1bNext<CR>
nnoremap <BS> <C-^>
nmap <Leader>bR :edit<CR>

nmap <Leader>ll <Plug>(ale_lint)
nmap <Leader>li <Plug>(ale_detail)
nmap <Leader>l[ <Plug>(ale_previous_wrap)
nmap <Leader>l] <Plug>(ale_next_wrap)

nmap <Leader>ho :TagbarOpen j<CR>
nmap <Leader>hc :TagbarClose<CR>
nmap <Leader>hj :TagbarOpenAutoClose<CR>

nmap <silent> <Leader>sc :nohlsearch<CR>
nmap <Leader>st :CtrlPBufTag<CR>
nmap <Leader>sq :CtrlPQuickfix<CR>
nmap <Leader>sb :CtrlPBookmarkDir<CR>

xmap <C-c><C-c> <Plug>SlimeRegionSend
nmap <C-c><C-c> <Plug>SlimeParagraphSend
nmap <C-c>v <Plug>SlimeConfig

"}}}
" ---- Plugin Configuration {{{
augroup plugins
    au!
augroup END

" ale
let g:ale_sign_column_always = 1
let g:ale_sign_info = '-'
let g:ale_sign_warning = '*'
let g:ale_sign_style_warning = '>'
let g:ale_sign_error = '>'
let g:ale_sign_style_error = '>'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_save = 0
let g:ale_link_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_enabled = 0
let g:ale_linters = {
\   'rust': ['cargo'],
\   'bash': ['shellcheck'],
\   'sh':   ['shellcheck']
\}

" ctrlp
if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --hidden --color never -g "!.git/*"'
    let g:files_find_no_vcs_cmd = g:ctrlp_user_command . " --no-ignore"
elseif executable('ag')
    let g:ctrlp_user_command = 'ag %s -g "" --hidden --nocolor
                        \ --ignore ".git"'
    let g:files_find_no_vcs_cmd = g:ctrlp_user_command . " --skip-vcs-ignores"
elseif executable('find')
    let g:ctrlp_user_command = 'find %s'
endif

" delimitMate
let g:delimitMate_expand_cr = 1
augroup plugins
    au FileType *verilog let b:delimitMate_quotes = '"'
    au FileType matlab let b:delimitMate_quotes = '"'
augroup END

" local-vimrc
let g:localvimrc_name = ['.lvimrc', '_vimrc_local.vim']
let g:localvimrc_whitelist = $HOME.'/projects'

" polyglot
let g:polyglot_disabled = [
\   'latex',
\ ]

" vim-airline
" colour set under "Colours"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" vim-gitgutter
let g:gitgutter_override_sign_column_highlight = 0

" vim-high
let g:high_lighters = {
\   '_': {
\       'blacklist': ['help', 'qf', 'lf', 'vim-plug'],
\   },
\   'long_line': {},
\ }

" vim-pandoc
let g:pandoc#folding#level = 6
let g:pandoc#folding#fdc = 0

" vim-slime
let g:slime_no_mappings = 1
let g:slime_dont_ask_default = 1
let g:slime_paste_file = "$HOME/.slime_paste"
if !empty($TMUX)
    let g:slime_target = "tmux"
    let g:slime_default_config = {
    \   'socket_name': split($TMUX, ",")[0],
    \   'target_pane': ":.1"
    \ }
endif

" vim-workspace
let g:workspace_session_name = 'Session.vim'
let g:workspace_autosave = 0
let g:workspace_autosave_always = 0
let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave_ignore = [
\   'gitcommit',
\ ]

"}}}
" ---- Misc {{{
set modeline
set modelines=5

set hidden

set scrolloff=3

"}}}

" vim:foldmethod=marker:foldlevel=0
