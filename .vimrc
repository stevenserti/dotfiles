"--------------------------------------------------------------
" plugins
"--------------------------------------------------------------
let g:polyglot_disabled = ['v']
call plug#begin('~/.vim/plugins_by_vimplug')
Plug 'morhetz/gruvbox'                                                         " colorscheme
Plug 'itchyny/lightline.vim'                                                   " status line
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all --no-completion'} " fuzzy search in a dir
Plug 'junegunn/fzf.vim'                                                        " fuzzy search in a dir/buffers/files etc
Plug 'junegunn/vim-easy-align'                                                 " easy alignment of line fields
Plug 'vhda/verilog_systemverilog.vim', {'for': 'verilog_systemverilog'}        " Vim Syntax Plugin for Verilog and SystemVerilog
Plug 'antoinemadec/vim-verilog-instance', {'for': 'verilog_systemverilog'}     " Verilog port instantiation from port declaration
Plug 'antoinemadec/vim-highlight-groups'                                       " add words in highlight groups on the fly
Plug 'vim-scripts/vcscommand.vim'                                              " diff local CVS SVN and GIT files with server version
Plug 'tpope/vim-fugitive'                                                      " Git wrapper
Plug 'tpope/vim-surround'                                                      " easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-commentary'                                                    " comment stuff out
Plug 'tpope/vim-sensible'                                                      " vim defaults that (hopefully) everyone can agree on
Plug 'tpope/vim-repeat'                                                        " remaps '.' in a way that plygubs can tap into it
Plug 'sheerun/vim-polyglot', {'do': './build'}                    " a collection of language packs for Vim
if v:version >= 800
  Plug 'Shougo/deoplete.nvim'                                     " extensible and asynchronous completion for neovim/Vim8
endif
if !has('nvim')
  Plug 'roxma/nvim-yarp'                                          " needed by deoplete
  Plug 'roxma/vim-hug-neovim-rpc'                                 " needed by deoplete
endif
" filetype specific
Plug 'davidhalter/jedi-vim', {'for': 'python'}                    " jedi completion (python)
Plug 'zchee/deoplete-jedi', {'for': 'python'}                     " deoplete: add python support
call plug#end()

if empty(glob("~/.vim/plugins_by_vimplug"))
  PlugInstall
endif
"--------------------------------------------------------------

"--------------------------------------------------------------
" vim options
"--------------------------------------------------------------
if has('nvim')
  " TODO wait for NVIM support of clipboard=autoselect
  " in order to make mouse=a copy/paste work
  set clipboard+=unnamed
  set guicursor=               " fancy guiscursor feature are not working with Terminator
end
set nocompatible               " get rid of vi compatibility
set cscopetag                  "
setglobal tags-=./tags tags-=./tags; tags^=./tags;
set nobackup                   " don't keep a backup file
set textwidth=0                " don't wrap words by default
set wildmode=longest,list,full " wildchar completion mode
set hlsearch                   " highlight search
set expandtab                  " tab expand to space
set tabstop=3                  " number of spaces that a <Tab> in the file counts for
set shiftwidth=3               " number of spaces to use for each step of (auto)indent
set lazyredraw                 " no screen redrawing while executing macros, registers etc
"if exists("&relativenumber")
"  set relativenumber           " show the line number relative to the line with the cursor
"  set numberwidth=2            " number of columns to use for the line number
"endif
set number
set mouse=a                    " allow to resize and copy/paste without selecting text outside of the window
set title                      " change terminal title
set ttimeoutlen=50             " ms waited for a key code/sequence to complete. Allow faster insert to normal mode
set complete=.,w,b,u           " specifies how keyword completion works when CTRL-P or CTRL-N are used
set showcmd                    " in Visual mode the size of the selected area is shown
set ignorecase smartcase       " pattern with at least one uppercase character: search becomes case sensitive
runtime! ftplugin/man.vim      " allow man to be displayed in vim
runtime! macros/matchit.vim    " allow usage of % to match 'begin end' and other '{ }' kind of pairs
"-------------------------------------------------------------

set ttymouse=xterm              " Enables mouse click on large displays past 220th column (found online SS)
"--------------------------------------------------------------
" mappings
"--------------------------------------------------------------
nnoremap <silent> <leader>gs    :Gstatus<CR>
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  tnoremap <A-Left> <C-\><C-N><C-w>h
  tnoremap <A-Down> <C-\><C-N><C-w>j
  tnoremap <A-Up> <C-\><C-N><C-w>k
  tnoremap <A-Right> <C-\><C-N><C-w>l
