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

# list homebrew installed packages and their size
# ref: https://gist.github.com/eguven/23d8c9fc78856bd20f65f8bcf03e691b
function brewsize() {
  for pkg in `brew list -f1 | egrep -v '\.|\.\.'`
    do echo $pkg `brew info $pkg | egrep '[0-9]* files, ' | sed 's/^.*[0-9]* files, \(.*\)).*$/\1/'`
  done
}

function update() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    sudo softwareupdate -i -a;
  fi

  brew update;
  brew upgrade;
  if [[ "$(uname -s)" == "Darwin" ]]; then
    brew cask upgrade;
  fi
  brew cleanup;
}
