#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# install zsh and completion
brew install zsh zsh-completions

# override system defaults
local BREW_PREFIX=$(brew --prefix)
brew install coreutils # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

brew install moreutils # Install some other useful utilities like `sponge`.
brew install findutils # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install gnu-sed --with-default-names # Install GNU `sed`, overwriting the built-in `sed`.
brew install wget --with-iri # Install `wget` with IRI support.

brew install git
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen

# useful binaries
brew install exiv2
brew install ssh-copy-id
brew install tree
brew install fzf
yes |  $(brew --prefix)/opt/fzf/install

# coding stuff
# brew install node

# download
brew install youtube-dl
brew install aria2

# archive
brew install monolith

if [[ "$(uname -s)" == "Darwin" ]]; then
  # quicklook
  # ref: https://github.com/sindresorhus/quick-look-plugins
  # brew install qlcolorcode --cask
  # brew install qlstephen --cask
  # brew install qlmarkdown --cask
  # brew install quicklook-json --cask
  # brew install quicklook-csv --cask
  # brew install webpquicklook --cask

  # clean up
  brew install appcleaner --cask

  # system
  brew install spectacle --cask

  # files
  brew install keka --cask

  # media
  brew install vlc --cask

  # dev
  brew install visual-studio-code --cask

  # music
  brew install musicbrainz-picard --cask

  # gaming
  # brew install steam --cask

  # mac app store cmd management
  brew install mas

  # social
  # mas lucky WeChat

  # safari extension
  # mas install 1432731683 # Adblock Plus for Safari ABP

  # news
  echo -e "\nDon't forget to install Reeder 4 manually!\n"
fi

brew cleanup