endif
inoremap <A-Left>  <C-\><C-N><C-w>h
inoremap <A-Down>  <C-\><C-N><C-w>j
inoremap <A-Up>    <C-\><C-N><C-w>k
inoremap <A-Right> <C-\><C-N><C-w>l
nnoremap <A-Left>  <C-w>h
nnoremap <A-Down>  <C-w>j
nnoremap <A-Up>    <C-w>k
nnoremap <A-Right> <C-w>l
" add '.' support in visual mode
vnoremap . :<C-w>let cidx = col(".")<CR> :'<,'>call DotAtColumnIndex(cidx)<CR>
" save file as sudo
cmap w!! w !sudo tee > /dev/null %
nnoremap K :call DisplayDoc() <CR>
" use tjump instead of tag, query the user when multiple files match a tag
nnoremap <C-]> g<C-]>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" get rid of trailing spaces
nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
nnoremap <silent> <F4> :ToggleCompletion<CR>
nnoremap <silent> <F5> :HighlightGroupsAddWord 4 0<CR>
nnoremap <silent> <F6> :HighlightGroupsAddWord 6 0<CR>
nnoremap <silent> <S-F5> :HighlightGroupsClearGroup 4 0<CR>
nnoremap <silent> <S-F6> :HighlightGroupsClearGroup 6 0<CR>
nnoremap <silent> <C-F5> :HighlightGroupsAddWord 4 1<CR>
nnoremap <silent> <C-F6> :HighlightGroupsAddWord 6 1<CR>
nnoremap <silent> <C-S-F5> :HighlightGroupsClearGroup 4 1<CR>
nnoremap <silent> <C-S-F6> :HighlightGroupsClearGroup 6 1<CR>
nnoremap <silent> <F9> :set spell!<CR>
" paste avoiding auto indentation
set pastetoggle=<F12>
nnoremap <script> <silent> <unique> <Leader>be :Buffers<CR>
" open files directory
nmap <leader>ew :e    %:h <cr>
nmap <leader>es :sp   %:h <cr>
nmap <leader>ev :vsp  %:h <cr>
nmap <leader>et :tabe %:h <cr>
"--------------------------------------------------------------

"--------------------------------------------------------------
" appearance
"--------------------------------------------------------------
" lightline
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'myreadonly', 'relativepath', 'modified' ] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ],
    \                          [ 'percent' ],
    \                          [ 'detecttrailingspace', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'detecttrailingspace': 'DetectTrailingSpace'
    \ },
    \ }
" TODO: use expand to highlight trailing spaces in lightline
"    \ 'component_expand': {
"    \   'detecttrailingspace': 'DetectTrailingSpace'
"    \ },
"    \ 'component_type': {
"    \   'detecttrailingspace': 'error'
"    \ },

function! DetectTrailingSpace()
  if mode() == 'n'
    let save_cursor = getpos('.')
    call cursor(1,1)
    let search_result = search("  *$", "c")
    call setpos('.', save_cursor)
    return search_result ? "trailing_space" : ""
  else
    return ""
  endif
endfunction

set t_Co=256                " vim uses more colors
set background=dark
colorscheme gruvbox
"--------------------------------------------------------------

"--------------------------------------------------------------
" highlighting
"--------------------------------------------------------------
" highlight non breakable space
set list
set listchars=nbsp:?

" redefine Todo highlight group for more readability
highlight Todo term=standout cterm=bold ctermfg=235 ctermbg=167 gui=bold guifg=#282828 guibg=#fb4934

" highlight extra whitespace
highlight link CustomHighlight_TrailingSpace Todo
match CustomHighlight_TrailingSpace /\s\+$/
autocmd BufWinEnter * match CustomHighlight_TrailingSpace /\s\+$/
autocmd InsertEnter * match CustomHighlight_TrailingSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match CustomHighlight_TrailingSpace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" always highlight TODO and FIXME no matter the filetype
highlight link CustomHighlight_Warning Todo
augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('CustomHighlight_Warning', 'TODO\|FIXME', -1)
augroup END
"--------------------------------------------------------------

"--------------------------------------------------------------
" folding
"--------------------------------------------------------------
set foldmethod=indent
set nofoldenable
set foldnestmax=9
set foldlevelstart=9
nmap <silent> zi :call ToggleFoldEnable()<CR>
nmap <silent> zm :call NormalFoldCmd("zm")<CR>
nmap <silent> zM :call NormalFoldCmd("zM")<CR>
nmap <silent> zr :call NormalFoldCmd("zr")<CR>
nmap <silent> zR :call NormalFoldCmd("zR")<CR>
nmap <silent> zc :call NormalFoldCmd("zc")<CR>
nmap <silent> zC :call NormalFoldCmd("zC")<CR>
nmap <silent> zo :call NormalFoldCmd("zo")<CR>
nmap <silent> zO :call NormalFoldCmd("zO")<CR>

function NormalFoldCmd(cmd)
  if &foldenable == 0
    call ToggleFoldEnable()
  endif
  execute "unmap " .  a:cmd
  execute "normal " . a:cmd
  call lightline#update()
  execute "nmap <silent> " . a:cmd . " :call NormalFoldCmd(\"" . a:cmd . "\")<CR>"
endfunction

