" Sal's Vim config

" ================== PLUG.VIM ===================
" Plug.vim initialization (needs curl installed)
" ===============================================
if has("gui_win32")
    let plug_path  = "~/vimfiles/plugged"
    if empty(glob('~/vimfiles/autoload/plug.vim'))
      silent !curl -fLo ~/vimfiles/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    let plug_path = "~/.vim/plugged"
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif


" Install Plugins
call plug#begin(plug_path)
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'matze/vim-move'
    Plug 'terryma/vim-smooth-scroll'
    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-commentary'
    Plug 'raimondi/delimitmate'
    Plug 'yggdroot/indentline'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mileszs/ack.vim'
    " Appearance
    Plug 'brendonrapp/smyck-vim'
    Plug 'neutaaaaan/blaaark'
    Plug 'pgdouyon/vim-yin-yang'
    Plug 'Alvarocz/vim-northpole'
call plug#end()


" ================== APPEARANCE =================

    colorscheme yin
    set background=dark
    filetype indent plugin on
    syntax on
    set wildmenu
    set cmdheight=1
    set showcmd
    if has("gui_running")
        set guioptions-=T
        set guioptions-=e
        set guitablabel=%M\ %t
        if has("gui_win32")
            set guifont=Sauce_Code_Powerline:h9:cANSI:qDRAFT
        else
            set guifont=Source\ Code\ Pro\ for\ Powerline\ Light\ 10
        endif
    endif
    set relativenumber
    set nu
    set encoding=utf8
    set t_Co=256

" Highlight matching
    set matchpairs=(:),[:],{:},<:>

" Statusline
    set laststatus=2

    set statusline=
    set statusline+=%1*%3n%*                        "buffer number
    set statusline+=%2*\ %<%F                           "full path
    set statusline+=%3*%m                           "modified flag
    set statusline+=%5*%r                             "readonly flag
    set statusline+=%3*%{GitBranch()}                 "git branch
    set statusline+=%1*%=                             "right align
    set statusline+=%1*\ x%02B                        "hex value of char under cursor
    set statusline+=%4*\ %y                           "file format
    set statusline+=%4*\ %{&ff}\ %{&fenc?&fenc:&enc}  "file encoding and line endings
    set statusline+=%2*%4l:%-3v\ %L                   "line:col lines

" Statusline colors
    hi User1 ctermbg=black ctermfg=grey  guibg=black guifg=grey
    hi User2 ctermbg=black ctermfg=green guibg=black guifg=green
    hi User3 ctermbg=black ctermfg=yellow guibg=black guifg=green gui=BOLD
    hi User4 ctermbg=black ctermfg=blue  guibg=black guifg=red
    hi User5 ctermbg=black ctermfg=red   guibg=black guifg=red   gui=BOLD

" ===========================

" Lines of history
    set history=700

" Set to auto read when a file is changed from the outside
    set autoread

" No vi compatibility
    set nocompatible
    filetype plugin on

" Indentation, 4 spaces instead of tabs
    set autoindent
    set smartindent
    set wrap
    set nostartofline
    set expandtab
    set smarttab
    set shiftwidth=2
    set tabstop=2
    set textwidth=119

" Show whitespace
    set listchars=tab:»\ ,space:·

" Indent Line
    let g:indentLine_char = '|'

" Save buffers on change
    set autowriteall

" Let buffers retain their changes without being saved
    set hidden

" Enable mouse use
    if has('mouse')
        set mouse=a
    endif

" Performance on slow connections
    "set lazyredraw
    hi NonText cterm=NONE ctermfg=NONE

" Useful when searching
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch
    set wrapscan

" Keep undo history across sessions by storing it in a file
    if has('persistent_undo')
        call system('mkdir ~/.vim/undo')
        set undodir=~/.vim/undo/
        set undofile
        set undolevels=1000
        set undoreload=10000
    endif

" :Q alias for quitall!
    command Q execute "quitall!"

" :W alias for w!
    command W execute "w!"
    command Wq execute "w! | Q"


" =================== KEYBINDINGS ===================

" Tab indents >>, Shift+Tab indents <<
    nnoremap <Tab> >>_
    nnoremap <S-Tab> <<_
    inoremap <S-Tab> <C-D>
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

" Cut/Copy/Paste system clipboard with Ctrl-X/C/V
    vnoremap <silent> <C-x> "+d
    vnoremap <silent> <C-c> "+y
    vnoremap <silent> <C-b> :set paste<CR>"*p:set nopaste<CR>
    nmap <silent> <leader>p :set paste<CR>"*p:set nopaste<CR>

" Visual block selection with Alt+LeftClick and drag
    noremap <M-LeftMouse> <LeftMouse><Esc><C-V>
    noremap <M-LeftDrag> <LeftDrag>

" :bd mapped to Shift + Esc
    nmap <silent> <S-Esc> :bd <CR>

" Change Buffer with <leader>+n
    nnoremap <Leader>1 :1b<CR>
    nnoremap <Leader>2 :2b<CR>
    nnoremap <Leader>3 :3b<CR>
    nnoremap <Leader>4 :4b<CR>
    nnoremap <Leader>5 :5b<CR>
    nnoremap <Leader>6 :6b<CR>
    nnoremap <Leader>7 :7b<CR>
    nnoremap <Leader>8 :8b<CR>
    nnoremap <Leader>9 :9b<CR>

" Move between windows with Alt+Arrows
    nmap <silent> <A-Up> :wincmd k<CR>
    nmap <silent> <A-Down> :wincmd j<CR>
    nmap <silent> <A-Left> :wincmd h<CR>
    nmap <silent> <A-Right> :wincmd l<CR>

" Go back-and-forth between edit points
    nnoremap <silent> <A-Right> g,
    nnoremap <silent> <A-Left> g;

" Visual mode pressing * or # searches for the current selection
    vnoremap <silent> * :call VisualSelection('f')<CR>
    vnoremap <silent> # :call VisualSelection('b')<CR>

" F9 executes current python script
    command RunScript execute "!python3 %" !
    nmap <F9> :RunScript

" Vim-smooth-scroll
    noremap <silent> <PageUp> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <PageDown> :call smooth_scroll#down(&scroll, 0, 2)<CR>

" vim-sneak keybinding
    nmap s <Plug>Sneak_s
    nmap S <Plug>Sneak_S
    vmap s <Plug>Sneak_s
    vmap S <Plug>Sneak_S

" Toggle list whitespace
    nmap <silent> <F5> :set list!<CR>

" =================== PLUGINS ===================

" F2 toggles fzf
    map <silent> <F2> :Files<CR>
    let g:fzf_layout = { 'up': '~40%' }

" F3 shows up Ag
    map <silent> <F3> :Ag<CR>

    let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
    let g:ale_linters = {'vue': ['eslint', 'vls']}
    let g:ale_fix_on_save = 1

" =============== USEFUL FUNCTIONS ==============

" Returns true if paste mode is enabled, needed for status line
    function! HasPaste()
        if &paste
            return 'PASTE MODE  '
        en
        return ''
    endfunction

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
    func! DeleteTrailingWS()
      exe "normal mz"
      %s/\s\+$//ge
      exe "normal `z"
    endfunc
    autocmd BufWrite * :call DeleteTrailingWS()

" Visual Selection
    function! VisualSelection(direction) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

" Return empty string or branch name
    function! GitBranch()
        let branch = fugitive#head()
        if branch == ''
            return ''
        else
            return ' ('.branch.') '
        endif
    endfunction


