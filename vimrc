set nocompatible

set clipboard=unnamed

call pathogen#infect()
syntax on
filetype plugin indent on
set runtimepath+=~/.vim/bundle/ultisnips
set number
set ruler
syntax on
set encoding=utf-8
"let g:html_indent_inctags = "body,head,tbody,ul,li,p,script"
let g:html_indent_style1 = "inc"
let g:html_indent_script1 = "inc"
set hidden
let mapleader = ","
set cursorline
set history=1000
set viminfo='100,f1
highlight RSpecFailed guibg=#671d1a
map <Leader>] :call MakeGreen()<CR>
autocmd BufNewFile,BufRead *_spec.rb compiler rspec
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
let g:HammerQuiet=1
" Whitespace stuff
set wrap
set scrolloff=3
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*

" make uses real tabs
au FileType make 	set noexpandtab

" Status bar
set laststatus=2
" set statusline=%<%f\ %h%m%r%%=%-14.(%l,%c%V%)\ %P
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{exists('g:loaded_rvm')?rvm#statusline():''}%{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" Fix issues with the shell and fugitive
set shell=bash

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,Procfile,config.ru}    set ft=ruby

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype

filetype plugin indent on
set fdl=999
au! BufRead,BufNewFile *.json set filetype=json foldmethod=syntax 
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-K> [e
nmap <C-J> ]e
" Bubble multiple lines
vmap <C-K> [egv
vmap <C-J> ]egv

" ZoomWin 
map <Leader><Leader> :ZoomWin<CR>

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

"spell check when writing commit logs
autocmd filetype svn,*commit* set spell

let g:EasyMotion_leader_key = '<Leader>m'
map <leader>g :Gstatus<cr>
" Presing jj get back to normal mode
inoremap jj <esc>

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Directories for snippets
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/ultisnips/UltiSnips"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" Default color scheme

set background=dark

" Detect if we're running a 256 colors terminals
" PuTTY - putty-256color
" rxvt - rxvt-256color
" Eterm - Eterm-256color
" Konsole - konsole-256color
" XFCE's Terminal - gnome-256color
" more details here : http://vim.wikia.com/wiki/256_colors_in_vim
set t_Co=256
if matchstr(&t_Co, '256')
  color Tomorrow-Night
else
  color desert
endif

command Todo Ack TODO
if has("mouse")
  set mouse=a
endif

"map <Leader>o :call RunCurrentLineInTest()<CR>
"map <Leader>p :call RunCurrentTest()<CR>
map <Leader>d obinding.pry<esc>:w<cr>
map <Leader>gs :Gstatus<CR>
map <Leader>f :call OpenFactoryFile()<CR>
map <Leader>gc :Gcommit -m ""<LEFT>
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...
set formatoptions-=or
au BufWritePre *.rb :%s/\s\+$//e

function! OpenFactoryFile()
  if filereadable("test/factories.rb")
    execute ":sp test/factories.rb"
  else
    execute ":sp spec/factories.rb"
  end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt) modified to use gitmove
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':Gmove ' . new_name
    endif
endfunction
map <leader>n :call RenameFile()<cr>

map <leader>R :call RunRspecCurrentFileConque()<CR>
map <leader>r :call RunRspecCurrentLineConque()<CR>
let delimitMate_expand_space = 1
