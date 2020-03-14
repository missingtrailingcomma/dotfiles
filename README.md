# Shen's dotfile

### Get Started

```sh
git clone https://github.com/love4shen/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```sh
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```sh
set -- -f; source bootstrap.sh
```

### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```sh
./.macos
```

TODO: make `.macos` into `bootstrap.sh`

## Credit

https://github.com/mathiasbynens/dotfiles
