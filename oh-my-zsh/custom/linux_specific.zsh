if [[ "$(uname -s)" != "Linux" ]]; then
  return
fi

# http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH
