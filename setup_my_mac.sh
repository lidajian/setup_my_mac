#! /bin/bash

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo chown -R $(whoami) /usr/local/lib
sudo chown -R $(whoami) /usr/local/sbin
sudo chown -R $(whoami) /usr/local/bin

# Zsh
brew install zsh
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i '' -e 's/robbyrussell/candy/g' -e 's/git$/git mercurial history mvn/g' ~/.zshrc

# Git
git --version || brew install git

# Mvn
mvn -v || brew install maven

# Vim
brew install vim --with-lua --with-override-system-vi
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
rm spf13-vim.sh

# gcc
brew install gcc
mv /usr/local/bin/gcc-8 /usr/local/bin/gcc
mv /usr/local/bin/g++-8 /usr/local/bin/g++

# .zshrc
cat ./aliases >> ~/.zshrc
cat ./exports >> ~/.zshrc
