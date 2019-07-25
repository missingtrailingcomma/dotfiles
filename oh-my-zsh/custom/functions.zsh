function trash() {
	command mv "$@" ~/.Trash ;
}

# start vs code
function code() {
  if [[ $# = 0 ]]; then
    open -a "Visual Studio Code"
  else
    [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
    open -a "Visual Studio Code" --args "$F"
  fi
}

# `o` with no arguments opens the current directory, otherwise opens the given location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
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

# helper function for abbrev_pwd
function title_escape() {
  case "$TERM" in
    screen*) printf "\001\033k%s\033\\\\\002" "$1";;
    *) echo ""
  esac
}

# stuff for abbreviating PS1 for CITC paths
# from https://groups.google.com/a/google.com/forum/#!msg/citc-users/ryX8MasmCcs/nJ2BACz9xcsJ thanks to chronos@
# with title_escape calls added by mattdv
function abbrev_pwd() {
  case "$PWD" in
    $HOME|$HOME/*)
      printf "~%s%s" "$(title_escape \~)" "${PWD#$HOME}"
      ;;
    /google/src/cloud/$USER/*)
      local client
      client="${PWD#/google/src/cloud/$USER/}"
      client="${client%%/*}"
      printf "%%{$fg[yellow]%%}[%s%s]%%{$reset_color%%}%%{$fg[white]%%}%s%%{$reset_color%%}" "$client" "$(title_escape $client)" "${PWD#/google/src/cloud/$USER/$client}"
      ;;
    *)
      printf "%s%s" "$PWD" "$(title_escape ^_^)"
      ;;
  esac
}
