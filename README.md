# Usage

Copy-paste the following into your terminal.
  ```
  $ git clone https://github.com/JBakamovic/dotfiles.git && \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    rsync -av dotfiles/. ~/ --exclude '/.git' --exclude '/LICENSE' --exclude '/README.md'
 ```
