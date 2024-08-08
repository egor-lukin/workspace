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
ln -s ~/workspace/dotfiles/k9s ~/.k9s
ln -s ~/workspace/dotfiles/tool-versions ~/.tool-versions

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

. "$HOME/.asdf/asdf.sh"

asdf plugin add golang
asdf install golang 1.22.3

gem install dip

asdf plugin add ruby
asdf install ruby 3.1.2

go install github.com/sachaos/viddy@latest
go install github.com/derailed/k9s@latest

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform
