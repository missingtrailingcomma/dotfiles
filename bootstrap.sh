#!/usr/bin/env bash

function gitCloneIfNotExist() {
  if [[ ! -d $2 ]]; then
    mkdir -p $2
    git clone $1 $2
  fi
}

function doIt() {
  local OH_MY_ZSH_DIR=~/.oh-my-zsh;
  local HOME_BIN_DIR=~/bin;
  local PROJECT_DIR=~/Projectx;
  local GIT_AUTHOR_NAME="Yizheng Shen"
  local GIT_AUTHOR_EMAIL="tinirdoc@gmail.com"

  echo "- creating ~/bin"
  mkdir -p $HOME_BIN_DIR

  echo "- rsyncing dot files"
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".vscode" \
    --exclude "ssh-screen" \
    --exclude "oh-my-zsh" \
    --exclude "init" \
    --exclude "macos.sh" \
    --exclude "bootstrap.sh" \
    --exclude "brew.sh" \
    --exclude ".zshrc" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms . ~ &>/dev/null;

  read -p "Should rsync .zshrc? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rsync ".zshrc" . ~ &>/dev/null;
  fi

  rsync --exclude ".DS_Store" \
      --exclude ".vscode" \
      -avh --no-perms ./ssh-screen ~/bin &>/dev/null;
  chmod +x ~/bin/ssh-screen

  if ! type brew &>/dev/null; then
    echo "- installing homebrew"
    if [[ "$(uname -s)" == "Darwin" ]]; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

      # ref: https://github.com/atomantic/dotfiles/blob/master/install.sh
      xcode-select --install 2>&1 > /dev/null
      sudo xcode-select -s /Applications/Xcode.app/Contents/Developer 2>&1 > /dev/null
      sudo xcodebuild -license accept 2>&1 > /dev/null
    elif [[ "$(uname -s)" == "Linux" ]]; then
      # ref: https://docs.brew.sh/Homebrew-on-Linux
      git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
      mkdir ~/.linuxbrew/bin
      ln -s ../Homebrew/bin/brew ~/.linuxbrew/bin
      eval $(~/.linuxbrew/bin/brew shellenv)
    fi
  fi

  if ! type brew &>/dev/null; then
    echo "installing homebrew formulas"
    ./brew.sh;
  fi

  if [[ ! -d $OH_MY_ZSH_DIR ]]; then
    echo "installing oh-my-zsh";
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  if [[ -d $OH_MY_ZSH_DIR ]]; then
    echo "- rsyncing oh-my-zsh config"
    rsync --exclude ".DS_Store" \
      --exclude ".vscode" \
      -avh --no-perms ./oh-my-zsh/* ~/.oh-my-zsh &>/dev/null;

    local ZSH_PLUGIN_PATH=${ZSH_CUSTOM1:-$ZSH/custom}/plugins
    gitCloneIfNotExist https://github.com/djui/alias-tips.git $ZSH_PLUGIN_PATH/alias-tips
    gitCloneIfNotExist https://github.com/zsh-users/zsh-completions $ZSH_PLUGIN_PATH/zsh-completions
    gitCloneIfNotExist https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGIN_PATH/zsh-syntax-highlighting
    gitCloneIfNotExist https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGIN_PATH/zsh-autosuggestions
  fi

  # Switch to using brew-installed zsh as default shell
  if ! fgrep -q '~/homebrew/bin/zsh' /etc/shells && [[ $SHELL != '~/homebrew/bin/zsh' ]]; then
    echo "- switching to zsh"
    echo "~/homebrew/bin/zsh" | sudo tee -a /etc/shells;
    chsh -s ~/homebrew/bin/zsh;
  fi;

  echo "- setting up git"
  git config --global user.name "$GIT_AUTHOR_NAME"
  git config --global user.email "$GIT_AUTHOR_EMAIL"
  git config --global core.excludesfile ~/.gitignore_global

  # TODO: set up github as well

  echo "- creating project dir: $PROJECT_DIR"
  mkdir -p $PROJECT_DIR

  echo "- filling project dir: $PROJECT_DIR"
  gitCloneIfNotExist https://github.com/orderedlist/octoscreen.git $PROJECT_DIR/octoscreen

  if [[ "$(uname -s)" == "Darwin" ]]; then
    read -p "Tune macos defaults? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "- tuning macos defaults"
      ./macos.sh
    fi
  fi

  echo -e "\nDone done."
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  doIt
fi
unset doIt
