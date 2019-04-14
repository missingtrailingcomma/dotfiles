#!/usr/bin/env bash
# ref: https://g3doc.corp.google.com/company/teams/mac-road-warrior/index.md?cl=head#homebrew

#cd ~
#mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

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

# install zsh and completion
brew install zsh zsh-completions

# Install `wget` with IRI support.
brew install wget --with-iri

# Install other useful binaries.
brew install exiv2
brew install git
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install zopfli
brew install fasd
brew install mas # mac app store cmd management

# coding stuff
brew install node

# download
brew install youtube-dl
brew install aria2

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

# quicklook
# ref: https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv
brew cask install webpquicklook suspicious-package
brew cask install betterzipql

## music
brew cask install musicbrainz-picard

# app store
mas lucky theunarchiver
mas lucky WeChat

brew cleanup

