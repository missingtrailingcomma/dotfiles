# Shen's dotfiles

## Get Started

```sh
git clone https://github.com/love4shen/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```sh
source bootstrap.sh
```

## Overview

`bootstrap.sh` sets up a few things:

- rsync various dotfiles
- install `homebrew` and a few brew formulas as well as GUI if the OS is macos via `brew.sh`
- install `oh-my-zsh` along with some plugins
- make `zsh` the default shell
- configure `git`
- create the project dir and fill in a few projects
- tune macos defaults via `macos.sh`

## Credit

https://github.com/mathiasbynens/dotfiles
