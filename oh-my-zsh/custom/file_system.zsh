# navigation
# ref: ~/.oh-my-zsh/lib/directories.zsh
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias doc="cd ~/Documents"
alias p="cd ~/Projectx"
alias temp="cd /tmp/"

if [[ ! "$(uname -s)" == "Darwin" ]]; then
  # Change working directory to the top-most Finder window location
  function cdf() { # short for `cdfinder`
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
  }
fi

alias 700="chmod 700 "

function trash() {
	command mv "$@" ~/.Trash ;
}

# `o` with no arguments opens the current directory, otherwise opens the given location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

if [[ ! "$(uname -s)" == "Darwin" ]]; then
  # Show/hide hidden files in Finder
  alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"

  alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
fi
