cp -n .env_example .env
source .env

sudo apt install $(grep -Ev '^\s*#' packages/apt | xargs)
sudo snap install $(grep -Ev '^\s*#' packages/snap | xargs)

cp -n emacs/secrets.el.example emacs/secrets.el
git clone https://github.com/doomemacs/doomemacs ~/.config/emacs
ln -s ~/workspace/emacs ~/.config/doom
~/.config/emacs/bin/doom install --force

ln -s ~/workspace/dotfiles/bashrc ~/.bashrc
ln -s ~/workspace/dotfiles/gitconfig ~/.gitconfig
ln -s ~/workspace/dotfiles/pryrc ~/.pryrc
ln -s ~/workspace/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/workspace/dotfiles/vimrc ~/.vimrc
ln -s ~/workspace/dotfiles/k9s ~/.k9s
ln -s ~/workspace/dotfiles/tool-versions ~/.tool-versions

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

asdf plugin add golang
asdf install golang 1.22.3

asdf plugin add ruby
asdf install ruby 3.1.2

go install github.com/sachaos/viddy@latest
