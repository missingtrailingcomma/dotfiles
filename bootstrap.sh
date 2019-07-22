#!/usr/bin/env bash

# git pull origin master;

function doIt() {
	local OH_MY_ZSH_DIR=~/.oh-my-zsh;
	local HOME_BIN_DIR=~/bin;

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

	if [[ "$(uname -s)" == "Darwin" ]] && ! type brew &>/dev/null; then

    # xcode dev
    # ref: https://github.com/atomantic/dotfiles/blob/master/install.sh
    xcode-select --install 2>&1 > /dev/null
    sudo xcode-select -s /Applications/Xcode.app/Contents/Developer 2>&1 > /dev/null
    sudo xcodebuild -license accept 2>&1 > /dev/null

    # brew
		echo "installing brew and formulas"
		./brew.sh;

		echo "updating brew"
		brew update
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
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells && [[ $SHELL != '/usr/local/bin/zsh' ]]; then
  echo "switching to zsh"
  echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/zsh;
fi;

# set git credentials
GIT_AUTHOR_NAME="Yizheng Shen"
GIT_AUTHOR_EMAIL="tinirdoc@gmail.com"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global core.excludesfile ~/.gitignore_global

# git clone https://github.com/acgotaku/BaiduExporter.git
# git clone https://github.com/zTrix/webpage2html.git
