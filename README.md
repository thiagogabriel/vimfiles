Installation
============

Clone the repo:
`git clone https://github.com/lunks/vimfiles.git ~/.vim`

Grab Vundle:
`git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`

Make sure vim finds the vimrc file by either symlinking it:
`ln -s ~/.vim/vimrc ~/.vimrc`


or by sourcing it from  your own ~/.vimrc:
`source ~/.vim/vimrc`

Install plugins:
`vim +BundleInstall +qall`
