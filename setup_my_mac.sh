#! /bin/bash

install_homebrew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    sudo chown -R $(whoami) /usr/local/lib
    sudo chown -R $(whoami) /usr/local/sbin
    sudo chown -R $(whoami) /usr/local/bin
}

install_zsh() {
    brew install zsh
    echo $(which zsh) | sudo tee -a /etc/shells
    chsh -s $(which zsh)
    cat ./aliases >> ~/.zshrc
    cat ./exports >> ~/.zshrc
}

install_omz() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sed -i '' -e 's/robbyrussell/candy/g' -e 's/git$/git mercurial history mvn/g' ~/.zshrc
}

install_vim_spf() {
    brew install vim --with-lua --with-override-system-vi && curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh && rm -f spf13-vim.sh
}

install_cpp() {
    brew install gcc gdb boost
    mv /usr/local/bin/gcc-8 /usr/local/bin/gcc
    mv /usr/local/bin/g++-8 /usr/local/bin/g++
    echo "get gcc work with instructions in https://gist.github.com/danisfermi/17d6c0078a2fd4c6ee818c954d2de13c"
}

echo checking Homebrew
brew -v || install_homebrew
printf Homebrew installed

echo checking Zsh
zsh --version || install_zsh
echo Zsh installed

echo checking Oh-my-zsh
if ! [ -d ~/.oh-my-zsh ]
then
    install_omz
fi
echo Oh-my-zsh installed

echo checking Git
git --version || brew install git
echo Git installed

echo checking Maven
mvn -v || brew install maven
echo Maven installed

echo checking Vim
if [ `vim --version | grep +lua | wc -l` -eq 0 ]
then
    install_vim_spf
fi
echo Vim installed

# cpp
echo checking C development environment
if [ `gcc -v | grep llvm | wc -l` -eq 1 ]
then
    install_cpp
fi
echo C development environment installed

# Kotlin
echo checking Kotlin development environment
kotlinc -version || brew install kotlin gradle
echo Kotlin development environment installed
