# Sourced on all invocations of the shell, unless -f option is set.
# It should contain commands to set the search path, plus other important
# environment variables. Should not contain commands that produce output
# or assume the shell is attached to a tty.
#
# See <http://zsh.sourceforge.net/Intro/intro_3.html> for more details.

export DOTZSH="${HOME}/.zsh"

export OS=$(uname -s | tr '[:upper:]' '[:lower:]')
