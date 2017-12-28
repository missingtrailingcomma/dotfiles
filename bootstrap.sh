#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin master;

function doIt() {
	local OH_MY_ZSH_DIR=~/.oh-my-zsh;

	echo "rsync dot files"
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".vscode" \
		--exclude "oh-my-zsh" \
		--exclude ".macos" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;

	# brew
	if [[ "$(uname -s)" == "Darwin" ]]; then
		echo "brew installing"
		# ./brew.sh;

		echo "brew updating"
		# brew update
	fi

	# install and setup oh-my-zsh
	# since zsh is guarenteed to be installed on mac, thus the `if` checking
	if [[ "$(uname -s)" == "Darwin" ]]; then
		if [ ! -d $OH_MY_ZSH_DIR ]; then
			echo "install oh-my-zsh";
			# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		fi

		if [ -d $OH_MY_ZSH_DIR ]; then
			echo "rsync oh-my-zsh config"
			rsync --exclude ".DS_Store" \
				--exclude ".vscode" \
				-avh --no-perms ./oh-my-zsh/* ~/.oh-my-zsh;
		fi
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
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/zsh;
fi;