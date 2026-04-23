# Disable shell session support on macOS.
#
# On macOS, /etc/zshrc calls /etc/zshrc_Apple_Terminal, which manages the
# saving and loading of sessions. I hate sessions -- I want everything to
# disappear when I close the Terminal -- so I like to disable these.
# Unfortunately, this environment variable MUST be set in ~/.zprofile, because
# it needs to be set BEFORE /etc/zshrc is loaded.
#
# It could also be set in ~/.zshenv, I think, because ~/.zshenv is also loaded
# before /etc/zshrc (in fact, ~/.zshenv is loaded before ~/.zprofile), but
# according to some [1], ~/.zprofile is the most necessary and "right" place
# to put it.
#
# See [2] for general discussion.
#
# (Honestly, if I get tired of maintaining this file, I'll just put it in
# ~/.zshenv. Fuck it YOLO we ball.)
#
# [1]: https://superuser.com/a/1863977
# [2]: https://superuser.com/q/1610587

# Move this to a plat/darwin directory when one becomes available.
if [ -e /etc/zshrc_Apple_Terminal ]; then
  export SHELL_SESSIONS_DISABLE=1
fi
