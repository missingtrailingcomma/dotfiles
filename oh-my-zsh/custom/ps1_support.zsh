function abbrev_pwd() {
  case "$PWD" in
    $HOME|$HOME/*)
      printf "~%s%s" "$(title_escape \~)" "${PWD#$HOME}"
      ;;
    *)
      printf "%s%s" "$PWD" "$(title_escape ^_^)"
      ;;
  esac
}

function title_escape() {
  case "$TERM" in
    screen*) printf "\001\033k%s\033\\\\\002" "$1";;
    *) echo ""
  esac
}