function! ToggleFoldEnable()
  let cur_foldlevel = &foldlevel
  set foldenable!
  if &foldenable
    " get max foldlevel and set foldcolumn accordingly,
    " min foldcolumn = 6
    execute "normal zR"
    let &foldcolumn = &foldlevel + 1
    if &foldcolumn < 6
      let &foldcolumn = 6
    endif
    " set back previous foldlevel, make sure it is in
    " [0:max(foldlevel)]
    if cur_foldlevel > &foldlevel
      let cur_foldlevel = &foldlevel
    endif
    let &foldlevel = cur_foldlevel
  else
    set foldcolumn=0
  endif
  call lightline#update()
endfunction
"--------------------------------------------------------------

"--------------------------------------------------------------
" completion
"--------------------------------------------------------------
" close preview window
au CompleteDone * pclose

" python
let g:deoplete#sources#jedi#python_path = 'python3'
let g:deoplete#sources#jedi#show_docstring = 1
let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0

command! ToggleCompletion call ToggleCompletion()
function ToggleCompletion()
  if deoplete#is_enabled()
    call deoplete#disable()
    echom "Deoplete disabled"
  else
    nnoremap <leader>g :call jedi#goto()<CR>
    " use TAB to complete
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ deoplete#manual_complete()
    function! s:check_back_space() abort "{{{
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
    call deoplete#enable()
    echom "Deoplete enabled"
  endif
endfunction

function! DisplayDoc()
  if &filetype == "python"
    let l:pydoc_stdout = system("pydoc3 " . expand('<cword>'))
    if l:pydoc_stdout[1:32] != "o Python documentation found for"
      Scratch | 0 put =l:pydoc_stdout | normal gg
      set ft=man
    endif
  elseif &filetype == "c"
    execute "Man 3 " . expand('<cword>')
  else
    execute "Man " . expand('<cword>')
  endif
endfunction
"--------------------------------------------------------------

"--------------------------------------------------------------
" verilog
"--------------------------------------------------------------
" add UVM tags
autocmd FileType verilog_systemverilog setlocal tags+=~/.vim/tags/UVM_CDNS-1.2


" map '-' to 'begin end' surrounding
autocmd FileType verilog_systemverilog let b:surround_45 = "begin \r end"

" verilog_systemverilog mappings
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>

" commentary
autocmd FileType verilog_systemverilog setlocal commentstring=//%s

let g:verilog_instance_skip_last_coma = 1
"--------------------------------------------------------------

"--------------------------------------------------------------
" cpp
"--------------------------------------------------------------
" override default indent based on plugin
autocmd FileType c,cpp setlocal shiftwidth=4

" Make opens a 3 line error window if any errors
command -nargs=* Make make <args> | cwindow 3
"--------------------------------------------------------------

"--------------------------------------------------------------
" terminal
"--------------------------------------------------------------
if has('terminal')
   tnoremap <Esc><Esc> <C-\><C-n>
   tnoremap <leader>vim          vim_server_open
   nnoremap <leader>tw :cd %:h<CR>:T<CR>
   nnoremap <leader>ts :cd %:h<CR>:TS<CR>
   nnoremap <leader>tv :cd %:h<CR>:TV<CR>
   nnoremap <leader>tt :cd %:h<CR>:TT<CR>
   command! T  call term_start(&shell, {"term_kill": "term", "term_finish": "close", "curwin": 1})
   command! TS call term_start(&shell, {"term_kill": "term", "term_finish": "close"})
   command! TV call term_start(&shell, {"term_kill": "term", "term_finish": "close", "vertical": 1})
   command! TT tab call term_start(&shell, {"term_kill": "term", "term_finish": "close"})
   " start vim server
   if exists('*remote_startserver') && has('clientserver') && v:servername == ''
      call remote_startserver('vim_server_' . getpid())
   endif
endif
"--------------------------------------------------------------

"--------------------------------------------------------------
" misc
"--------------------------------------------------------------
" redirection of vim commands in clipboard
command! -nargs=1 RediCmdToClipboard call RediCmdToClipboard(<f-args>)
function! RediCmdToClipboard(cmd)
  let a = 'redi @* | ' . a:cmd . ' | redi END'
  execute a
endfunction

" set ft=sh for *.bashrc files
" au BufNewFile,BufRead *.bashrc* call SetFileTypeSH("bash")

" simple gvim
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar

" repeat last change at a column index
function! DotAtColumnIndex(cidx)
  let a = a:cidx - 1
  execute "normal " . a . "l."
endfunction

" add command to open terminals
if has('nvim')
  command! -nargs=* T split | terminal <args>
  command! -nargs=* VT vsplit | terminal <args>
endif

augroup filetypedetect
    au BufRead,BufNewFile *.config setfiletype perl
    " associate *.config with perl filetype
augroup END
"--------------------------------------------------------------

" fzf grep and preview
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
nnoremap <silent> <leader>f     :Files<CR>
nnoremap <silent> <leader>g     :Ag<CR>

aug CSV_Editing
  au!
  au BufRead,BufWritePost *.csv :%ArrangeColumn
  au BufWritePre *.csv :%UnArrangeColumn
aug end

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end
