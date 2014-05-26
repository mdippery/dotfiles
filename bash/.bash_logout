# Ubuntu generates (roughly) the following by default. Probably
# not that important, but might as well leave it in.
if [ "$SHLVL" = 1 ]; then
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

printf '\e]0;\a'    # Reset window title when disconnecting with SSH
