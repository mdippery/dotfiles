# Disable shell session support on macOS.
#
# On macOS, /etc/zshrc calls /etc/zshrc_Apple_Terminal, which manages the
# saving and loading of sessions. I hate sessions -- I want everything to
# disappear when I close the Terminal -- so I like to disable these.
#
# See [1] for general discussion.
#
# [1]: https://superuser.com/q/1610587

if [ -e /etc/zshrc_Apple_Terminal ]; then
  export SHELL_SESSIONS_DISABLE=1
fi
