#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# install zsh
brew install zsh zsh-completions

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh

# Install other useful binaries.
brew install exiv2
brew install git
brew install ssh-copy-id
brew install tree
brew install webkit2png
# brew install zopfli
brew install autojump

# coding stuff
brew install node
brew install v8
brew install bazel

# download
brew install youtube-dl
brew install aria2

# web
brew install tor

# brew cask check
homebrew/completions/brew-cask-completion

# gui
brew cask install visual-studio-code
brew cask install vlc
brew cask install spectacle
brew cask install google-chrome
brew cask install google-backup-and-sync
# use ps4 controller in mac
brew cask install enjoyable

## quicklook
brew cask install qlstephen
brew cask install qlcolorcode
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install betterzipql

# Remove outdated versions from the cellar.
brew cleanup
