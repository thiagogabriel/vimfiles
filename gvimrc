" Start without the toolbar
set guioptions=aAc
color ir_black

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
 
  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

    " Command-Option-ArrowKey to switch viewports
  map <D-M-Up> <C-w>k
  imap <D-M-Up> <Esc> <C-w>k
  map <D-M-Down> <C-w>j
  imap <D-M-Down> <Esc> <C-w>j
  map <D-M-Right> <C-w>l
  imap <D-M-Right> <Esc> <C-w>l
  map <D-M-Left> <C-w>h
  imap <D-M-Left> <C-w>h

  " Adjust viewports to the same size
  map <Leader>= <C-w>=
  imap <Leader>= <Esc> <C-w>=
  set guifont=Inconsolata:h16
elseif has("unix")
  set guifont="monospace\ 10"
end
