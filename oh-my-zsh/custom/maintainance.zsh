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
    brew upgrade --cask;
  fi
  brew cleanup;
}

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
