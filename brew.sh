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
brew install zopfli
brew install fasd

# coding stuff
brew install node

# download
brew install youtube-dl
brew install aria2

# archive
brew install monolith

if [[ "$(uname -s)" == "Darwin" ]]; then
  # mac app store cmd management
  brew install mas

  # quicklook
  # ref: https://github.com/sindresorhus/quick-look-plugins
  brew cask install qlcolorcode
  brew cask install qlstephen
  brew cask install qlmarkdown
  brew cask install quicklook-json
  brew cask install quicklook-csv
  brew cask install webpquicklook

  # clean up
  brew cask install appcleaner

  # system
  brew cask install spectacle

  # tasks management
  mas lucky spark

  # files
  brew cask install keka

  # media
  brew cask install google-chrome
  brew cask install vlc
  brew cask install google-drive-file-stream

  # backup
  brew cask install google-backup-and-sync

  # dev
  brew cask install visual-studio-code

  # music
  brew cask install musicbrainz-picard

  # gaming
  brew cask install steam

  # social
  mas lucky WeChat
fi

brew cleanup
