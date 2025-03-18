if [[ -f /etc/os-release ]]; then
  function daily_update() {
    apt update \
        && apt full-upgrade -y \
        && apt autoremove --purge -y
  }
fi
