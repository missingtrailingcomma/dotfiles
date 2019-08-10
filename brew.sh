#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

if [[ "$(uname -s)" == "Darwin" ]]; then
  # Install more recent versions of some macOS tools.
  brew install vim --with-override-system-vi
  brew install homebrew/dupes/grep
  brew install homebrew/dupes/openssh
  # Install GNU core utilities (those that come with macOS are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  brew install coreutils

  # Install some other useful utilities like `sponge`.
  brew install moreutils

  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  brew install findutils

  # Install GNU `sed`, overwriting the built-in `sed`.
  brew install gnu-sed --with-default-names

  # Install `wget` with IRI support.
  brew install wget --with-iri

  # quicklook
  # ref: https://github.com/sindresorhus/quick-look-plugins
  brew cask install qlcolorcode
  brew cask install qlstephen
  brew cask install qlmarkdown
  brew cask install quicklook-json
  brew cask install quicklook-csv
  brew cask install webpquicklook suspicious-package
  brew cask install betterzipql

  # default
  brew cask install vlc
  brew cask install google-chrome
  brew cask install google-backup-and-sync
  brew cask install google-drive-file-stream
  brew cask install appcleaner

  # dev
  brew cask install visual-studio-code
  brew cask install spectacle
  brew cask isntall imageoptim

  ## music
  brew cask install musicbrainz-picard

  # mac app store cmd management
  brew install mas

  # app store
  mas lucky theunarchiver
  mas lucky WeChat
fi

# install zsh and completion
brew install zsh zsh-completions

# Install other useful binaries.
brew install exiv2
brew install git
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install zopfli
brew install fasd

# coding stuff
brew install node

# download
brew install youtube-dl
brew install aria2

## video playing
brew install mpv

## video streaming
brew install streamlink

brew cleanup
