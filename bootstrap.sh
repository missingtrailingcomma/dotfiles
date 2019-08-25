#!/usr/bin/env bash

local OH_MY_ZSH_DIR=~/.oh-my-zsh;
local HOME_BIN_DIR=~/bin;
local PROJECT_BIN_DIR=~/projects;

function doIt() {
	echo "creating ~/bin"
	mkdir -p $HOME_BIN_DIR

	echo "rsyncing dot files"
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".vscode" \
		--exclude "ssh-screen" \
		--exclude "oh-my-zsh" \
		--exclude "macos.sh" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~ &>/dev/null;

  # try install `brew` in mac or linux
  if ! type brew &>/dev/null; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
      # install homebrew
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

      # xcode dev
      # ref: https://github.com/atomantic/dotfiles/blob/master/install.sh
      xcode-select --install 2>&1 > /dev/null
      sudo xcode-select -s /Applications/Xcode.app/Contents/Developer 2>&1 > /dev/null
      sudo xcodebuild -license accept 2>&1 > /dev/null
	  else if [[ "$(uname -s)" == "Linux" ]]; then
      # ref: https://docs.brew.sh/Homebrew-on-Linux
      git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
      mkdir ~/.linuxbrew/bin
      ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
      eval $(~/.linuxbrew/bin/brew shellenv)
    fi
  fi

  if ! type brew &>/dev/null; then
    echo "installing homebrew and formulas"
    ./brew.sh;
  fi

	# install and setup oh-my-zsh
  if [ ! -d $OH_MY_ZSH_DIR ]; then
    echo "installing oh-my-zsh";
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [ -d $OH_MY_ZSH_DIR ]; then
    echo "rsyncing oh-my-zsh config"
    rsync --exclude ".DS_Store" \
      --exclude ".vscode" \
      -avh --no-perms ./oh-my-zsh/* ~/.oh-my-zsh &>/dev/null;

    cd ${ZSH_CUSTOM1:-$ZSH/custom}/plugins
    git clone https://github.com/djui/alias-tips.git
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  fi

	if [[ -d $HOME_BIN_DIR ]]; then
		echo "rsyncing ssh-screen"
		rsync --exclude ".DS_Store" \
				--exclude ".vscode" \
				-avh --no-perms ./ssh-screen ~/bin &>/dev/null;
		chmod +x ~/bin/ssh-screen
	fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;

unset doIt;

# Switch to using brew-installed zsh as default shell
if ! fgrep -q '~/homebrew/bin/zsh' /etc/shells && [[ $SHELL != '~/homebrew/bin/zsh' ]]; then
  echo "switching to zsh"
  echo "~/homebrew/bin/zsh" | sudo tee -a /etc/shells;
  chsh -s ~/homebrew/bin/zsh;
fi;

# set git credentials
GIT_AUTHOR_NAME="Yizheng Shen"
GIT_AUTHOR_EMAIL="tinirdoc@gmail.com"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global core.excludesfile ~/.gitignore_global

echo "creating project directory"
mkdir -p $PROJECT_BIN_DIR
cd $PROJECT_BIN_DIR

if [ ! -d "BaiduExporter" ]; then
  git clone https://github.com/acgotaku/BaiduExporter.git
fi

if [ ! -d "webpage2html" ]; then
  git clone https://github.com/zTrix/webpage2html.git
fi

if [ ! -d "octoscreen" ]; then
  git clone git@github.com:orderedlist/octoscreen.git
fi
